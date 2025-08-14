CREATE PROCEDURE [data_mis_project].[update_forecast_report] as

IF OBJECT_ID('[data_mis_project].[forecast_report]', 'U') IS NOT NULL TRUNCATE TABLE [data_mis_project].[forecast_report];
------ ================================================
-- Ustawienie zmiennych dat
-- ================================================

DECLARE @day_date DATE = GETDATE();                     -- Bieżąca data (dzisiejszy dzień)
DECLARE @StartOfCurrentYear DATE;                       -- Początek bieżącego roku
DECLARE @EndOfCurrentYear DATE;                         -- Koniec bieżącego roku
DECLARE @day_date_minus_1_months DATE;                  -- Data sprzed 1 miesiąca (na potrzeby danych "actuals")

-- Obliczenie wartości zmiennych
SET @day_date_minus_1_months = DATEFROMPARTS(YEAR(DATEADD(MONTH, -1, @day_date)), MONTH(DATEADD(MONTH, -1, @day_date)), 1)
SET @StartOfCurrentYear = DATEFROMPARTS(YEAR(GETDATE()), 1, 1);
SET @EndOfCurrentYear = DATEFROMPARTS(YEAR(GETDATE()), 12, 31);
-- ================================================
-- CTE 1: Najnowszy kontrakt dla każdego projektu
-- ================================================

WITH latest_project_contract AS (
    SELECT 
        project_id,
        type,
        sign_date,
        ROW_NUMBER() OVER (
            PARTITION BY project_id 
            ORDER BY sign_date DESC
        ) AS rn -- Numerujemy kontrakty w ramach projektu, najnowszy ma rn = 1
    FROM [data_in].[proj_contract_vw]
),

CRNCY_FIX_RATE AS (
SELECT
	start_date AS FX_CRNCY_START_DATE
	,end_date AS FX_CRNCY_END_DATE
	,base_currency_code AS CRNCY_CODE
	,exchange_rate
	, quote_currency_code
FROM data_mis.exchange_rate
WHERE quote_currency_code = 'PLN' 
and (start_date>=@StartOfCurrentYear and end_date<=@EndOfCurrentYear)
),

-- ================================================
-- CTE 2: Dane typu actuals (z pliku CSV w Azure Blob)
-- ================================================

actuals_unpivoted AS (
    SELECT 
		null as BM_ID,
		 'Current' as Forecast_version,
        [Project ID] AS project_id,
        [Day Date] AS day_date,
        [Currency] AS currency,
		null as booking_status,
        -- Rozdzielenie kategorii i typu danych z jednej kolumny (np. 'Revenue - Actuals')
        LTRIM(RTRIM(SUBSTRING([data_type], 1, CHARINDEX('-', [data_type]) - 1))) AS category,
        LTRIM(RTRIM(SUBSTRING([data_type], CHARINDEX('-', [data_type]) + 1, LEN([data_type])))) AS type,
        unpvt.data_type,
		'' as subcategory,
        unpvt.value_pln,
		null as 'employee_id',
		null as [employee_full_name],
		null as [competency_name],
        null as [role_name],
        null as [seniority_name]
		--		null as current_rate_ind,
		--null as rate
    FROM [data_mis_project].[forecast_actuals]
    UNPIVOT (
        value_pln FOR data_type IN (
            [Revenue - Actuals],
            [Cost - Actuals],
            [FTE - Actuals],
            [Presales - Actuals],
            [AdditionalCosts - Actuals]
        )
    ) AS unpvt
),

latest_actuals_month AS (
    SELECT MAX(EOMONTH(day_date)) AS max_actuals_date
    FROM actuals_unpivoted
),

-- ================================================
-- CTE 3: Forecastowane przychody po stałych kursach
-- ================================================

reve_forecast_fixed AS (
    SELECT 
        [ID] as BM_ID,
	 'Current' as Forecast_version,
        [PROJ_ID] as project_id,
     --   [CRNCY_DAY_DATE],
      --  FORMAT(day_date, 'yyyy-MM') AS month_name,
     CONVERT(date, DAY_DATE,101)  AS day_date ,
        [CRNCY_CODE] as currency,
		null as booking_status,
        --[AMT_BEFORE_DISC],
        --[AMT_DISC],
        --[AMT_AFTER_DISC],
        --[CRNCY_RATE],
        --[AMT_BEFORE_DISC_PLN],
        --[AMT_DISC_PLN],
		'Revenue' as category,
		'Forecast' as type,
        'Revenue - Forecast' AS data_type,
        [TYPE] as subcategory,
		[AMT_AFTER_DISC_PLN] as value_pln,
		null as 'employee_id',
		null as [employee_full_name],
		null as [competency_name],
        null as [role_name],
        null as [seniority_name]
		--null as current_rate_ind,
		--null as rate
    FROM [data_mis_project].[revenue_fixed]
WHERE DAY_DATE > (SELECT max_actuals_date FROM latest_actuals_month)
  AND DAY_DATE <= @EndOfCurrentYear
),

-- ================================================
-- CTE 4: Dane FTE z bookingów pracowników
-- ================================================

FTE_booking AS (
    SELECT 
		null as BM_ID,
		'Current' as Forecast_version,
        b.[project_id],
        --b.[month_name],
        EOMONTH(CAST(b.month_name + '-01' AS date)) AS day_date,
		null as currency,
        b.[status] as booking_status,
        'FTE' AS category,
		'Forecast' as type,
		'FTE - Booking' as data_type,
		null as subcategory,
		 SUM(b.booking_hours / (b.month_cnt * 8.0)) AS value_pln,
		b.[employee_id],
        b.[employee_full_name],
		b.[competency_name],
        b.[role_name],
        b.[seniority_name]
		--null as current_rate_ind,
		--null as rate
    FROM [data_mis_project].[emp_proj_booking_vw] b
    JOIN [data_mis].[proj] p
        ON b.project_id = p.project_id
		CROSS JOIN latest_actuals_month
    WHERE 
b.day_date > @StartOfCurrentYear
AND b.day_date <= @EndOfCurrentYear
        AND p.project_billable_ind = 1 -- tylko projekty billowalne
    GROUP BY 
        b.project_id, 
        b.month_name,
        b.employee_id,
        b.employee_full_name,
        b.competency_name,
        b.role_name,
        b.seniority_name,
		b.status

),

-- ================================================
-- CTE 5: Dane FTE z bookingów pracowników
-- ================================================

Billable_cost_forecast AS (
    SELECT 
		null as BM_ID,
		'Current' as Forecast_version,
        b.[project_id],
        --b.[month_name],
        EOMONTH(CAST(b.month_name + '-01' AS date)) AS day_date,
		null as currency,
        b.[status] as booking_status,
        'Cost' AS category,
		'Forecast' as type,
		'Cost - Forecast' as data_type,
		null as subcategory,
		 SUM(b.booking_hours / (b.month_cnt * 8.0)) * rate AS value_pln,
		b.[employee_id],
        b.[employee_full_name],
		b.[competency_name],
        b.[role_name],
        b.[seniority_name]
		--c.current_rate_ind,
		--c.rate
    FROM [data_mis_project].[emp_proj_booking_vw] b
	CROSS JOIN latest_actuals_month
    JOIN [data_mis].[proj] p
        ON b.project_id = p.project_id
	LEFT join (select * from data_mis_project.competency_rate where rate_end_date is null) c on b.location_id=c.country_id and b.competency_name=c.competency_name and b.role_name=c.role_name and b.seniority_name=c.seniority_name
    WHERE 
b.day_date > max_actuals_date
AND b.day_date <= @EndOfCurrentYear
        AND p.project_billable_ind = 1 -- tylko projekty billowalne
    GROUP BY 
        b.project_id, 
        b.month_name,
        b.employee_id,
        b.employee_full_name,
        b.competency_name,
        b.role_name,
        b.seniority_name,
		c.current_rate_ind,
		c.rate,
        b.status
),


union_wszystkie_elementy_forecastu as (
select * from actuals_unpivoted
union all
select * from reve_forecast_fixed
union all
select * from FTE_booking
union all
select * from Billable_cost_forecast),



-- ================================================
-- CTE 6: Lista projektów z metadanymi i dodatkowymi warunkami
-- ================================================

project_list AS (
    SELECT 
        'Current' AS [Forecast_version],
        a.[project_id],
        a.[project_name],
        a.[parent_project_name],
        c.[ultimate_parent_name],
        SUM(CASE WHEN r.[data_type] = 'Revenue - Actuals' THEN r.[value_pln] ELSE 0 END) OVER (PARTITION BY c.[ultimate_parent_name]) AS [sum_revenue_actuals],
        --RANK() OVER (ORDER BY s.value_pln_sum_for_ultimate_parent DESC) as ultimate_parent_name_with_rank,
        a.[client_id],
        a.[client_name],
        a.[start_date],
        a.[end_date],
        a.[proj_manager_id],
        a.[proj_manager_name],
        a.[business_unit_name] AS [project_bu_name],
        a.[sub_business_unit_name] AS [project_sub_bu_name],
        a.[delivery_team_name] AS [project_delivery_team_name],
        a.[team_name] AS [project_team_name],
        a.[invoicing_code],
        a.[project_billable_ind],
        a.[investment_ind],
        a.[governance_ind],
        r.[BM_ID],
        bm.[BM_NCNTRCTD_IND],
        bm.[BM_CNTRCTD_OM_IND],
        r.[employee_id],
        r.[booking_status],
        --Sprawdzenie, czy to pracownik czy awatar
        CASE 
            WHEN CHARINDEX('|', e.[employee_full_name]) > 0 THEN 'Avatar'
            WHEN e.[employee_full_name] IS NULL THEN NULL
            ELSE 'Employee'
        END AS [employee_or_avatar],
        r.[competency_name],
        r.[role_name],
        e.[position],
        e.[active_ind],
        e.[bu_name] AS [emp_bu_name],
        e.[sub_bu_name] AS [emp_sub_bu_name],
        e.[senior_delivery_team_name] AS [emp_senior_delivery_team_name],
        e.[delivery_team_name] AS [delivery_team_name],
        e.[country],
		b.type as is_core,
        -- Nadpisanie statusu na 'CONFIRMED' dla jednostki organizacyjnej 617 (Alchemy)
        CASE 
            WHEN a.[organization_unit_id] = 617 THEN 'CONFIRMED' 
            ELSE a.[status_code] 
        END AS [status_code],
        a.[organization_unit_id],
        b.[type] AS [type],
        -- Flaga: projekt nie typu 'CORE', rozpoczęty w 2025 roku i już się zaczął
        CASE 
            WHEN a.[project_id] IN (
                SELECT [project_id]
                FROM latest_project_contract
                WHERE [rn] = 1 AND [type] <> 'CORE'
            )
            AND a.[start_date] >= @StartOfCurrentYear
            AND a.[start_date] <= GETDATE()
        THEN 1 
        ELSE 0 
        END AS [start_in_2025_and_not_core],
        -- Opis: projekty nie-CORE, które są potwierdzone, ale nie są jeszcze widoczne w Vtool
        CASE 
            WHEN a.[project_id] IN (
                SELECT [project_id]
                FROM latest_project_contract
                WHERE [rn] = 1 AND [type] <> 'CORE'
            )
            AND a.[start_date] >= @StartOfCurrentYear
            AND a.[start_date] <= GETDATE()
        THEN 'Confirmed but not in Vtool'
        ELSE 'Not Confirmed'
        END AS [sell_and_bill_split],
        -- Dane z forecastu revenue (przyłączone po projekcie)
        FORMAT(r.[day_date], 'yyyy-MM') AS [year_month],
        r.[day_date],
        r.[category],
        r.[currency],
        r.[value_pln],
        --cr.CRNCY_CODE,
        --cr.exchange_rate,
        -- Obliczenie original value (FTE i PLN pozostaje bez zmian)
        CASE 
            WHEN (r.[category] <> 'FTE' OR r.[currency] <> 'PLN') THEN r.[value_pln] / ISNULL(cr.[exchange_rate], 1)
            WHEN (r.[category] = 'FTE' OR r.[currency] = 'PLN') THEN r.[value_pln]
            ELSE NULL 
        END AS [original_value],
        --value_usd, czyli przeliczenie wszystkich wartości na USD, o ile nie są one już w usd
        --(SELECT TOP 1 exchange_rate FROM data_mis.exchange_rate WHERE base_currency_code = 'USD' and quote_currency_code = 'PLN' ORDER BY start_date desc) as current_usd_value,
        CASE
            WHEN r.[category] <> 'FTE' 
            THEN r.[value_pln] / (
                SELECT TOP 1 [exchange_rate] 
                FROM data_mis.exchange_rate 
                WHERE [base_currency_code] = 'USD' 
                  AND [quote_currency_code] = 'PLN' 
                ORDER BY [start_date] DESC
            )
            ELSE r.[value_pln] 
        END AS [value_usd],
        r.[data_type]
    FROM data_mis.proj a
    LEFT JOIN latest_project_contract b 
        ON a.[project_id] = b.[project_id] AND b.[rn] = 1  -- tylko najnowszy kontrakt
    LEFT JOIN union_wszystkie_elementy_forecastu r 
        ON a.[project_id] = r.[project_id]
    LEFT JOIN data_mis_project.dim_billg_mlstn bm
        ON r.[BM_ID] = bm.[BILLG_MLSTN_ID]
    LEFT JOIN data_in.proj_clnt c
        ON a.[client_id] = c.[id]
    LEFT JOIN data_in.org_emp_vw e
        ON r.[employee_id] = e.[id]
    LEFT JOIN CRNCY_FIX_RATE cr
        ON r.[currency] = cr.[CRNCY_CODE]
    WHERE 
        [time_off_ind] <> 1    -- wyklucz projekty oznaczone jako "czas wolny"
        --AND [data_type] IS NOT NULL
        AND a.[start_date] >= '2024-01-01' 
        AND a.[start_date] <= @EndOfCurrentYear 
        AND a.[end_date] >='2024-01-01' -- tylko aktywne w bieżącym roku lub później 
        --AND [status_code] NOT IN ('REJECTED', 'CANCELLED', 'CLOSURE') -- pomijamy zamknięte/odrzucone
)

-- ================================================
-- Finalne zapytanie
-- ================================================
INSERT INTO data_mis_project.forecast_report
SELECT 
    [project_id],
    [project_name],
    [parent_project_name],
    [ultimate_parent_name],
    CAST(DENSE_RANK() OVER (ORDER BY [sum_revenue_actuals] DESC) AS VARCHAR) + ' - ' + [ultimate_parent_name] AS [ultimate_parent_name_with_rank],
    [client_id],
    [client_name],
    [start_date],
    [end_date],
    [proj_manager_id],
    [proj_manager_name],
    [project_bu_name],
    [project_sub_bu_name],
    [project_delivery_team_name],
    [project_team_name],
    [invoicing_code],
    [project_billable_ind],
    [investment_ind],
    [governance_ind],
    --[BM_ID],
    [BM_NCNTRCTD_IND],
    [BM_CNTRCTD_OM_IND],
    [employee_id],
    [booking_status],
    [employee_or_avatar],
    [competency_name],
    [role_name],
    [position],
    [active_ind],
    [emp_bu_name],
    [emp_sub_bu_name],
    [emp_senior_delivery_team_name],
    [delivery_team_name],
    [country],
    [status_code],
    [organization_unit_id],
    [type],
    [start_in_2025_and_not_core],
    [sell_and_bill_split],
    [year_month],
    [day_date],
    [category],
    [currency],
    [value_pln],
    [original_value],
    [value_usd],
    [data_type],
		is_core,
	  CASE
    -- Pierwszy warunek: status CLOSED/CLOSURE/CONFIRMED i BM_NCNTRCTD_IND = FALSE lub NULL
    WHEN status_code IN ('CLOSED', 'CLOSURE', 'CONFIRMED') AND 
         (BM_NCNTRCTD_IND = 0 OR BM_NCNTRCTD_IND IS NULL)
    THEN 'Secured'

    -- Drugi warunek: Is_Core = 'CORE' i BM_NCNTRCTD_IND = FALSE lub NULL
    WHEN is_core = 'CORE' AND 
         (BM_NCNTRCTD_IND = 0 OR BM_NCNTRCTD_IND IS NULL)
    THEN 'Secured'

    -- Trzeci warunek: status PLANNED lub PEND_APPRV albo status zamknięty + BM_NCNTRCTD_IND = TRUE
    WHEN status_code IN ('PLANNED', 'PEND_APPRV') OR 
         (status_code IN ('CLOSED', 'CLOSURE', 'CONFIRMED') AND BM_NCNTRCTD_IND = 1)
    THEN 'Sell & bill'

    -- Czwarty warunek: Revenue - Forecast
    WHEN Data_type = 'Revenue - Forecast'
    THEN 'Not analyzed'

    -- Domyślnie
    ELSE 'Secured'
  END AS status_Label 
FROM project_list
--where year_month='2025-06' and category='Revenue' and project_id=6571
GO

GRANT EXECUTE
    ON OBJECT::[data_mis_project].[update_forecast_report] TO [lingaro-mis-adf]
    AS [dbo];
GO


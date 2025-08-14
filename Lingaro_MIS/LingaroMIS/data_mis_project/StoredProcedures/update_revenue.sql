CREATE PROCEDURE [data_mis_project].[update_revenue] as

IF OBJECT_ID('data_mis_project.revenue', 'U') IS NOT NULL TRUNCATE TABLE data_mis_project.revenue;


--------------
/*Variables*/
--------------
DECLARE @status_1 VARCHAR(200);
DECLARE @status_2 VARCHAR(200);
DECLARE @proj_end_date DATE;
DECLARE @lingaro_hr_projects INT;
DECLARE @cost_type_code VARCHAR(200);


SET @status_1 = 'CANCELLED';
SET @status_2 = 'REJECTED';
SET @proj_end_date= '2020-12-31';
SET @lingaro_hr_projects=7;
SET @cost_type_code='ACTUALS';



---------------------
/*List_of_projects*/
---------------------
with
PROJECTS as(
SELECT
 project_id PROJ_ID
,cast(start_date as date) as PROJ_START_DATE
,CASE WHEN project_id<=@lingaro_hr_projects THEN '2100-12-31' ELSE cast(end_date AS DATE) END AS NEW_PROJ_END_DATE
,double_counting_ind DBL_CNTNG_IND
,parent_financial_project_id PARNT_FIN_PROJ_ID
FROM data_in.proj
WHERE status_code not in (@status_1,@status_2)
),

-----------------------------
/*Filter_new_proj_end_date*/
-----------------------------
NEW_PROJ_END_DATE as(SELECT *
,CASE WHEN DBL_CNTNG_IND=1 THEN PARNT_FIN_PROJ_ID ELSE PROJ_ID END AS NEW_PROJ_ID
FROM PROJECTS
WHERE NEW_PROJ_END_DATE>@proj_end_date
),

-----------------------------
/*Currency_rates*/
-----------------------------
CRNCY_RATE as (
SELECT cast([day_date] as DATE) as Used_on
      ,[currency_code] as CRNCY_CODE
      ,cast([rate_date] as DATE) as Rate_date
      ,[fx_rate]
	  ,concat(cast([day_date] as DATE), [currency_code]) as CRNCY_TAB_KEY
  FROM [data_mis].[nbp_crncy_rates]
  ),

-----------------------------
/*Additional_Costs*/
-----------------------------
ADDTL_COST as (
SELECT 
 '' as ID
,project_id PROJ_ID
,cast (day_date as DATE) as DAY_DATE
,cost_amount as AMT
,currency_code as CRNCY_CODE
,'Additional_Cost' as TYPE 
FROM data_in.fin_project_additional_cost_report_vw
WHERE cost_type_code=@cost_type_code
),

-----------------------------
/*Additional_Funds*/
-----------------------------
ADDTL_FUND as (
SELECT
 id as ID
,project_id PROJ_ID
,cast(day_date as DATE) as CRNCY_DAY_DATE 
,cast(day_date as DATE) as DAY_DATE 
,currency_code CRNCY_CODE
,fund_gross_amount as AMT_BEFORE_DISC
,0 as AMT_DISC
,fund_amount as AMT_AFTER_DISC
,'Additional_Fund' as TYPE
FROM data_in.fin_project_additional_fund
),

--------------------------------
/*Billing_Milestones_Unbilled*/
--------------------------------
BM_UNBILLED as (
select 
 billing_milestone_id as ID
,project_id PROJ_ID
,cast(billing_milestone_delivery_date as DATE) as CRNCY_DAY_DATE 
,cast(billing_milestone_delivery_date as DATE) as DAY_DATE 
,po_currency_code as CRNCY_CODE
,billng_milestone_amount_before_discount as AMT_BEFORE_DISC
,billing_milestone_core_discount+billing_milestone_additional_discount as AMT_DISC
,billng_milestone_amount_before_discount-(billing_milestone_core_discount+billing_milestone_additional_discount) as AMT_AFTER_DISC
,'BM-Unbilled Revenue' as TYPE

from data_in.fin_billing_sheet_vw
where invoice_code is null and wont_be_billed_ind=0
),

--------------------------------
/*Billing_Milestones_Billed*/
--------------------------------
BM_BILLED as (
select 
 billing_milestone_id as ID
,project_id PROJ_ID
,CASE WHEN cast(invoice_delivery_date as DATE) < cast (invoice_issue_date as DATE) THEN cast(invoice_delivery_date as DATE) else cast (invoice_issue_date as DATE) end as CRNCY_DAY_DATE 
,cast(invoice_delivery_date as DATE) as DAY_DATE
,po_currency_code as CRNCY_CODE
,position_net_amount_before_discount as AMT_BEFORE_DISC
,position_net_amount_discount as AMT_DISC
,position_net_amount_before_discount-position_net_amount_discount as AMT_AFTER_DISC
,'BM-Billed Revenue' as TYPE

from data_in.fin_billing_sheet_vw
where invoice_code is not null and wont_be_billed_ind=0
),

--------------------------------
/*Finance_union*/
--------------------------------
Revenue as (
select * 
from ADDTL_FUND
union all
select *
from BM_BILLED
union all
select *
from BM_UNBILLED
),

--------------------------------
/*Finance_union + Currency_rates*/
--------------------------------

Finance as (
select 
ID
,PROJ_ID
,CRNCY_DAY_DATE
,DAY_DATE
,CRNCY_CODE
,AMT_BEFORE_DISC
,AMT_DISC
,AMT_AFTER_DISC
,concat (cast (CRNCY_DAY_DATE as DATE), CRNCY_CODE) as CRNCY_TAB_KEY
,TYPE
from Revenue
),

Finance_CRNCY as (
select 
ID
,PROJ_ID
,CRNCY_DAY_DATE
,DAY_DATE
,a.CRNCY_CODE
,AMT_BEFORE_DISC
,AMT_DISC
,AMT_AFTER_DISC
,b.fx_rate as CRNCY_RATE
,TYPE
from Finance a
left join CRNCY_RATE b on a.CRNCY_TAB_KEY=b.CRNCY_TAB_KEY
where DAY_DATE>'2020-12-31'
),

FINANCE_PLN as(
select ID
,PROJ_ID
,CRNCY_DAY_DATE
,DAY_DATE
,CRNCY_CODE
,AMT_BEFORE_DISC
,AMT_DISC
,AMT_AFTER_DISC
,CRNCY_RATE
,CASE WHEN CRNCY_CODE in ('PLN', 'AED') THEN AMT_BEFORE_DISC*1 else AMT_BEFORE_DISC*CRNCY_RATE end as AMT_BEFORE_DISC_PLN
,CASE WHEN CRNCY_CODE in ('PLN', 'AED') THEN AMT_DISC*1  else AMT_DISC*CRNCY_RATE end as AMT_DISC_PLN
,CASE WHEN CRNCY_CODE in ('PLN', 'AED') THEN AMT_AFTER_DISC*1 else AMT_AFTER_DISC*CRNCY_RATE end as AMT_AFTER_DISC_PLN
,TYPE
from Finance_CRNCY)


insert  into data_mis_project.revenue
select *
from FINANCE_PLN
GO

GRANT EXECUTE
    ON OBJECT::[data_mis_project].[update_revenue] TO [lingaro-mis-adf]
    AS [dbo];
GO


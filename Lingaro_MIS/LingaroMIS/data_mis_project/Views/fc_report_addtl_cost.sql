create view data_mis_project.fc_report_addtl_cost as

with 

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
/*Currency_rates*/
-----------------------------
CRNCY_RATE_AVG as (
SELECT --cast([day_date] as DATE) as USED_ON
      [currency_code] as CRNCY_CODE
     -- ,cast([rate_date] as DATE) as RATE_DATE
      ,AVG([fx_rate]) as FX_RATE
	  ,EOMONTH(day_date) as END_OF_MONTH
	  ,FORMAT(day_date, 'yyyy-MM') as MONTH_DATE
	  ,concat(cast([day_date] as DATE), [currency_code]) as CRNCY_TAB_KEY
FROM [data_mis].[nbp_crncy_rates]
GROUP BY EOMONTH(day_date)
		,[currency_code]
		,concat(cast([day_date] as DATE), [currency_code]) 
		,FORMAT(day_date, 'yyyy-MM')
),

-----------------------------
/*LEGAL_ENTITY*/
-----------------------------
LEGAL_ENTITY as(SELECT id as [LE_ID]
      ,name as [LE_NAME]
      ,calendar_id as [SULU3_CAL_ID]
  FROM data_in.org_legal_entity),

-----------------------------
/*PO for PROJECTS*/
-----------------------------
PO_ID as (SELECT [PO_ID]
      ,[PROJ_ID]
      --,[PO_PROJ_AMT]
      --,[CHNG_DATE]
      --,[CHNG_EMPEE_ID]
  FROM [data_in_sulu_v1].[sulu_po_proj_fct]
),

-----------------------------
/*PO for PROJECTS*/
-----------------------------
PO_MAP as (SELECT [PO_ID]
      ,[CLEN_ID]
      ,[CLEN_PO_CODE]
      ,[PO_NAME]
      ,[PO_CMMNT]
      ,[PO_CRNCY_CODE]
      ,[PO_AMT]
      ,[CHNG_DATE]
      ,[CHNG_EMPEE_ID]
      ,[OLD_PO_BILL_TO_TXT]
      ,CASE WHEN cast([VALID_THRGH_DATE] as date) is null then cast('9999-01-01' as date) else VALID_THRGH_DATE end as VALID_THRGH_DATE
      ,[BILL_TO_ID]
      ,[GROUP_PO_IND]
      ,[LE_ID]
  FROM [data_in_sulu_v1].[sulu_po_fct]),

-----------------------------
/*PO for PROJECTS GROUPED*/
-----------------------------
PO_MAP_GROUPED as (SELECT PO_ID
						 ,PO_NAME
						,MAX(VALID_THRGH_DATE) as VALID_THRGH_DATE
						--,LE_ID
						--,BILL_TO_ID
						
FROM PO_MAP
GROUP BY PO_ID
	    ,PO_NAME
),


-----------------------------
/*PO bill to*/
-----------------------------
PO_BILL_TO as (SELECT [BILL_TO_ID]
      ,[BILL_TO]
      ,[PYMT_TERMS]
      ,[INVC_ADDR]
      ,[DLVRY_ADDR]
      ,[CNTRY_NAME]
  FROM [data_in_sulu_v1].[sulu_po_bill_to_lkp]),

-----------------------------
/*PO ALL*/
-----------------------------

PO_ALL as (SELECT
       [PROJ_ID]
       ,a.[PO_ID]
	   ,b.PO_NAME
	   --,b.BILL_TO_ID
	   --,b.LE_ID
	   --,d.LE_NAME
	   ,b.VALID_THRGH_DATE
FROM PO_ID a
LEFT JOIN PO_MAP_GROUPED b on a.PO_ID=b.PO_ID
--LEFT JOIN LEGAL_ENTITY d on b.LE_ID=d.LE_ID
),

-----------------------------
/*PO ALL GROUPED BY PROJ*/
-----------------------------

PO_ALL_GROUPED as (SELECT PROJ_ID
,MAX(VALID_THRGH_DATE) as VALID_THRGH_DATE
FROM PO_ALL
GROUP BY PROJ_ID
),

-----------------------------
/*PO ALL CLEARED BY PO GROUPED*/
-----------------------------
PO_ALL_GROUPED_CLEARED as (SELECT a.PROJ_ID
							,min(b.PO_ID) as PO_ID
						 ,b.VALID_THRGH_DATE
						 ,a.VALID_THRGH_DATE as CURRENT_VALID_THRGH_DATE
						 ,CASE WHEN b.VALID_THRGH_DATE=a.VALID_THRGH_DATE then 1 else 0 end as CURRENT_VALID_THRGH_DATE_IND
						 FROM PO_ALL_GROUPED a
						 LEFT JOIN PO_ALL b on a.PROJ_ID=b.PROJ_ID
						 GROUP BY  a.PROJ_ID						 
						 ,b.VALID_THRGH_DATE
						 ,a.VALID_THRGH_DATE
						 ),

------------------------------------------
/*PO ALL CLEARED BY PO GROUPED FILTER*/
------------------------------------------
PO_ALL_GROUPED_CLEARED_FILTER as (SELECT 
							PROJ_ID
						   ,PO_ID
						   ,VALID_THRGH_DATE
						   ,CURRENT_VALID_THRGH_DATE
						   ,CURRENT_VALID_THRGH_DATE_IND
						 FROM PO_ALL_GROUPED_CLEARED 
						 where CURRENT_VALID_THRGH_DATE_IND=1
						 ),


-----------------------------
/*Additional_Costs*/
-----------------------------
ADDTL_COST as (
SELECT 
PROJ_ID
,CAST(DAY_DATE as DATE) as DAY_DATE
,FINAL_COST_AMT as COST_AMT
,ADDTL_COST_CRNCY_CODE as CRNCY_CODE
,concat(cast([day_date] as DATE), [ADDTL_COST_CRNCY_CODE]) as CRNCY_TAB_KEY
,ADDTL_COST_TYPE_CODE
FROM data_in_sulu_v1.sulu_proj_addtl_cost_vw
),

--------------------------------------
/*Additional_Costs + Currency_rates*/
--------------------------------------
ADDTL_COST_PLN as (
select 
 a.PROJ_ID
,a.DAY_DATE
,a.COST_AMT
,a.CRNCY_CODE
,b.fx_rate
,CASE WHEN a.CRNCY_CODE in ('PLN', 'AED') THEN a.COST_AMT*1 else a.COST_AMT*b.fx_rate end as COST_AMT_PLN
,a.ADDTL_COST_TYPE_CODE
,c.PO_ID
,d.LE_ID
,e.LE_NAME
from ADDTL_COST a
left join CRNCY_RATE_AVG b on a.CRNCY_TAB_KEY=b.CRNCY_TAB_KEY
left join PO_ALL_GROUPED_CLEARED_FILTER c on a.[PROJ_ID]=c.PROJ_ID
left join PO_MAP d on c.PO_ID=d.PO_ID
left join LEGAL_ENTITY e on d.LE_ID=e.LE_ID

)

select * from ADDTL_COST_PLN
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[fc_report_addtl_cost] TO [data_mis_project_fc_report_addtl_cost_read_all]
    AS [dbo];
GO


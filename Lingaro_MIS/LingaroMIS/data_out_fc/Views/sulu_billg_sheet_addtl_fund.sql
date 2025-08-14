Create view data_out_fc.sulu_billg_sheet_addtl_fund as
with reve as (

select b.[CLEN_NAME]
      ,h.client_id as CLEN_ID
      ,b.[PARNT_PROJ_NAME]
      ,b.[PROJ_NAME]
      ,b.[PROJ_ID]
	  ,BILLG_MLSTN_ID
	  ,PO_ID
      ,[BILLG_MLSTN_NAME]
      ,cast([BILLG_MLSTN_DATE] as date) [BILLG_MLSTN_DATE]
      ,cast([DLVRY_DATE] as date) [DLVRY_DATE]
      ,[INVC_CODE]
      ,cast([INVC_DLVRY_DATE] as date) [INVC_DLVRY_DATE]
      ,cast([INVC_ISSUE_DATE] as date) [INVC_ISSUE_DATE]
      ,[INVC_CMMNT]
      ,[POSTN_NET_BEF_DISC_AMT]
      ,[BILLG_MLSTN_BEF_DISC_AMT]
      ,[PO_CRNCY_CODE]
      ,[ACTV_CODE] PROJ_STATUS
      ,[BILLG_MLSTN_CMMNT]
      ,b.[PROJ_BLLBL_IND] "Billable"
      ,[BILLG_MLSTN_AFTER_DISC_AMT]
      ,[BM_ADDTL_DISC_AMT] ADD_DISC
      ,[POSTN_NET_AFTER_DISC_AMT]
      ,isnull([POSTN_NET_DISC_AMT], billg_mlstn_basic_disc_amt) [POSTN_NET_DISC_AMT]
      ,[reinvc_ind] "Reinvoice"
	  ,double_counting_ind "Double Counting project?"
	  ,'N' as "ADDITIONAL FUND"
	  ,h.organization_unit_name "Project Team"
	  ,h.invoicing_name "Project type"
FROM data_in_sulu_v1.[sulu_billg_sheet_vw] b
--left join [data_in_sulu_v1].[sulu_proj_lkp] p on b.PROJ_ID = p.PROJ_ID
left join data_mis.proj h on b.PROJ_ID = h.project_id
where WONT_BE_BILL_IND = 'N'
),

addl as (
SELECT h.client_name as [CLEN_NAME]
      ,h.client_id as CLEN_ID
      ,h.parent_project_name as [PARNT_PROJ_NAME]
      ,h.project_name as [PROJ_NAME]
	  ,a.[PROJ_ID]
	  ,null as BILLG_MLSTN_ID
	  ,null as PO_ID
      ,[ADDTL_FUND_DESC] BILLG_MLSTN_NAME
      ,cast([ADDTL_FUND_DATE] as date) BILLG_MLSTN_DATE
      ,cast(a.ADDTL_FUND_DATE as date) DLVRY_DATE
      ,[ADDTL_FUND_DESC] INVC_CODE
      ,Null as INVC_DLVRY_DATE
      ,Null as [INVC_ISSUE_DATE]
      ,Null as INVC_CMMNT
      ,NULL as [POSTN_NET_BEF_DISC_AMT]
	  ,[ADDTL_FUND_AMT] BILLG_MLSTN_BEF_DISC_AMT
      ,[CRNCY_CODE] PO_CRNCY_CODE
      ,h.active PROJ_STATUS
      ,Null as BILLG_MLSTN_CMMNT
      ,CASE WHEN h.project_billable_ind = 1 then 'Y' when h.project_billable_ind = 0 then 'N' end as "Billable"
      ,NULL as [BILLG_MLSTN_AFTER_DISC_AMT]
      ,NULL as ADD_DISC
      ,NULL as [POSTN_NET_AFTER_DISC_AMT]
      ,NULL as [POSTN_NET_DISC_AMT]
      ,NULL as "Reinvoice"
  ,double_counting_ind "Double Counting project?"
  ,'Y' as "ADDITIONAL FUND"
  ,h.organization_unit_name "Project Team"
  ,h.invoicing_name "Project type"
FROM [data_in_sulu_v1].[sulu_proj_addtl_fund_fct] a
--left join [data_in_sulu_v1].[sulu_proj_lkp] p on a.PROJ_ID = p.PROJ_ID
left join data_mis.proj h on a.PROJ_ID = h.project_id
),

acc as (
SELECT h.client_name as [CLEN_NAME]
      ,h.client_id as CLEN_ID
      ,h.parent_project_name as [PARNT_PROJ_NAME]
      ,h.project_name as [PROJ_NAME]
	  ,a.[PROJ_ID]
	   ,null as BILLG_MLSTN_ID
	   ,null as PO_ID
      ,[ACCRUAL_DESC] BILLG_MLSTN_NAME
      ,cast([ACCRUAL_DATE] as date) BILLG_MLSTN_DATE
      ,cast(a.[ACCRUAL_DATE] as date) DLVRY_DATE
      ,[ACCRUAL_DESC] INVC_CODE
      ,Null as INVC_DLVRY_DATE
      ,Null as [INVC_ISSUE_DATE]
      ,Null as INVC_CMMNT
      ,NULL as [POSTN_NET_BEF_DISC_AMT]
	  ,[ACCRUAL_AMT] BILLG_MLSTN_BEF_DISC_AMT
      ,[CRNCY_CODE] PO_CRNCY_CODE
      ,h.active PROJ_STATUS
      ,Null as BILLG_MLSTN_CMMNT
      ,CASE WHEN h.project_billable_ind = 1 then 'Y' 
	   when h.project_billable_ind = 0 then 'N' end as "Billable"
      ,NULL as [BILLG_MLSTN_AFTER_DISC_AMT]
      ,NULL as ADD_DISC
      ,NULL as [POSTN_NET_AFTER_DISC_AMT]
      ,NULL as [POSTN_NET_DISC_AMT]
      ,NULL as "Reinvoice"
  ,double_counting_ind "Double Counting project?"
  ,'Y' as "ADDITIONAL FUND"
  ,h.organization_unit_name "Project Team"
  ,h.invoicing_name "Project type"
FROM [data_in_sulu_v1].[sulu_proj_accruals_fct] a
--left join [data_in_sulu_v1].[sulu_proj_lkp] p on a.PROJ_ID = p.PROJ_ID
left join data_mis.proj h on a.PROJ_ID = h.project_id
),
tot as (

select * from reve
union all
select * from addl
union all
select * from acc),



final as(
select 
tot.PROJ_ID
, PROJ_NAME
, PARNT_PROJ_NAME
, "Project Team"
, tot.CLEN_ID
, tot.CLEN_NAME
, f.ultimate_parent_id as ULTIMATE_PARENT_ID
, f.ultimate_parent_name as ULTIMATE_PARENT_NAME
, case when tot.PO_ID is null or tot.PO_ID=-1 then d. PO_ID else tot.PO_ID end as PO_ID
,c.CLEN_PO_CODE as PO_NUMBER
, c.PO_NAME as PO_NAME
, BILLG_MLSTN_ID
, BILLG_MLSTN_NAME
, BILLG_MLSTN_DATE
, INVC_CODE
, INVC_ISSUE_DATE
, POSTN_NET_BEF_DISC_AMT
, ADD_DISC, 
CASE WHEN INVC_CODE is null or POSTN_NET_DISC_AMT is null or POSTN_NET_DISC_AMT = 0  then POSTN_NET_DISC_AMT ELSE POSTN_NET_DISC_AMT-isnull(ADD_DISC,0) END AS POSTN_NET_DISC_AMT, 
POSTN_NET_AFTER_DISC_AMT
, BILLG_MLSTN_BEF_DISC_AMT
, BILLG_MLSTN_AFTER_DISC_AMT,
tot.PO_CRNCY_CODE
,PROJ_STATUS
, Billable
, Reinvoice
, INVC_DLVRY_DATE
, DLVRY_DATE
, INVC_CMMNT
, BILLG_MLSTN_CMMNT
, "Project type"
, "Double Counting project?"
, "ADDITIONAL FUND"
--, d.LE_NAME LINGARO_BILLING_ENTITY 
--, e.BILL_TO, e.CNTRY_NAME 
from tot
left join [data_in_sulu_v1].[sulu_po_fct] c on tot.PO_ID=c.PO_ID
left join (select * from data_mis.po_billing_entity where type= 'Without PO') d on tot.PROJ_ID=d.PROJ_ID 
--left join [data_in_sulu_v1].[sulu_po_bill_to_lkp] e on c.BILL_TO_ID=e.BILL_TO_ID
left join data_in.proj_clnt f on tot.CLEN_ID=f.id
)

select 
a.PROJ_ID
, PROJ_NAME
, PARNT_PROJ_NAME
, "Project Team"
, a.CLEN_ID
, CLEN_NAME
, ULTIMATE_PARENT_ID
, ULTIMATE_PARENT_NAME
, a.PO_ID
,PO_NUMBER
, a.PO_NAME
, BILLG_MLSTN_ID
, BILLG_MLSTN_NAME
, BILLG_MLSTN_DATE
, INVC_CODE
, INVC_ISSUE_DATE
, POSTN_NET_BEF_DISC_AMT
, ADD_DISC, 
 POSTN_NET_DISC_AMT, 
POSTN_NET_AFTER_DISC_AMT
, BILLG_MLSTN_BEF_DISC_AMT
, BILLG_MLSTN_AFTER_DISC_AMT,
a.PO_CRNCY_CODE
,PROJ_STATUS
, Billable
, Reinvoice
, INVC_DLVRY_DATE
, DLVRY_DATE
, INVC_CMMNT
, BILLG_MLSTN_CMMNT
, "Project type"
, "Double Counting project?"
, "ADDITIONAL FUND"
, e.name as LINGARO_BILLING_ENTITY 
, c.BILL_TO, c.CNTRY_NAME 
,c.PYMT_TERMS  
from final a
left join [data_in_sulu_v1].[sulu_po_fct] b on a.PO_ID=b.PO_ID 
left join [data_in_sulu_v1].[sulu_po_bill_to_lkp] c on b.BILL_TO_ID=c.BILL_TO_ID
left join (select * from data_mis.po_billing_entity where type= 'With PO') d on a.PO_ID=d.PO_ID and a.PROJ_ID=d.PROJ_ID
left join data_in.org_legal_entity e on b.LE_ID=e.id
GO

GRANT SELECT
    ON OBJECT::[data_out_fc].[sulu_billg_sheet_addtl_fund] TO [data_out_fc_read_all]
    AS [dbo];
GO


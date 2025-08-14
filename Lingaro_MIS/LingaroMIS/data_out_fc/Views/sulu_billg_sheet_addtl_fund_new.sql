create view data_out_fc.sulu_billg_sheet_addtl_fund_new as

with reve as (

select b.client_name [CLEN_NAME]
      ,h.client_id as CLEN_ID
      ,b.parent_project_name [PARNT_PROJ_NAME]
      ,b.project_name [PROJ_NAME]
      ,b.project_id [PROJ_ID]
	  ,billing_milestone_id BILLG_MLSTN_ID
	  ,po_id PO_ID
      ,billing_milestone_name [BILLG_MLSTN_NAME]
      ,cast(b.billing_milestone_billing_date as date) [BILLG_MLSTN_DATE]
      ,cast(billing_milestone_delivery_date as date) [DLVRY_DATE]
      ,invoice_code [INVC_CODE]
      ,cast(b.invoice_delivery_date as date) [INVC_DLVRY_DATE]
      ,cast(b.invoice_issue_date as date) [INVC_ISSUE_DATE]
      ,b.invoice_comment [INVC_CMMNT]
      ,b.position_net_amount_before_discount [POSTN_NET_BEF_DISC_AMT]
      ,b.billng_milestone_amount_before_discount [BILLG_MLSTN_BEF_DISC_AMT]
      ,b.po_currency_code [PO_CRNCY_CODE]
      ,b.active_code PROJ_STATUS
      ,b.billing_milestone_comment [BILLG_MLSTN_CMMNT]
      ,b.project_billable_ind "Billable"
      ,b.billng_milestone_amount_after_discount [BILLG_MLSTN_AFTER_DISC_AMT]
      ,b.billing_milestone_additional_discount ADD_DISC
      ,b.position_net_amount_after_discount [POSTN_NET_AFTER_DISC_AMT]
      ,isnull(b.position_net_amount_discount , b.billing_milestone_core_discount) [POSTN_NET_DISC_AMT]
      ,reinvoice_ind "Reinvoice"
	  ,double_counting_ind "Double Counting project?"
	  ,'N' as "ADDITIONAL FUND"
	  ,h.organization_unit_name "Project Team"
	  ,h.invoicing_name "Project type"
FROM data_in.fin_billing_sheet_vw b
--left join [data_in_sulu_v1].[sulu_proj_lkp] p on b.PROJ_ID = p.PROJ_ID
left join data_mis.proj h on b.project_id = h.project_id
where wont_be_billed_ind = 0
),

addl as (
SELECT h.client_name as [CLEN_NAME]
      ,h.client_id as CLEN_ID
      ,h.parent_project_name as [PARNT_PROJ_NAME]
      ,h.project_name as [PROJ_NAME]
	  ,a.project_id [PROJ_ID]
	  ,null as BILLG_MLSTN_ID
	  ,null as PO_ID
      ,a.description  BILLG_MLSTN_NAME
      ,cast(a.day_date as date) BILLG_MLSTN_DATE
      ,cast(a.day_date as date) DLVRY_DATE
      ,a.description INVC_CODE
      ,Null as INVC_DLVRY_DATE
      ,Null as [INVC_ISSUE_DATE]
      ,Null as INVC_CMMNT
      ,NULL as [POSTN_NET_BEF_DISC_AMT]
	  ,a.fund_amount BILLG_MLSTN_BEF_DISC_AMT
      ,a.currency_code PO_CRNCY_CODE
      ,h.active PROJ_STATUS
      ,Null as BILLG_MLSTN_CMMNT
      ,CASE WHEN h.project_billable_ind = 1 then 1 when h.project_billable_ind = 0 then 0 end as "Billable"
      ,NULL as [BILLG_MLSTN_AFTER_DISC_AMT]
      ,NULL as ADD_DISC
      ,NULL as [POSTN_NET_AFTER_DISC_AMT]
      ,NULL as [POSTN_NET_DISC_AMT]
      ,NULL as "Reinvoice"
  ,double_counting_ind "Double Counting project?"
  ,'Y' as "ADDITIONAL FUND"
  ,h.organization_unit_name "Project Team"
  ,h.invoicing_name "Project type"
FROM [data_in].[fin_project_additional_fund] a
--left join [data_in_sulu_v1].[sulu_proj_lkp] p on a.PROJ_ID = p.PROJ_ID
left join data_mis.proj h on a.project_id = h.project_id
),

--acc as (
--SELECT h.client_name as [CLEN_NAME]
--      ,h.client_id as CLEN_ID
--      ,h.parent_project_name as [PARNT_PROJ_NAME]
--      ,h.project_name as [PROJ_NAME]
--	  ,a.[PROJ_ID]
--	   ,null as BILLG_MLSTN_ID
--	   ,null as PO_ID
--      ,[ACCRUAL_DESC] BILLG_MLSTN_NAME
--      ,cast([ACCRUAL_DATE] as date) BILLG_MLSTN_DATE
--      ,cast(a.[ACCRUAL_DATE] as date) DLVRY_DATE
--      ,[ACCRUAL_DESC] INVC_CODE
--      ,Null as INVC_DLVRY_DATE
--      ,Null as [INVC_ISSUE_DATE]
--      ,Null as INVC_CMMNT
--      ,NULL as [POSTN_NET_BEF_DISC_AMT]
--	  ,[ACCRUAL_AMT] BILLG_MLSTN_BEF_DISC_AMT
--      ,[CRNCY_CODE] PO_CRNCY_CODE
--      ,h.active PROJ_STATUS
--      ,Null as BILLG_MLSTN_CMMNT
--      ,CASE WHEN h.project_billable_ind = 1 then 'Y' 
--	   when h.project_billable_ind = 0 then 'N' end as "Billable"
--      ,NULL as [BILLG_MLSTN_AFTER_DISC_AMT]
--      ,NULL as ADD_DISC
--      ,NULL as [POSTN_NET_AFTER_DISC_AMT]
--      ,NULL as [POSTN_NET_DISC_AMT]
--      ,NULL as "Reinvoice"
--  ,double_counting_ind "Double Counting project?"
--  ,'Y' as "ADDITIONAL FUND"
--  ,h.organization_unit_name "Project Team"
--  ,h.invoicing_name "Project type"
--FROM [data_in_sulu_v1].[sulu_proj_accruals_fct] a
----left join [data_in_sulu_v1].[sulu_proj_lkp] p on a.PROJ_ID = p.PROJ_ID
--left join data_mis.proj h on a.PROJ_ID = h.project_id
--),

tot as (

select * from reve
union all
select * from addl),
--union all
--select * from acc),



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
,c.client_po_code as PO_NUMBER
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
left join [data_in].fin_purchase_order c on tot.PO_ID=c.id
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
, c.bill_to BILL_TO, 
c.country_name CNTRY_NAME 
,c.payment_terms PYMT_TERMS  
from final a
left join [data_in].[fin_purchase_order] b on a.PO_ID=b.id 
left join [data_in].[fin_purchase_order_bill_to] c on b.BILL_TO_ID=c.id
left join (select * from data_mis.po_billing_entity where type= 'With PO') d on a.PO_ID=d.PO_ID and a.PROJ_ID=d.PROJ_ID
left join data_in.org_legal_entity e on b.legal_entity_id=e.id
GO

GRANT SELECT
    ON OBJECT::[data_out_fc].[sulu_billg_sheet_addtl_fund_new] TO [data_out_fc_read_all]
    AS [dbo];
GO


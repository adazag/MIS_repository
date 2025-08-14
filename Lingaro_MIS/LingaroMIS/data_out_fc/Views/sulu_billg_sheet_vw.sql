create view data_out_fc.sulu_billg_sheet_vw as (

SELECT b.[CLEN_NAME]
	  ,c.ultimate_parent_id as ULTIMATE_PARENT_ID
      ,c.ultimate_parent_name as ULTIMATE_PARENT_NAME
      ,[PARNT_PROJ_NAME]
      ,[PARNT_PROJ_MGR_EMPEE_NAME]
      ,b.[PROJ_NAME]
      ,b.[PROJ_ID]
      ,b.[BILLG_MLSTN_ID]
      ,b.[BILLG_MLSTN_NAME]
      ,cast(b.[BILLG_MLSTN_DATE] as date) [BILLG_MLSTN_DATE]
      ,cast(b.[DLVRY_DATE] as date) [DLVRY_DATE]
	  ,d.CHNG_DATE as APPROVAL_BILLG_MLSTN_DATE
      ,[CLEN_PO_CODE]
      ,[PO_NAME]
      ,cast(b.[CHNG_DATE] as date) [CHNG_DATE]
      ,[BILL_TO]
      ,[CNTRY_NAME]
      ,[INVC_CODE]
      ,cast([INVC_DLVRY_DATE] as date) [INVC_DLVRY_DATE]
      ,cast([INVC_ISSUE_DATE] as date) [INVC_ISSUE_DATE]
      ,cast([INVC_DUE_DATE] as date) [INVC_DUE_DATE]
      ,cast([INVC_ARRIV_DATE] as date) [INVC_ARRIV_DATE]
      ,[INVC_CMMNT]
      ,[postn_net_bef_disc_amt]
      ,[INVC_GROSS_AMT]
      ,[INVC_GROSS_PLN_AMT]
      ,[POSTN_GROSS_AMT]
      ,[POSTN_GROSS_PLN_AMT]
      ,b.[BILLG_MLSTN_BEF_DISC_AMT]
      ,[PO_CRNCY_CODE]
      ,[INVC_AMT]
      ,[ACTV_CODE]
      ,[OVRDU_PYMT_IND]
      ,[BM_TO_BILL_IND]
      ,b.[WONT_BE_BILL_IND]
      ,b.[PO_ID]
      ,[PO_AMT]
      ,b.[BILLG_MLSTN_TO_INVC_AMT]
      ,b.[CAN_BE_BILL_IND]
      ,b.[BILLG_MLSTN_CMMNT]
      ,b.[PROJ_BLLBL_IND]
      ,[sum_bm]
      ,[is_po_sft]
      ,[CURR_ORG_UNIT_ID]
      ,[CURR_BU_ID]
      ,[CURR_SENIOR_DELIVERY_TEAM_ID]
      ,[CURR_DELIVERY_TEAM_ID]
      ,[CURR_TEAM_ID]
      ,[billg_mlstn_after_disc_amt]
      ,b.[BM_ADDTL_DISC_AMT]
      ,[postn_net_after_disc_amt]
      ,[postn_net_disc_amt]
      ,[billg_mlstn_basic_disc_amt]
      ,b.[reinvc_ind]
      ,b.[BILLG_MLSTN_CRNCY_CODE]
      ,[group_po_ind]
      ,b.[cr_ind]
      ,[disc_pct]
	  ,double_counting_ind as DBL_CNTNG_IND  
FROM data_in_sulu_v1.[sulu_billg_sheet_vw] b 
	left join data_in.proj p on b.PROJ_ID = p.project_id 
	left join data_in.proj_clnt c on p.client_id=c.id
	left join data_in_sulu_v1.sulu_billg_mlstn_fct d on b.BILLG_MLSTN_ID = d.BILLG_MLSTN_ID
)
GO

GRANT SELECT
    ON OBJECT::[data_out_fc].[sulu_billg_sheet_vw] TO [data_out_fc_read_all]
    AS [dbo];
GO


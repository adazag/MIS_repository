
CREATE view [data_out_fc].[sulu_billg_sheet_vw_new] as
(
SELECT b.client_name [CLEN_NAME]
	  ,c.ultimate_parent_id as ULTIMATE_PARENT_ID
      ,c.ultimate_parent_name as ULTIMATE_PARENT_NAME
      ,parent_project_name [PARNT_PROJ_NAME]
      ,parent_project_manager_name [PARNT_PROJ_MGR_EMPEE_NAME]
      ,b.project_name [PROJ_NAME]
      ,b.project_id [PROJ_ID]
      ,b.billing_milestone_id [BILLG_MLSTN_ID]
      ,b.billing_milestone_name [BILLG_MLSTN_NAME]
      ,cast(b.billing_milestone_billing_date as date) [BILLG_MLSTN_DATE]
      ,cast(b.billing_milestone_delivery_date as date) [DLVRY_DATE]
	  ,d.approval_date as APPROVAL_BILLG_MLSTN_DATE
      ,client_po_code [CLEN_PO_CODE]
      ,po_name [PO_NAME]
      ,cast(b.po_modified_at as date) [CHNG_DATE]
      ,bill_to [BILL_TO]
      ,country_name [CNTRY_NAME]
      ,invoice_code [INVC_CODE]
      ,cast(invoice_delivery_date as date) [INVC_DLVRY_DATE]
      ,cast(invoice_issue_date as date) [INVC_ISSUE_DATE]
      ,cast(invoice_due_date as date) [INVC_DUE_DATE]
      ,cast(invoice_arrival_date as date) [INVC_ARRIV_DATE]
      ,invoice_comment [INVC_CMMNT]
      ,position_net_amount_before_discount [postn_net_bef_disc_amt]
      ,invoice_gross_amount [INVC_GROSS_AMT]
      ,invoice_gross_pln_amount [INVC_GROSS_PLN_AMT]
      ,position_gross_amount [POSTN_GROSS_AMT]
      ,position_gross_pln_amount [POSTN_GROSS_PLN_AMT]
      ,b.billng_milestone_amount_before_discount [BILLG_MLSTN_BEF_DISC_AMT]
      ,po_currency_code [PO_CRNCY_CODE]
      ,invoice_amount [INVC_AMT]
      ,active_code [ACTV_CODE]
      ,overdue_payment_ind [OVRDU_PYMT_IND]
      ,billing_milestone_to_be_billed [BM_TO_BILL_IND]
      ,b.wont_be_billed_ind [WONT_BE_BILL_IND]
      ,b.po_id [PO_ID]
      ,po_available_amount [PO_AMT]
      ,b.billing_milestone_amount_to_invoice [BILLG_MLSTN_TO_INVC_AMT]
      ,b.can_be_billed_ind [CAN_BE_BILL_IND]
      ,b.billing_milestone_comment [BILLG_MLSTN_CMMNT]
      ,b.project_billable_ind [PROJ_BLLBL_IND]
      ,[sum_bm]
      ,[is_po_sft]
      ,current_org_unit_id [CURR_ORG_UNIT_ID]
      ,current_bu_id [CURR_BU_ID]
      ,current_senior_delivery_team_id [CURR_SENIOR_DELIVERY_TEAM_ID]
      ,current_delivery_team_id [CURR_DELIVERY_TEAM_ID]
      , current_team_id [CURR_TEAM_ID]
      ,billng_milestone_amount_after_discount [billg_mlstn_after_disc_amt]
      ,b.billing_milestone_additional_discount [BM_ADDTL_DISC_AMT]
      ,position_net_amount_after_discount [postn_net_after_disc_amt]
      ,position_net_amount_discount [postn_net_disc_amt]
      ,billing_milestone_core_discount [billg_mlstn_basic_disc_amt]
      ,b.reinvoice_ind [reinvc_ind]
      ,b.billing_milestone_currency_code [BILLG_MLSTN_CRNCY_CODE]
      ,[group_po_ind]
      ,b.change_request_ind [cr_ind]
      ,discount_percentage [disc_pct]
	  ,double_counting_ind as DBL_CNTNG_IND  

FROM data_in.[fin_billing_sheet_vw] b 
	left join data_in.proj p on b.project_id = p.project_id 
	left join data_in.proj_clnt c on p.client_id=c.id
	left join data_in.proj_billing_milestone d on b.billing_milestone_id = d.id)
GO

GRANT SELECT
    ON OBJECT::[data_out_fc].[sulu_billg_sheet_vw_new] TO [data_out_fc_read_all]
    AS [dbo];
GO


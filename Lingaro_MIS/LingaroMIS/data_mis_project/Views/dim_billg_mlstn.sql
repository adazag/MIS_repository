create view data_mis_project.dim_billg_mlstn as (
SELECT po_id [PO_ID]
      ,id [BILLG_MLSTN_ID]
      ,billing_date [BILLG_MLSTN_DATE]
      ,bm_name [BILLG_MLSTN_NAME]
      --,[BILLG_MLSTN_BEF_DISC_AMT]
      ,modified_at [CHNG_DATE]
      ,modified_by [CHNG_EMPEE_ID]
      ,project_id [PROJ_ID]
      --,[BILLG_MLSTN_TO_INVC_AMT]
      ,can_be_billed_ind [CAN_BE_BILL_IND]
      ,currency_code [BILLG_MLSTN_CRNCY_CODE]
      ,wont_be_billed_ind [WONT_BE_BILL_IND]
      ,comment [BILLG_MLSTN_CMMNT]
      ,crr_bm_unique_code [CRR_BILLG_MLSTN_UNIQ_CODE]
      ,crr_invoice_id [CRR_INVC_ID]
      ,delivery_date [DLVRY_DATE]
      ,cancel_billing_reason [CANCL_BILL_TXT]
      --,[BM_ADDTL_DISC_AMT]
      ,reinvoice_ind [REINVC_IND]
      ,change_request_ind [CR_IND]
      ,bm_not_contracted_ind [BM_NCNTRCTD_IND]
      ,bm_contracted_in_ongoing_month_ind [BM_CNTRCTD_OM_IND]

  FROM data_in.proj_billing_milestone
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[dim_billg_mlstn] TO [data_mis_project_dim_billg_mlstn_read_all]
    AS [dbo];
GO


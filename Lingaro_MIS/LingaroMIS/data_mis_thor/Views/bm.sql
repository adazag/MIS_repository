

CREATE view [data_mis_thor].[bm] as (
SELECT a.po_id PO_ID
		,a.id BILLG_MLSTN_ID
		, a.billing_date BILLG_MLSTN_DATE
		, a.bm_name BILLG_MLSTN_NAME
		, a.amount_before_discount BILLG_MLSTN_BEF_DISC_AMT
		, a.modified_at CHNG_DATE
		, a.modified_by CHNG_EMPEE_ID
		, a.project_id PROJ_ID
		, b.client_id
		, c.ultimate_parent_id
		, a.amount_to_invoice BILLG_MLSTN_TO_INVC_AMT
		, a.can_be_billed_ind CAN_BE_BILL_IND
		, a.currency_code BILLG_MLSTN_CRNCY_CODE
		, a.wont_be_billed_ind WONT_BE_BILL_IND
		, a.comment BILLG_MLSTN_CMMNT
		, a.crr_bm_unique_code CRR_BILLG_MLSTN_UNIQ_CODE
		, a.crr_invoice_id CRR_INVC_ID
		, a.delivery_date DLVRY_DATE
		, a.cancel_billing_reason CANCL_BILL_TXT
		, a.additional_discount_amount BM_ADDTL_DISC_AMT
		, a.reinvoice_ind REINVC_IND
		, a.crr_invoice_id CR_IND
		, a.bm_not_contracted_ind BM_NCNTRCTD_IND
		, a.bm_contracted_in_ongoing_month_ind BM_CNTRCTD_OM_IND
FROM     data_in.proj_billing_milestone AS a
LEFT OUTER JOIN data_in.proj AS b ON b.project_id  = a.project_id
LEFT OUTER JOIN data_in.proj_clnt AS c ON b.client_id = c.id
WHERE  (c.ultimate_parent_id = '0012o00002RDg2gAAD' or c.ultimate_parent_id='0012o00002RDg20AAD')
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_thor].[bm] TO [data_mis_thor_read_all]
    AS [dbo];
GO

GRANT ALTER
    ON OBJECT::[data_mis_thor].[bm] TO [data_mis_thor_read_all]
    AS [dbo];
GO


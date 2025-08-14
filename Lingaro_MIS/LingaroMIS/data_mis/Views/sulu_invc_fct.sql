create view [data_mis].[sulu_invc_fct] as(
SELECT 
	   id [INVC_ID]
      ,invoice_code [INVC_CODE]
      ,invoice_comment [INVC_CMMNT]
      ,issue_date [INVC_ISSUE_DATE]
      ,due_date [INVC_DUE_DATE]
      ,modified_at [CHNG_TIME_STAMP]
      ,modified_by [CHNG_EMPEE_ID]
      ,payment_id [PYMT_ID]
      ,delivery_date [INVC_DLVRY_DATE]
FROM data_in.fin_invoice
)
GO


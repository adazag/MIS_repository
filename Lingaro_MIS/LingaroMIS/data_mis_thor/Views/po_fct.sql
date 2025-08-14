

CREATE view  [data_mis_thor].[po_fct] as 
SELECT a.id [PO_ID]
      ,a.client_id [CLEN_ID]
      ,a.client_po_code [CLEN_PO_CODE]
      ,a.po_name [PO_NAME]
      ,a.comment [PO_CMMNT]
      ,a.currency_code [PO_CRNCY_CODE]
      ,a.available_amount [PO_AMT]
      ,a.modified_at [CHNG_DATE]
      ,a.modified_by [CHNG_EMPEE_ID]
      ,a.old_po_bill_to_text [OLD_PO_BILL_TO_TXT]
      ,a.valid_through_date [VALID_THRGH_DATE]
      ,a.bill_to_id [BILL_TO_ID]
      ,a.group_po_ind [GROUP_PO_IND]
      ,a.legal_entity_id [LE_ID]
FROM [data_in].[fin_purchase_order] a
left join data_in.proj_clnt AS b ON a.client_id =b.id
WHERE  (b.ultimate_parent_id = '0012o00002RDg2gAAD' or b.ultimate_parent_id='0012o00002RDg20AAD')
GO


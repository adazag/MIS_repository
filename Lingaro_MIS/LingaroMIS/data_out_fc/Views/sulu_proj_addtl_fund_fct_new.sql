
CREATE view [data_out_fc].[sulu_proj_addtl_fund_fct_new] as
(
SELECT a.id as [ADDTL_FUND_ID]
      ,balance_ind [ADDTL_FUND_BAL_IND]
      ,a.project_id as PROJ_ID
	  ,p.client_id as CLEN_ID
	  ,c.name as CLEN_NAME
	  ,c.ultimate_parent_id as ULTIMATE_PARENT_ID
	  ,c.ultimate_parent_name as ULTIMATE_PARENT_NAME
      ,a.source_project_id as [SRCE_PROJ_ID]
      ,a.description [ADDTL_FUND_DESC]
      ,cast(day_date as date) [ADDTL_FUND_DATE]
      ,currency_code ADDTL_FUND_CRNCY_CODE
      ,cast(a.modified_at as date) ADDTL_FUND_LAST_CHNG_DATE
      ,a.modified_by ADDTL_FUND_LAST_CHNG_EMPEE_ID
      ,fund_amount [ADDTL_FUND_AMT]
      ,fund_gross_amount [ADDTL_FUND_GROSS_AMT]
	  ,double_counting_ind as DBL_CNTNG_IND  
  FROM data_in.fin_project_additional_fund a
  left join data_in.proj p on a.project_id= p.project_id
  left join data_in.proj_clnt c on p.client_id=c.id)
GO

GRANT SELECT
    ON OBJECT::[data_out_fc].[sulu_proj_addtl_fund_fct_new] TO [data_out_fc_read_all]
    AS [dbo];
GO


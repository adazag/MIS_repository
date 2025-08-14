Create view data_out_fc.sulu_proj_addtl_fund_fct as (
SELECT [ADDTL_FUND_ID]
      ,[ADDTL_FUND_BAL_IND]
      ,a.[PROJ_ID]
	  ,p.client_id as CLEN_ID
	  ,c.name as CLEN_NAME
	  ,c.ultimate_parent_id as ULTIMATE_PARENT_ID
	  ,c.ultimate_parent_name as ULTIMATE_PARENT_NAME
      ,[SRCE_PROJ_ID]
      ,[ADDTL_FUND_DESC]
      ,cast([ADDTL_FUND_DATE] as date) [ADDTL_FUND_DATE]
      ,[CRNCY_CODE] ADDTL_FUND_CRNCY_CODE
      ,cast([LAST_CHNG_TIME_STAMP] as date) ADDTL_FUND_LAST_CHNG_DATE
      ,[LAST_CHNG_EMPEE_ID] ADDTL_FUND_LAST_CHNG_EMPEE_ID
      ,[ADDTL_FUND_AMT]
      ,[ADDTL_FUND_GROSS_AMT]
	  ,double_counting_ind as DBL_CNTNG_IND  
  FROM [data_in_sulu_v1].[sulu_proj_addtl_fund_fct] a
  left join data_in.proj p on a.PROJ_ID = p.project_id
  left join data_in.proj_clnt c on p.client_id=c.id
)
GO

GRANT SELECT
    ON OBJECT::[data_out_fc].[sulu_proj_addtl_fund_fct] TO [data_out_fc_read_all]
    AS [dbo];
GO


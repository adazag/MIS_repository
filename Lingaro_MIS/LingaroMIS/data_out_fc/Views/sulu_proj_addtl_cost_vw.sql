create view data_out_fc.sulu_proj_addtl_cost_vw as (
SELECT
	   a.[PROJ_ID]
      ,a.[PROJ_NAME]
      ,a.[PARNT_PROJ_NAME]
      ,cast([day_date] as date) [DAY_DATE]
      ,[MTH_NAME]
      ,[FINAL_COST_AMT]
      ,[ADDTL_COST_CRNCY_CODE]
      ,[ADDTL_COST_DESC]
	  ,a.CLEN_ID
	  ,a.[CLEN_NAME]
	  ,c.ultimate_parent_id as ULTIMATE_PARENT_ID
	  ,c.ultimate_parent_name as ULTIMATE_PARENT_NAME
      ,a.[PARNT_PROJ_MGR_EMPEE_NAME]
      ,[ADDTL_COST_CMMNT]
      ,[ADDTL_COST_TYPE_CODE]
	  ,organization_unit_name "Project Team"
	  ,be.LE_NAME LINGARO_BILLING_ENTITY 
  FROM data_in_sulu_v1.[sulu_proj_addtl_cost_vw] a
  left join data_mis.proj p on a.proj_id = p.project_id
  left join data_mis.billing_entity be on be.PROJ_ID=a.PROJ_ID
  left join data_in.proj_clnt c on a.CLEN_ID=c.id
)
GO

GRANT SELECT
    ON OBJECT::[data_out_fc].[sulu_proj_addtl_cost_vw] TO [data_out_fc_read_all]
    AS [dbo];
GO


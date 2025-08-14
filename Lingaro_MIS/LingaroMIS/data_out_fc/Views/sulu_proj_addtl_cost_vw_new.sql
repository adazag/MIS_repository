
CREATE view [data_out_fc].[sulu_proj_addtl_cost_vw_new] as (
SELECT
	   a.project_id [PROJ_ID]
      ,a.project_name [PROJ_NAME]
      ,p.parent_project_name [PARNT_PROJ_NAME]
      ,cast([day_date] as date) [DAY_DATE]
      ,month_name [MTH_NAME]
      ,cost_amount [FINAL_COST_AMT]
      ,currency_code [ADDTL_COST_CRNCY_CODE]
      ,a.description [ADDTL_COST_DESC]
	  ,p.client_id CLEN_ID
	  ,p.client_name [CLEN_NAME]
	  ,c.ultimate_parent_id as ULTIMATE_PARENT_ID
	  ,c.ultimate_parent_name as ULTIMATE_PARENT_NAME
      ,oe.employee_full_name [PARNT_PROJ_MGR_EMPEE_NAME]
      ,comment [ADDTL_COST_CMMNT]
      ,cost_type_code [ADDTL_COST_TYPE_CODE]
	  ,organization_unit_name "Project Team"
	  ,be.LE_NAME LINGARO_BILLING_ENTITY 
  FROM data_in.fin_project_additional_cost_report_vw a
  left join data_mis.proj p on a.project_id = p.project_id
  left join data_mis.billing_entity be on be.PROJ_ID=a.project_id
  left join data_mis.org_emp oe on p.parent_project_manager_employee_id = oe.id
  left join data_in.proj_clnt c on p.client_id=c.id
)
GO


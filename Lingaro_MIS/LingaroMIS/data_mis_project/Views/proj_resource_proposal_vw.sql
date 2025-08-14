
create view [data_mis_project].[proj_resource_proposal_vw] as (
select a.[id]
      ,[resource_proposal_id]
      ,[employee_id]
	  ,employee_full_name
      ,[role_id]
	  ,c.name as role_name
      ,a.[seniority_id]
	  ,d.name as seniority_name
      ,[cost]
	  ,b.fte
	  ,man_days
	  ,first_day_of_week
      ,a.[creation_at]
      ,a.[modified_at]
      ,a.[created_by]
      ,a.[modified_by]
      ,[competency_id]
FROM [data_in].[proj_resource_proposal_row] a
left join [data_in].[proj_resource_proposal_row_detail] b on a.id = b.resource_proposal_row_id
left join data_in.role c on a.role_id = c.id
left join data_in.seniority d on a.seniority_id = d.id
left join data_mis_project.org_emp e on a.employee_id = e.id
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_resource_proposal_vw] TO [data_mis_project_proj_resource_proposal_vw_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_resource_proposal_vw] TO [Resourcing_data_read]
    AS [dbo];
GO


create view data_out_ad.dic_project_members as
with
project_managers as (SELECT project_id as ProjectId,proj_manager_id as EmployeeId, 'PROJECT_MANAGER' as [Role]
  FROM data_mis.proj
 )

  select *
  from project_managers
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_project_members] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_project_members] TO [data_out_ad_read_all]
    AS [dbo];
GO


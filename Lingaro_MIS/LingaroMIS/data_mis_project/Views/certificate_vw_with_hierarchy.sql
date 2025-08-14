CREATE view data_mis_project.certificate_vw_with_hierarchy as(

SELECT [employee_id]
      ,[employee_full_name]
      ,[org_unit_name]
	  ,b.id as certificate_id
       ,[certificate_name]
	  ,parent_id
	  ,active_ind
  FROM [data_mis].[org_emp_certificate_vw] a
  left join data_mis.certificate_vw b on a.certificate_name = b.name
  )
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[certificate_vw_with_hierarchy] TO [data_mis_project_certificate_vw_with_hierarchy_read_all]
    AS [dbo];
GO


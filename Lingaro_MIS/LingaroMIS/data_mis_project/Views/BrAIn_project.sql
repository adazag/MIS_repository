create view [data_mis_project].[BrAIn_project] as(
SELECT project_id  
	  ,a.[name] as project_name
	  ,b.name as client_name
      ,[start_date]
      ,[end_date]
 FROM [data_in].[proj] a 
  left join data_in.proj_clnt b on a.client_id=b.id)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[BrAIn_project] TO [data_mis_project_BrAIn_project_read_all]
    AS [dbo];
GO


/****** Script for SelectTopNRows command from SSMS  ******/
create view [data_mis].[proj_org_unit] as 
SELECT [project_organization_unit_id]
      ,[project_id]
      ,[organization_unit_id]
      ,[start_date]
      ,[end_date]
      ,[current_ind]
  FROM [data_in].[proj_org_unit]
GO


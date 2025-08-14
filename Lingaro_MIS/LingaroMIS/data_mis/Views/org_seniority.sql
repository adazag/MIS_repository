/****** Script for SelectTopNRows command from SSMS  ******/

create view [data_mis].[org_seniority] as
SELECT [id]
      ,[name]
      ,[is_active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[org_seniority]
GO


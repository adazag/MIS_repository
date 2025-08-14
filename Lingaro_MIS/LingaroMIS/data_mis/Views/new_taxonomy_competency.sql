/****** Script for SelectTopNRows command from SSMS  ******/
create view [data_mis].[new_taxonomy_competency] as
SELECT [id]
      ,[name]
      ,[competency_manager_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[new_taxonomy_competency]
GO


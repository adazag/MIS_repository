/****** Script for SelectTopNRows command from SSMS  ******/

create view data_mis.skill_detail as 
SELECT [id]
      ,[name]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[skill_detail]
GO


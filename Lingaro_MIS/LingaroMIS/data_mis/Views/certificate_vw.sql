/****** Script for SelectTopNRows command from SSMS  ******/

create view data_mis.[certificate_vw] as 
SELECT [id]
      ,[name]
      ,[code]
      ,[technology_id]
      ,[skill_type_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[parent_id]
      ,[active_ind]
  FROM [data_in].[certificate]
GO


create view [data_mis_project].[employee_contract] as(
SELECT [id]
      ,[employee_id]
      ,[contract_type_id]
      ,[legal_entity_id]
      ,[start_date]
      ,[end_date]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[employee_contract]
  )
GO


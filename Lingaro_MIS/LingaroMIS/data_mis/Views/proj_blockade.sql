
create view data_mis.proj_blockade as 
SELECT [id]
      ,[employee_id]
      ,[project_id]
      ,[week_number]
      ,[start_date]
      ,[end_date]
      ,[percentage]
      ,[man_days]
      ,[hours]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[resource_proposal_id]
      ,[valid_till]
  FROM [data_in].[proj_blockade]
GO


create view data_mis.emp_skill_review as(
SELECT  [id]
      ,[employee_id]
      ,[reviewer_id]
      ,[review_date_time]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[emp_skill_review]
  )
GO


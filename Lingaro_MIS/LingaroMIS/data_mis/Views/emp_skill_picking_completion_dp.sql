create view data_mis.emp_skill_picking_completion_dp as (
SELECT [id]
      ,[employee_id]
      ,[completion_date_time]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[emp_skill_picking_completion_dp])
GO


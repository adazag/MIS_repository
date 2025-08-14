Create view data_mis.emp_reviewed_skill_history_dp as(
SELECT [id]
      ,[review_id]
      ,[skill_detail_id]
      ,[skill_detail_proficiency_level]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[skill_group_id]
      ,[skill_group_proficiency_level]
  FROM [data_in].[emp_reviewed_skill_history_dp]
  )
GO




CREATE view [data_mis].[proj_account_assignment_vw] as (
SELECT [id]
      ,[employee_id]
      ,[employee_name]
      ,[adm_account_assignment_request]
      ,[bucket_id]
      ,[bucket_name]
      ,[start_date]
      ,[end_date]
      ,[status]
      ,[comment]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[created_by_employee]
      ,[modified_by]
      ,[modified_by_employee]
      ,[reviewed_by_lm_ind]
      ,[reviewed_by_lm_id]
      ,[reviewed_by_line_manager]
      ,[review_date_time]
      ,[review_comment]
      ,[do_not_extend_ind]
      ,[adm_requestor_id]
      ,[adm_requestor]
      ,[line_manager_id]
      ,[line_manager]
      ,[approved_by_lm_ind]
      ,[rejected_by_lm_ind]
      ,[active_ind]
      ,[cc_team_id]
      ,[cc_team_name]
  FROM [data_in].[proj_account_assignment_vw]
  WHERE EXISTS (
    SELECT 1 
    FROM data_mis_project.sec_emp_all_permission
    WHERE permission_name = 'PERM_ACCOUNT_ASSIGNMENT_READ' AND email = USER_NAME()
) 
OR IS_MEMBER('db_owner') = 1
)
GO


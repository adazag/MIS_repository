

CREATE view [data_mis].[proj_account_assignment_bucket] as (
select * from [data_in].[proj_account_assignment_bucket]
WHERE EXISTS (
    SELECT 1 
    FROM data_mis_project.sec_emp_all_permission
    WHERE permission_name = 'PERM_ACCOUNT_ASSIGNMENT_READ' AND email = USER_NAME()
) 
OR IS_MEMBER('db_owner') = 1
)
GO


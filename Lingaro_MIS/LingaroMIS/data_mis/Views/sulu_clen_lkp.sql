

CREATE view [data_mis].[sulu_clen_lkp] as (
SELECT a.id as [CLEN_ID]
      ,name as [CLEN_NAME]
      ,[SHARE_POINT_NAME]
      ,account_manager_id as [ACCNT_MGR_EMPEE_ID]
	  ,employee_full_name as [ACCNT_MGR_EMPEE_NAME]
      ,[ULTIMATE_PARENT_ID]
      ,[ULTIMATE_PARENT_NAME]
      ,[SALESFORCE_ID] 
  FROM data_in.proj_clnt a 
  left join [data_in].[org_emp_vw] b on a.account_manager_id=b.id
    WHERE EXISTS (
	SELECT 1 
	FROM data_mis_project.sec_emp_all_permission 
	WHERE permission_name = 'PERM_CLIENT_READ' AND email = USER_NAME()) 
OR IS_MEMBER('db_owner') = 1 OR USER_NAME() = 'ADF-Automation-Team'
  )
GO


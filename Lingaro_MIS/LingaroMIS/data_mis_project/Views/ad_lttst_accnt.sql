
CREATE view [data_mis_project].[ad_lttst_accnt] as
(
SELECT [EMPEE_ID]
      ,[EMPEE_FULL_NAME]
      ,[EMPEE_EMAIL]
      ,[CLEN_ID]
      ,[CLEN_NAME]
      ,[PROJ_ID]
      ,[PROJ_NAME]
      ,[LATEST_DATE]
      ,[TYPE]
      ,[parent_project_manager_employee_id]
      ,[PARNT_PROJ_MGR_EMPEE_MAIL]
      ,[PARNT_PROJ_MGR_az_ad_object_id]
      ,[PARNT_PROJ_MGR_ad_object_id]  FROM [data_out_ad].[lttst_accnt])
GO


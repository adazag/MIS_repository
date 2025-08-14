
CREATE   VIEW [data_mis].[exchange_rate] AS 

SELECT [id]
      ,[base_currency_code]
      ,[exchange_rate]
      ,[start_date]
      ,[end_date]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[quote_currency_code]
FROM [data_in].[exchange_rate]
WHERE EXISTS (
SELECT 1 
FROM data_mis_project.sec_emp_all_permission
WHERE permission_name = 'PERM_EXCHANGE_RATE_READ' 
  AND email = USER_NAME()
) 
OR IS_MEMBER('db_owner') = 1;
GO


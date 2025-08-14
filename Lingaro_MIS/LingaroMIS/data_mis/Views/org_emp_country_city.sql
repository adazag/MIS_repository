create view data_mis.org_emp_country_city as 
SELECT [id]
      ,[employee_id]
      ,[country_id]
      ,[city_id]
      ,[start_date]
      ,[end_date]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[org_emp_country_city]
GO


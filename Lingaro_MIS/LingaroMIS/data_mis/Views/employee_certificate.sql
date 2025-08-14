
CREATE view [data_mis].[employee_certificate] as (
select 
	   [id]
      ,[employee_id]
      ,[certificate_id]
      ,[expiry_date]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[start_date]
      ,[end_date]
      ,[url]
from data_in.employee_certificate)
GO


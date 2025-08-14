
CREATE view [data_mis_thor].[booking] as (
select b.[id]
      ,[employee_id]
      ,b.[project_id]
	  ,p.client_id
      ,[week_number]
      ,b.[start_date]
      ,b.[end_date]
      ,[booking_percentage]
      ,[booking_man_days]
      ,[booking_hours]
      ,[status]
      ,[criticality]
      ,[comment]
      ,[competency_role_id]
      ,b.[creation_at]
      ,b.[modified_at]
      ,b.[created_by]
      ,b.[modified_by]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[working_days_cnt]
      ,[resource_row_id]
from data_in.proj_booking b
LEFT OUTER JOIN data_in.proj AS p ON b.project_id = p.project_id
LEFT OUTER JOIN data_in.proj_clnt AS c ON p.client_id = c.id
WHERE  (c.ultimate_parent_id = '0012o00002RDg2gAAD' or c.ultimate_parent_id='0012o00002RDg20AAD'))
GO


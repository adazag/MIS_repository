


CREATE   VIEW [data_mis].[proj_booking] AS 


SELECT 
	   [id]
      ,[employee_id]
      ,[project_id]
      ,[week_number]
      ,[start_date]
      ,[end_date]
      ,[booking_percentage]
      ,[booking_man_days]
      ,[booking_hours]
      ,[status]
      ,[criticality]
      ,[comment]
      ,[competency_role_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[working_days_cnt]
      ,[resource_row_id]
      ,[resource_proposal_id]
	  ,location_id
	  ,calendar_id
	  ,month_name
FROM [data_in].[proj_booking]
GO




CREATE view [data_mis].[proj_booking_monthly_vw] as (
select [employee_id]
      ,[location_id]
      ,[project_id]
      ,[project_name]
      ,[time_off_ind]
      ,[month_name]
      ,[first_day_of_month]
      ,[status]
      ,[criticality]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[comment]
      ,[booking_man_days]
      ,[working_days_cnt]
      ,[booking_percentage]
      ,[booking_hours]
from data_in.proj_booking_monthly_vw
)
GO


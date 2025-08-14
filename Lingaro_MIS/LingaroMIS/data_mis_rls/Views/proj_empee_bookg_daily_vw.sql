create view data_mis_rls.proj_empee_bookg_daily_vw with schemabinding as (
select [employee_id]
      ,[location_id]
      ,[project_id]
      ,[project_name]
      ,[first_day_of_week]
      ,[splitted_week_number]
      ,[day_date]
      ,[month_name]
      ,[booking_percentage]
      ,[booking_man_days]
      ,[booking_hours]
      ,[week_cnt_in_split]
      ,[month_cnt]
      ,[status]
      ,[criticality]
      ,[comment]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[time_off_ind]
from data_in.proj_empee_bookg_daily_vw)
GO


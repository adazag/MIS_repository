
CREATE view [data_mis].[org_working_day] as (

select 
		[day_date]
      ,[month_name]
      ,[week_name]
      ,[split_week_number]
      ,[calendar_id]
      ,[month_cnt]
      ,[week_cnt]
      ,[week_cnt_in_split]
from [data_in].[org_working_day]
)
GO


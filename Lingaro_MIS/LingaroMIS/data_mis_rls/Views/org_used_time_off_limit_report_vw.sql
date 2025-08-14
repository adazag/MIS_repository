CREATE view data_mis_rls.org_used_time_off_limit_report_vw with schemabinding as (
select 
		[id]
      ,[employee_full_name]
      ,[employee_id]
      ,[start_date]
      ,[end_date]
      ,[time_off_limit]
      ,[used_limit]
      ,[available_limit_hours]
      ,[available_limit_days]
      ,[time_off_type]
      ,[lm_id]
      ,[lm_full_name]
      ,[fm_full_name]
      ,[old_sulu_ind]
      ,[org_unit_name]
      ,[bu_name]
      ,[legal_entity]
      ,[contract_type]
      ,[used_up_to_today]
      ,[available_up_to_today]
      ,[used_up_to_previous_month]
      ,[country]
from data_in.org_used_time_off_limit_report_vw)
GO



CREATE view [data_mis_project].[client_rate_card_vw] as
(
select 
	   [id]
      ,[role_name]
      ,[client_id]
      ,[client_name]
      ,[rate]
      ,[rate_start_date]
      ,[rate_end_date]
      ,[currency_code]
      ,[modified_at]
      ,[modified_by]
      ,[creation_at]
      ,[created_by]
      ,[modifiedy_by_employee]
      ,[created_by_employee]
      ,[client_rate_card_id]
      ,[client_rate_card_name]
      ,[current_rate_ind]
      ,[country_id]
      ,[country]
      ,[seniority]
      ,[external_role_id]
      ,[internal_role_id]
      ,[competency]
      ,[family]
      ,[years_of_experience]
      ,[role_full_name]
from [data_in].[client_rate_card_vw])
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[client_rate_card_vw] TO [data_mis_project_client_rate_card_vw_read_all]
    AS [dbo];
GO


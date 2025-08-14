
CREATE view [data_out_cxms].[cxms_proj_client_emergency_contact_vw] as (
select 
	[id]
    ,[name]
    ,[account_manager_id]
    ,[employee]
    ,[account_manager_email]
    ,[last_verified_by]
    ,[last_verified_by_email]
    ,[last_verified_at]
    ,[emergency_contact]
    ,[is_active_ind]
    ,[ultimate_parent_id]
    ,[ultimate_parent_name]
    ,[share_point_group_id]
    ,[share_point_url]
    ,[delivery_owner_id]
    ,[delivery_owner]
    ,[emergency_contact_excluded_ind]
    ,[emergency_contact_exclusion_reason]
    ,[emergency_contact_modified_at]
    ,[emergency_contact_modified_by]
from data_in.proj_client_emergency_contact_vw)
GO

GRANT SELECT
    ON OBJECT::[data_out_cxms].[cxms_proj_client_emergency_contact_vw] TO [data_out_cxms_read_all]
    AS [dbo];
GO


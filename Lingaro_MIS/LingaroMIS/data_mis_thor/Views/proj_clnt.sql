

CREATE view [data_mis_thor].[proj_clnt] as (
select 
	[id]
	,[name]
	,[share_point_name]
	,[leave_contact_email]
	,[leave_notification_period_days]
	,[active_notification_ind]
	,[account_manager_id]
	,[created_by]
	,[modified_by]
	,[modified_at]
	,[creation_at]
	,[salesforce_id]
	,[ultimate_parent_id]
	,[ultimate_parent_name]
	,[emergency_contact]
	,[last_verified_at]
	,[last_verified_by]
	,[share_point_group_id]
	,[share_point_url]
	,[delivery_owner_id]
	,[emergency_contact_excluded_ind]
	,[emergency_contact_exclusion_reason]
	,[emergency_contact_modified_at]
	,[emergency_contact_modified_by]
	,[industry]
	,[industry_group]
	,[industry_description]
	,[stars_segmentation]
	,[type]from data_in.proj_clnt
where ultimate_parent_id = '0012o00002RDg2gAAD' or ultimate_parent_id='0012o00002RDg20AAD')
GO


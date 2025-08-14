
CREATE view [data_mis].[proj_client_emergency_contact_vw] as
(
SELECT id
		,name
		,account_manager_id
		,employee
		,account_manager_email
		,last_verified_by
		,last_verified_by_email
		,last_verified_at
		,emergency_contact
		,is_active_ind
		,ultimate_parent_id
		,ultimate_parent_name
		,share_point_group_id
		,share_point_url
		,delivery_owner_id
		,delivery_owner
		,emergency_contact_excluded_ind
		,emergency_contact_exclusion_reason
		,emergency_contact_modified_at
		,emergency_contact_modified_by
FROM     data_in.proj_client_emergency_contact_vw
WHERE EXISTS (
    SELECT 1 
    FROM data_mis_project.sec_emp_all_permission
    WHERE permission_name = 'PERM_CLIENT_READ' AND email = USER_NAME()
) 
OR IS_MEMBER('db_owner') = 1
)
GO


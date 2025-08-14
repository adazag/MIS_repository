
CREATE PROCEDURE[rls].[update_account_hier_full_path_split] as

IF OBJECT_ID('[rls].[account_hier_full_path_split]', 'U') IS NOT NULL TRUNCATE TABLE [rls].[account_hier_full_path_split];

insert into  [rls].[account_hier_full_path_split]
SELECT [id]
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
FROM [data_in].[proj_client_emergency_contact_vw]
GO

GRANT EXECUTE
    ON OBJECT::[rls].[update_account_hier_full_path_split] TO [lingaro-mis-adf]
    AS [dbo];
GO


create view data_out_ad.dic_projects as
with
tot as (SELECT project_id as ProjectId, name as ProjectName, creation_date as CreatedDate, start_date as StartDate, end_date as EndDate, status_code as [Status], client_id as [ClientId],
change_date as ChangeDate, share_point_link as SharepointLink, share_point_group_id as SharepointGroupId FROM data_in.proj
 )
 

  select * 
  from tot
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_projects] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_projects] TO [data_out_ad_read_all]
    AS [dbo];
GO


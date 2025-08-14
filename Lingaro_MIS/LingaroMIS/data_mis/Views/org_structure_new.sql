




CREATE view [data_mis].[org_structure_new] as (
select 
	   a.[id] as org_unit_id
      ,a.[name] as org_unit_name
	  ,ou.start_date
	  ,ou.end_date
      ,a.[parent_id] as org_unit_parent_id
      ,a.[unit_level]
      ,a.[type]
      ,a.[leader_id]
      ,a.[area]
      ,[team_id]
      ,[team_name]
      ,[parnt_team_id] as parent_team_id
      ,[team_lvl]
      ,[team_type]
      ,[team_leader_id]
      ,[team_area]
      ,[delivery_team_id] as sub_division_id
      ,[delivery_team_name] as sub_division_name
      ,[parnt_delivery_team_id] as parent_sub_division_id
      ,[delivery_team_lvl] as sub_division_lvl
      ,[delivery_team_type] as sub_division_type
      ,[delivery_team_leader_id] as sub_division_leader_id
      ,[delivery_team_area] as sub_division_area
      ,[senior_delivery_team_id] as division_id
      ,[senior_delivery_team_name] as division_name
      ,[parnt_senior_delivery_team_id] as parent_division_id
      ,[senior_delivery_team_lvl] as division_lvl
      ,[senior_delivery_team_type] as division_type
      ,[senior_delivery_team_leader_id] as division_leader_id
      ,[senior_delivery_team_area] as division_area
      ,[sub_bu_id] as department_id
      ,[sub_bu_name] as department_name
      ,[sub_parnt_bu_id] as parent_department_id
      ,[sub_bu_lvl] as department_lvl
      ,[sub_bu_type] as department_type
      ,[sub_bu_leader_id] as department_leader_id
      ,[sub_bu_area] as department_area
      ,[bu_id] as organization_id
      ,[bu_name] as organization_name
      ,[parnt_bu_id]  as parent_organization_id
	  ,o.name as parent_organization_name
      ,[bu_lvl] as organization_lvl
      ,[bu_type] as organization_type
      ,[bu_leader_id] as organization_leader_id
      ,[bu_area] as organization_area
FROM data_in.org_unit_flatten a
left join data_in.org_unit ou on a.id = ou.id
left join data_in.org_unit o on a.parnt_bu_id = o.id
----where start_date >= '2023-01-01' or end_date >= '2023-01-01'
)
GO


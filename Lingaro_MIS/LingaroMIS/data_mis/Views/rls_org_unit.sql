

CREATE view [data_mis].[rls_org_unit]
as
SELECT unit.[id] as org_unit_id
      ,unit.[name] as org_unit_name
	  ,unit.leader_id as org_unit_leader_id
	  ,oe.email as org_unit_leader_email
      ,unit.[parent_id] as org_unit_parent_id
	  ,parent_unit.leader_id as org_unit_parent_leader_id
	  ,oep.email as org_unit_parent_leader_email
      ,unit.[start_date]
      ,unit.[end_date]
      --,[unit_level]
      --,[type]
      --,[dc_ind]
      --,[area]
      --,[team_level]
  FROM [data_in].[org_unit] unit
  LEFT JOIN [data_in].[org_unit] parent_unit ON unit.parent_id = parent_unit.id
  LEFT JOIN data_in.org_emp oe on unit.leader_id=oe.id
  LEFT JOIN data_in.org_emp oep on parent_unit.leader_id=oep.id
GO


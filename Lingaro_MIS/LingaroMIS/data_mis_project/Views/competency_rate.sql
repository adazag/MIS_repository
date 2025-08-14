create view [data_mis_project].[competency_rate] as(

SELECT a.[id]
      ,[role_id]
	  ,b.name as role_name
      ,a.[competency_id]
	  ,c.name as competency_name
      ,[currency_code]
      ,[rate_start_date]
      ,[rate_end_date]
      ,[rate]
      ,[seniority_id]
	  ,e.name as seniority_name
      ,[country_id]
	  ,d.name as country_name
      ,[competency_rate_card_id]
	  ,f.name as competency_rate_card_name
      ,a.[creation_at]
      ,a.[modified_at]
      ,a.[created_by]
      ,a.[modified_by]
	  ,case
           when (coalesce(a.rate_start_date, cast('1999-01-01' as DATE)) <= getdate() and
                 coalesce(a.rate_end_date, cast('2999-01-01' as DATE)) >= getdate()) then cast(1 as BIT)
           else cast(0 as BIT)
           end as current_rate_ind
FROM [data_in].[competency_rate] a
left join data_in.role b on a.role_id = b.id
left join [data_in].[new_taxonomy_competency] c on c.id = a.competency_id
left join [data_in].[org_country] d on a.country_id = d.id
left join [data_in].[seniority] e on a.seniority_id = e.id
left join [data_in].[competency_rate_card] f on a.competency_rate_card_id = f.id
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[competency_rate] TO [data_mis_project_competency_rate_read_all]
    AS [dbo];
GO


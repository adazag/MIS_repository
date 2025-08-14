create view data_mis_project.emp_proj_booking as
WITH 

BOOKING as(
SELECT [id]
      ,[employee_id]
      ,[project_id]
      ,[week_number]
      ,[start_date]
      ,[end_date]
      ,[booking_percentage]
      ,[booking_man_days]
      ,[booking_hours]
      ,[status]
      ,[criticality]
      ,[comment]
      ,[competency_role_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[working_days_cnt]
  FROM [data_in].[proj_booking]
),

  ROLE as (
  SELECT [id]
      ,[name]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[role]),

  SENIORITY as (
  SELECT [id]
      ,[name]
      ,[is_active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[seniority]),

  COMPETENCY as (
  SELECT [id]
      ,[name]
      ,[competency_manager_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[new_taxonomy_competency]),

  COMPETENCY_RATE_CARD as (
  SELECT [id]
      ,[competency_id]
      ,[name]
      ,[is_active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[effective_date]
      ,[start_date]
      ,[end_date]
  FROM [data_in].[competency_rate_card])


  SELECT a.[id]
        ,a.[employee_id]
      ,a.[project_id]
      ,a.[week_number]
      ,a.[start_date]
      ,a.[end_date]
      ,a.[booking_percentage]
      ,a.[booking_man_days]
      ,a.[booking_hours]
      ,a.[status]
      ,a.[criticality]
      ,a.[comment]
      ,a.[competency_role_id]
      ,a.[creation_at]
      ,a.[modified_at]
      ,a.[created_by]
      ,a.[modified_by]
      ,a.[competency_id]
	  ,d.name as competency_name
      ,a.[role_id]
	  ,b.name as role_name
      ,a.[seniority_id]
	  ,c.name as seniority_name
      ,a.[working_days_cnt]
	  --,e.id as competency_rate_card_id
	  --,e.name as competency_rate_card_name

	FROM BOOKING a
  LEFT JOIN ROLE b on a.role_id=b.id
  LEFT JOIN SENIORITY c on a.seniority_id=c.id
  LEFT JOIN COMPETENCY d on a.competency_id=d.id
  LEFT JOIN COMPETENCY_RATE_CARD e on a.competency_id=e.competency_id and a.start_date>=e.start_date and a.end_date<=e.end_date
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[emp_proj_booking] TO [data_mis_project_emp_proj_booking_read_all]
    AS [dbo];
GO


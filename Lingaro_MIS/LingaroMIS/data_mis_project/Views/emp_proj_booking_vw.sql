create view data_mis_project.emp_proj_booking_vw as
WITH 

BOOKING as(
SELECT 
--[booking_id]
       [employee_id]
      ,[employee_full_name]
      ,[location_id]
      ,[email]
      ,[project_id]
      ,[project_name]
      ,[day_date]
      ,[month_name]
      ,[first_day_of_week]
      ,[week_number]
      ,[splitted_week_number]
      ,[booking_percentage]
      ,[booking_man_days]
      ,[booking_hours]
      ,[week_cnt_in_split]
      ,[month_cnt]
      ,[status]
      ,[start_date]
      ,[end_date]
      ,[criticality]
      ,[time_off_ind]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[competency_role_full_name]
      ,[comment]
  FROM [data_in].[proj_booking_daily_vw]
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


  SELECT
       [employee_id]
      ,[employee_full_name]
      ,[location_id]
      ,[email]
      ,[project_id]
      ,[project_name]
      ,[day_date]
      ,[month_name]
      ,[first_day_of_week]
      ,[week_number]
      ,[splitted_week_number]
      ,[booking_percentage]
      ,[booking_man_days]
      ,[booking_hours]
      ,[week_cnt_in_split]
      ,[month_cnt]
      ,[status]
      ,a.[start_date]
      ,a.[end_date]
      ,[criticality]
      ,[time_off_ind]
      ,a.[competency_id]	  
	  ,d.name as competency_name
      ,[role_id]
	  ,b.name as role_name
      ,[seniority_id]
	  ,c.name as seniority_name
      ,[comment]


	  --,e.id as competency_rate_card_id
	  --,e.name as competency_rate_card_name

	FROM BOOKING a
  LEFT JOIN ROLE b on a.role_id=b.id
  LEFT JOIN SENIORITY c on a.seniority_id=c.id
  LEFT JOIN COMPETENCY d on a.competency_id=d.id
  LEFT JOIN COMPETENCY_RATE_CARD e on a.competency_id=e.competency_id and a.start_date>=e.start_date and a.end_date<=e.end_date
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[emp_proj_booking_vw] TO [data_mis_project_emp_proj_booking_vw]
    AS [dbo];
GO


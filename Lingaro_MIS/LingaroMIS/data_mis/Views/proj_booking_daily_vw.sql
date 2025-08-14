create view data_mis.proj_booking_daily_vw as 
SELECT booking_id, employee_id, employee_full_name, location_id, email, project_id, project_name, day_date, month_name, first_day_of_week, week_number, splitted_week_number, booking_percentage, booking_man_days, booking_hours, 
                  week_cnt_in_split, month_cnt, status, start_date, end_date, criticality, time_off_ind, competency_id, role_id, seniority_id, competency_role_full_name, comment
FROM     data_in.proj_booking_daily_vw
GO


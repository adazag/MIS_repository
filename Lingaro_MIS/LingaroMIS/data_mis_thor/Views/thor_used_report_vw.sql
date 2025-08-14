create view data_mis_thor.thor_used_report_vw as select employee_booking_weekly.project_id         project_id,
       bm.BILLG_MLSTN_ID                          bm_id,
	   employee_booking_weekly.week               week,
	   employee_booking_weekly.employee_id        employee_id,
	   employee_booking_weekly.month_name         month,
       employee_booking_weekly.employee_full_name full_name,
	   actual_time_and_cost.actual_cost           actual_cost,
	   actual_time_and_cost.actual_time           actual_time,
	   booking_cost.booking_cost                  booking_cost,
       employee_booking_weekly.booking_hours      booking_time,
       bm.BILLG_MLSTN_CRNCY_CODE                  currency
from (select project_id,
             employee_id,
             employee_full_name,
             month_name,
             concat(format(first_day_of_week, 'yyyy-MM-dd'), '-',
                    format(dateadd(day, 6, first_day_of_week), 'yyyy-MM-dd')) week,
             sum(booking_hours)                                               booking_hours
      from data_mis.proj_booking_daily_vw
      where status = 'CONFIRMED'
      group by project_id,
               employee_id,
               employee_full_name,
               month_name,
               concat(format(first_day_of_week, 'yyyy-MM-dd'), '-',
                      format(dateadd(day, 6, first_day_of_week), 'yyyy-MM-dd'))) employee_booking_weekly
         left join data_mis_thor.project project
                   on employee_booking_weekly.project_id = project.project_id
         left join (select proj_booking_daily_vw.project_id,
                           proj_booking_daily_vw.employee_id,
                           concat(format(first_day_of_week, 'yyyy-MM-dd'), '-',
                                  format(dateadd(day, 6, first_day_of_week), 'yyyy-MM-dd')) week,
                           sum(proj_booking_daily_vw.booking_hours * client_rate_card.rate) booking_cost
                    from data_mis.proj_booking_daily_vw proj_booking_daily_vw
                             left join data_mis_thor.client_rate_card client_rate_card
                                       on proj_booking_daily_vw.project_id = client_rate_card.project_id
                                           and proj_booking_daily_vw.employee_id = client_rate_card.employee_id
                                           and proj_booking_daily_vw.day_date >= client_rate_card.rate_start_date
                                           and proj_booking_daily_vw.day_date <= client_rate_card.rate_end_date
                    where proj_booking_daily_vw.status = 'CONFIRMED'
                    group by proj_booking_daily_vw.project_id,
                             proj_booking_daily_vw.employee_id,
                             concat(format(first_day_of_week, 'yyyy-MM-dd'), '-',
                                    format(dateadd(day, 6, first_day_of_week), 'yyyy-MM-dd'))) booking_cost
                   on employee_booking_weekly.project_id = booking_cost.project_id and
                      employee_booking_weekly.employee_id = booking_cost.employee_id and
                      employee_booking_weekly.week = booking_cost.week
         left join (select timesheet_with_week.project_id,
                           timesheet_with_week.employee_id,
                           concat(format(first_day_of_week, 'yyyy-MM-dd'), '-',
                                  format(dateadd(day, 6, first_day_of_week), 'yyyy-MM-dd')) week,
                           sum(timesheet_with_week.hours)                                   actual_time,
                           sum(hours * client_rate_card.rate)                               actual_cost
                    from (select project_id,
                                 employee_id,
                                 day_date,
                                 hours,
                                 case
                                     when (format(timesheet.day_date, 'yyyy-MM') =
                                           format(datetrunc(iso_week, timesheet.day_date), 'yyyy-MM') and
                                           format(timesheet.day_date, 'yyyy-MM') =
                                           format(dateadd(day, 4, datetrunc(iso_week, timesheet.day_date)), 'yyyy-MM'))
                                         then datetrunc(iso_week, timesheet.day_date)
                                     else case
                                              when format(timesheet.day_date, 'yyyy-MM') =
                                                   format(datetrunc(iso_week, timesheet.day_date), 'yyyy-MM')
                                                  then datetrunc(iso_week, timesheet.day_date)
                                              else datetrunc(month, timesheet.day_date)
                                         end
                                     end as first_day_of_week
                          from data_mis_thor.timesheet timesheet
                          where status = 'APPROVED'
                             or status = 'VERIFICATION') timesheet_with_week
                             left join data_mis_thor.client_rate_card
                                       on timesheet_with_week.project_id = client_rate_card.project_id
                                           and timesheet_with_week.employee_id = client_rate_card.employee_id
                                           and timesheet_with_week.day_date >= client_rate_card.rate_start_date
                                           and timesheet_with_week.day_date <= client_rate_card.rate_end_date
                    group by timesheet_with_week.project_id,
                             timesheet_with_week.employee_id,
                             concat(format(first_day_of_week, 'yyyy-MM-dd'), '-',
                                    format(dateadd(day, 6, first_day_of_week), 'yyyy-MM-dd'))) actual_time_and_cost
                   on actual_time_and_cost.project_id = booking_cost.project_id and
                      actual_time_and_cost.employee_id = booking_cost.employee_id and
                      actual_time_and_cost.week = booking_cost.week
         left join data_mis_thor.bm bm
                   on employee_booking_weekly.project_id = bm.PROJ_ID
                       and employee_booking_weekly.month_name = format(bm.DLVRY_DATE, 'yyyy-MM')
where project.invoicing_code = 'TMM'
  and (project.status_code = 'CONFIRMED' or project.status_code = 'CLOSURE')
  and bm.BILLG_MLSTN_ID is not null;
GO


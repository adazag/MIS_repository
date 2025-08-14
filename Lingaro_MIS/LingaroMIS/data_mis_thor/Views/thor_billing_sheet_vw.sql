create view data_mis_thor.thor_billing_sheet_vw as
select bm.BILLG_MLSTN_ID                           billing_sheet_id,
       bm.PROJ_ID                                  project_id,
       bm.BILLG_MLSTN_DATE                         billing_date,
       bm.DLVRY_DATE                               delivery_date,
       bm.BILLG_MLSTN_NAME                         bm_name,
       actual_cost.actual_cost                     actual_cost,
       actual_time.actual_time                     actual_time,
       booking_cost.booking_cost                   booking_cost,
       project_monthly_booking_hours.booking_hours booking_time,
       bm.BILLG_MLSTN_CRNCY_CODE                   currency,
       actual_time.actual_time                     actual_client_time,
       actual_cost.actual_cost                     actual_client_cost
from data_mis_thor.project project
         left join data_mis_thor.bm bm
                   on project.project_id = bm.PROJ_ID
         left join (select project_id,
                           month_name,
                           sum(booking_hours) booking_hours
                    from data_mis.proj_booking_daily_vw
                    where status = 'CONFIRMED'
                    group by project_id, month_name) project_monthly_booking_hours
                   on bm.PROJ_ID = project_monthly_booking_hours.project_id and
                      concat(year(bm.DLVRY_DATE), '-', format(bm.DLVRY_DATE, 'MM')) =
                      project_monthly_booking_hours.month_name
         left join (select project_month_cost.project_id,
                           concat(year(project_month_cost.day_date), '-',
                                  format(project_month_cost.day_date, 'MM')) month_name,
                           sum(project_month_cost.booking_cost)              booking_cost
                    from (select employee_day_cost.project_id,
                                 employee_day_cost.day_date,
                                 sum(employee_day_cost.booking_cost) booking_cost
                          from (select client_rate_card.project_id,
                                       client_rate_card.employee_id,
                                       employee_booking_daily.day_date,
                                       client_rate_card.rate * employee_booking_daily.booking_hours booking_cost
                                from data_mis_thor.client_rate_card client_rate_card
                                         left join (select project_id,
                                                           employee_id,
                                                           day_date,
                                                           sum(booking_hours) booking_hours
                                                    from data_mis.proj_booking_daily_vw
                                                    group by project_id,
                                                             employee_id,
                                                             day_date) employee_booking_daily
                                                   on client_rate_card.project_id = employee_booking_daily.project_id
                                                       and
                                                      client_rate_card.employee_id = employee_booking_daily.employee_id
                                                       and employee_booking_daily.day_date >=
                                                           client_rate_card.rate_start_date
                                                       and employee_booking_daily.day_date <=
                                                           client_rate_card.rate_end_date) employee_day_cost
                          where booking_cost is not null
                          group by employee_day_cost.project_id, employee_day_cost.day_date) project_month_cost
                    group by project_month_cost.project_id,
                             concat(year(project_month_cost.day_date), '-',
                                    format(project_month_cost.day_date, 'MM'))) booking_cost
                   on bm.PROJ_ID = booking_cost.project_id
                       and concat(year(bm.DLVRY_DATE), '-', format(bm.DLVRY_DATE, 'MM')) = booking_cost.month_name
         left join (select project_id,
                           concat(year(day_date), '-', format(day_date, 'MM')) month_name,
                           sum(hours)                                          actual_time
                    from data_mis_thor.timesheet
                    where status = 'APPROVED'
                       or status = 'VERIFICATION'
                    group by project_id, concat(year(day_date), '-', format(day_date, 'MM'))) actual_time
                   on bm.PROJ_ID = actual_time.project_id
                       and concat(year(bm.DLVRY_DATE), '-', format(bm.DLVRY_DATE, 'MM')) = actual_time.month_name
         left join (select employee_monthly_actual_cost.project_id,
                           employee_monthly_actual_cost.month_name,
                           sum(employee_monthly_actual_cost.actual_cost) actual_cost
                    from (select project_id,
                                 employee_id,
                                 concat(year(employee_daily_actual_cost.day_date), '-',
                                        format(employee_daily_actual_cost.day_date, 'MM')) month_name,
                                 sum(employee_daily_actual_cost.actual_cost)               actual_cost
                          from (select client_rate_card.project_id,
                                       client_rate_card.employee_id,
                                       employee_timesheet_daily.day_date,
                                       client_rate_card.rate * employee_timesheet_daily.hours actual_cost
                                from data_mis_thor.client_rate_card client_rate_card
                                         left join (select project_id,
                                                           employee_id,
                                                           day_date,
                                                           hours
                                                    from data_mis_thor.timesheet) employee_timesheet_daily
                                                   on client_rate_card.project_id = employee_timesheet_daily.project_id
                                                       and client_rate_card.employee_id =
                                                           employee_timesheet_daily.employee_id
                                                       and employee_timesheet_daily.day_date >=
                                                           client_rate_card.rate_start_date
                                                       and employee_timesheet_daily.day_date <=
                                                           client_rate_card.rate_end_date) employee_daily_actual_cost
                          where employee_daily_actual_cost.actual_cost is not null
                          group by project_id,
                                   employee_id,
                                   concat(year(employee_daily_actual_cost.day_date), '-',
                                          format(employee_daily_actual_cost.day_date, 'MM'))) employee_monthly_actual_cost
                    group by project_id, month_name) actual_cost
                   on bm.PROJ_ID = actual_cost.project_id and
                      concat(year(bm.DLVRY_DATE), '-', format(bm.DLVRY_DATE, 'MM')) = actual_cost.month_name
where project.invoicing_code = 'TMM'
  and bm.BILLG_MLSTN_ID is not null;
GO


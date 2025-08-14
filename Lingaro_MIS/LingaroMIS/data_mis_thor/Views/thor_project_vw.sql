create view data_mis_thor.thor_project_vw
as select proj.project_id                                                                                   id,
       proj.project_name                                                                                 name,
       bm.PO_ID                                                                                          purchase_order,
       proj.client_contact_email                                                                         client_pm_email,
       org_emp.email                                                                                     lingaro_pm_email,
       proj.start_date                                                                                   start_date,
       proj.end_date                                                                                     end_date,
       case when proj.status_code = 'CONFIRMED' or proj.status_code = 'CLOSURE' then 'Y' else 'N' end as is_active,
       bm.BILLG_MLSTN_CRNCY_CODE                                                                         currency,
       actual_cost.project_actual_cost                                                                   actual_cost,
       timesheet.hours_sum                                                                               actual_time,
       booking_cost.booking_cost                                                                         booking_cost,
       proj_booking_daily_vw.booking_hours                                                               booking_time,
       bm.CAN_BE_BILL_IND                                                                                bm_orphan,
       client_rate_card.missing_specific_rates                                                           missing_specific_rates,
       timesheet.hours_sum                                                                               actual_client_time,
       actual_cost.project_actual_cost                                                                   actual_client_cost
from data_mis_thor.project proj
         left join (select PROJ_ID,
                           PO_ID,
                           CAN_BE_BILL_IND,
                           BILLG_MLSTN_DATE,
                           BILLG_MLSTN_CRNCY_CODE
                    FROM (select PROJ_ID,
                                 PO_ID,
                                 CAN_BE_BILL_IND,
                                 BILLG_MLSTN_DATE,
                                 BILLG_MLSTN_CRNCY_CODE,
                                 rank() over (partition by PROJ_ID order by BILLG_MLSTN_DATE desc, PO_ID desc) bm_rank
                          FROM data_mis_thor.bm) a
                    where bm_rank = 1) bm
                   on proj.project_id = bm.proj_id
         left join (select project_id,
                           case when count(*) = count(rate) then 'N' else 'Y' end as missing_specific_rates
                    from data_mis_thor.client_rate_card
                    group by project_id) client_rate_card
                   on proj.project_id = client_rate_card.project_id
         left join data_mis_project.org_emp org_emp
                   on proj.proj_manager_id = org_emp.id
         left join (select project_id, sum(hours) hours_sum
                    from data_mis_thor.timesheet
                    where status = 'APPROVED'
                       or status = 'VERIFICATION'
                    group by project_id) timesheet
                   on proj.project_id = timesheet.project_id
         left join (select project_id, sum(booking_hours) booking_hours
                    from data_mis.proj_booking_daily_vw
                    where status = 'CONFIRMED'
                    group by project_id) proj_booking_daily_vw
                   on proj.project_id = proj_booking_daily_vw.project_id
         left join (select project_id,
                           sum(project_booking_cost.employee_booking_cost) booking_cost
                    from (select client_rate_card.project_id,
                                 client_rate_card.employee_id,
                                 client_rate_card.rate,
                                 proj_booking_daily_vw.booking_hours,
                                 rate * booking_hours as employee_booking_cost
                          from data_mis_thor.client_rate_card client_rate_card
                                   left join (select project_id, employee_id, sum(booking_hours) booking_hours
                                              from data_mis.proj_booking_daily_vw
                                              group by project_id, employee_id) proj_booking_daily_vw
                                             on client_rate_card.project_id = proj_booking_daily_vw.project_id and
                                                client_rate_card.employee_id =
                                                proj_booking_daily_vw.employee_id) project_booking_cost
                    group by project_id) booking_cost
                   on proj.project_id = booking_cost.project_id
         left join (select employee_actual_cost.project_id,
                           sum(employee_actual_cost.actual_cost) project_actual_cost
                    from (select client_rate_card.project_id,
                                 client_rate_card.employee_id,
                                 client_rate_card.rate * timesheet.hours_sum actual_cost
                          from data_mis_thor.client_rate_card client_rate_card
                                   left join (select project_id, employee_id, sum(hours) hours_sum
                                              from data_mis_thor.timesheet
                                              where status = 'APPROVED'
                                                 or status = 'VERIFICATION'
                                              group by project_id, employee_id) timesheet
                                             on client_rate_card.project_id = timesheet.project_id and
                                                client_rate_card.employee_id =
                                                timesheet.employee_id) employee_actual_cost
                    group by employee_actual_cost.project_id) actual_cost
                   on proj.project_id = actual_cost.project_id
where proj.status_code = 'CONFIRMED'
   or proj.status_code = 'CLOSURE';
GO


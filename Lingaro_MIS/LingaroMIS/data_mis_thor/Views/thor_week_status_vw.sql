create view data_mis_thor.thor_week_status_vw as select thor_used_report_vw.bm_id        bm_id,
       thor_used_report_vw.week         week,
       thor_used_report_vw.project_id   project_id,
       project_manager_email.email      pm_email,
       thor_used_report_vw.actual_cost  actual_cost,
       thor_used_report_vw.actual_time  actual_time,
       thor_used_report_vw.booking_cost booking_cost,
       thor_used_report_vw.booking_time booking_time,
       thor_used_report_vw.currency     currency
from (select bm_id,
             week,
             project_id,
             sum(actual_cost)  actual_cost,
             sum(actual_time)  actual_time,
             sum(booking_cost) booking_cost,
             sum(booking_time) booking_time,
             currency
      from data_mis_thor.thor_used_report_vw
      group by bm_id, week, project_id, currency) thor_used_report_vw
         left join (select project.project_id,
                           project.proj_manager_id,
                           org_emp.email
                    from data_mis_thor.project
                             left join data_mis_project.org_emp
                                       on project.proj_manager_id = org_emp.id) project_manager_email
                   on thor_used_report_vw.project_id = project_manager_email.project_id;
GO


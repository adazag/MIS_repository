CREATE view [data_out_pg].[sulu_pg_info_vw]

as

SELECT id, employee_full_name, email, pg_t_number_deprecated as pg_t_number
FROM   data_in.org_emp_vw
WHERE (active_ind = '1')
GO


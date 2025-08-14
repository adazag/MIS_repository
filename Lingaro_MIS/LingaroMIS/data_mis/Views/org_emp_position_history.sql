


CREATE view [data_mis].[org_emp_position_history] as
WITH active AS 
(
SELECT id
FROM data_in.org_emp_vw
WHERE (active_ind = 1)
)


SELECT 
	b.id
	,b.employee_id
	,b.position_id
	,b.start_date
	,b.end_date
	,c.name as level_change_reason
FROM data_in.org_employee_position AS b 
LEFT JOIN data_in.level_change_reason AS c ON b.level_change_reason_id = c.id
INNER JOIN active AS a ON a.id = b.employee_id
GO


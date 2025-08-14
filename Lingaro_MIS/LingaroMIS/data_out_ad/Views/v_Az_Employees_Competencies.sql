






/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [data_out_ad].[v_Az_Employees_Competencies] as
SELECT 

	employee_id as [EmployeeId], 
	STRING_AGG( '<' + CONCAT(SUBSTRING (preference, 1, 1), competency_role_id) + '>',NULL) as Competencies

FROM 
	[data_mis].[employee_competency_role] 
WHERE employee_id > 0
GROUP BY employee_id
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees_Competencies] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees_Competencies] TO [data_out_ad_alter_all]
    AS [dbo];
GO




CREATE VIEW [data_out_ad].[v_Az_Employees_ProjectIDs]
AS
SELECT t1.[empee_id]                                                AS EmployeeId,
       String_agg('<' + Cast(t1.[project_id] AS VARCHAR) + '>', '') AS ProjectIds,
       data_out_ad.v_az_employees.FullName,
       data_out_ad.v_az_employees.Email,
       data_out_ad.v_az_employees.AzADObjectId,
	   data_out_ad.v_az_employees.IsActive
FROM   (SELECT DISTINCT [empee_id],
                        [project_id]
        FROM   data_out_ad.latest_accounts
        WHERE  ( [empee_id] > 0
                 AND [project_id] > 7
                 AND Datediff(m, latest_date, Getdate()) <= 12
                 AND [role] = 'EMP' )) AS t1
       LEFT OUTER JOIN data_out_ad.v_az_employees
                    ON t1.[empee_id] = data_out_ad.v_az_employees.employeeid
GROUP  BY t1.[empee_id],
          data_out_ad.v_az_employees.fullname,
          data_out_ad.v_az_employees.email,
          data_out_ad.v_az_employees.azadobjectid,
		  data_out_ad.v_az_employees.IsActive
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees_ProjectIDs] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees_ProjectIDs] TO [data_out_ad_alter_all]
    AS [dbo];
GO


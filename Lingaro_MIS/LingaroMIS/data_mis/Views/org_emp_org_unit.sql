

CREATE   view [data_mis].[org_emp_org_unit] as

with 
active as
(select id
from data_in.[org_emp_vw] 
--where active_ind=1
)

SELECT 
		b.[id]
      ,b.[employee_id]
      ,b.[organization_unit_id]
      ,b.[start_date]
      ,b.[end_date]
FROM [data_in].[org_emp_org_unit] b
join active a on a.id=b.employee_id;
GO


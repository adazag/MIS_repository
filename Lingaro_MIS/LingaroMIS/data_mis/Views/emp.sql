
CREATE view [data_mis].[emp]
as 
select id as emp_id,
location,
IIF(active_ind=1, email, CONCAT('Employee not active ', id )) as email,
active_ind as activ_ind
from data_in.org_emp
where technical_account_ind = 0
GO


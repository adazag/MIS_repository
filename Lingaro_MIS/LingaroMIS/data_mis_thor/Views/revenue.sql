
CREATE view [data_mis_thor].[revenue] as 
SELECT a.ID,
a.PROJ_ID, 
b.client_id, 
c.name AS client_name, 
c.ultimate_parent_id, 
c.ultimate_parent_name
, a.CRNCY_DAY_DATE
, a.DAY_DATE
, a.CRNCY_CODE
, a.AMT_BEFORE_DISC
, a.AMT_DISC
,a.AMT_AFTER_DISC
, a.CRNCY_RATE, 
   a.AMT_BEFORE_DISC_PLN
   , a.AMT_DISC_PLN
   , a.AMT_AFTER_DISC_PLN
   ,a.TYPE
FROM     data_mis_project.revenue AS a LEFT OUTER JOIN
                  data_in.proj AS b ON a.PROJ_ID = b.project_id LEFT OUTER JOIN
                  data_in.proj_clnt AS c ON b.client_id = c.id
WHERE  (c.ultimate_parent_id = '0012o00002RDg2gAAD' or c.ultimate_parent_id='0012o00002RDg20AAD')
GO


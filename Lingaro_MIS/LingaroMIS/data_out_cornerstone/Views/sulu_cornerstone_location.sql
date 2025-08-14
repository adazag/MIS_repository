
   Create   VIEW [data_out_cornerstone].[sulu_cornerstone_location] AS 
  SELECT distinct
	 [calendar_id] as 'OU ID'

      ,CASE [calendar_id] WHEN '1' THEN 'Poland' WHEN '2' THEN 'Philippines' WHEN '3' THEN 'US' WHEN '4' THEN 'Switzerland' WHEN '5' THEN 'Singapore' WHEN '6' THEN 'India' WHEN '7' THEN 'Mexico' WHEN '7' THEN 'Switzerland' WHEN '7' THEN 'Mexico' END AS 'OU Name'
	  ,CASE [calendar_id] WHEN '1' THEN '31' WHEN '2' THEN '59' WHEN '3' THEN '14' WHEN '4' THEN '28' WHEN '5' THEN '59' WHEN '6' THEN '49' WHEN '7' THEN '79' END AS 'Time Zone'
  FROM [data_in].[org_legal_entity] where calendar_id in (1, 2, 3, 4, 5, 6, 7)
GO


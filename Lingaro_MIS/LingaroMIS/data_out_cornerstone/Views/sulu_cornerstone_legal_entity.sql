
  Create   VIEW [data_out_cornerstone].[sulu_cornerstone_legal_entity] AS 
  SELECT
	id as 'LE ID',
	[name] as 'LE Name'
    
  FROM [data_in].[org_legal_entity]
GO


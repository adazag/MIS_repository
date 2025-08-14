CREATE   PROCEDURE [data_out_cornerstone].[spOverwriteCornerstoneLegalEntity] @CornerstoneLegalEntity [data_out_cornerstone].[cornerstone_legal_entity_type] READONLY
AS
BEGIN
SET IDENTITY_INSERT [data_out_cornerstone].[cornerstone_legal_entity] ON
MERGE [data_out_cornerstone].[cornerstone_legal_entity] AS target
USING @CornerstoneLegalEntity AS source
ON (target.[LE ID] = source.[LE ID])
WHEN MATCHED THEN
    UPDATE SET [LE Name] = source.[LE Name],
	[Active] = 1,
	[Modified Date] = CASE
	WHEN (target.[LE Name] != source.[LE Name] or target.[Active] = 0)
	THEN GETDATE()
	ELSE target.[Modified Date]
	END
WHEN NOT MATCHED THEN
    INSERT ([LE ID], [LE Name], [Active], [Modified Date], [Creation Date])
    VALUES (source.[LE ID], source.[LE Name], 1, GETDATE(), GETDATE())
WHEN NOT MATCHED BY SOURCE THEN  
	UPDATE SET [Active] = 0, 
	[Modified Date] = CASE 
	WHEN (target.[Active] = 1) 
	THEN GETDATE() 
	ELSE target.[Modified Date]
	END;
END
GO

GRANT EXECUTE
    ON OBJECT::[data_out_cornerstone].[spOverwriteCornerstoneLegalEntity] TO [lingaro-mis-adf]
    AS [grzegorz.pawelec@lingarogroup.com];
GO


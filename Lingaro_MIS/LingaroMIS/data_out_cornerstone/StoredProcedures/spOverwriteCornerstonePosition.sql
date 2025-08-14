CREATE   PROCEDURE [data_out_cornerstone].[spOverwriteCornerstonePosition] @CornerstonePosition [data_out_cornerstone].[cornerstone_position_type] READONLY
AS
BEGIN
SET IDENTITY_INSERT [data_out_cornerstone].[cornerstone_position] ON
MERGE [data_out_cornerstone].[cornerstone_position] AS target
USING @CornerstonePosition AS source
ON (target.[Pos ID] = source.[Pos ID])
WHEN MATCHED THEN
    UPDATE SET [Pos Name] = source.[Pos Name],
	[Active] = 1,
	[Modified Date] = CASE
	WHEN (target.[Pos Name] != source.[Pos Name] or target.[Active] = 0)
	THEN GETDATE()
	ELSE target.[Modified Date]
	END
WHEN NOT MATCHED THEN
    INSERT ([Pos ID], [Pos Name], [Active], [Modified Date], [Creation Date])
    VALUES (source.[Pos ID], source.[Pos Name], 1, GETDATE(), GETDATE())
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
    ON OBJECT::[data_out_cornerstone].[spOverwriteCornerstonePosition] TO [lingaro-mis-adf]
    AS [grzegorz.pawelec@lingarogroup.com];
GO


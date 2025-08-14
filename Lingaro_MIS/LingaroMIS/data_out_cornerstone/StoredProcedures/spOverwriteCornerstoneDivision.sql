CREATE   PROCEDURE [data_out_cornerstone].[spOverwriteCornerstoneDivision] @CornerstoneDivision [data_out_cornerstone].[cornerstone_division_type] READONLY
AS
BEGIN
SET IDENTITY_INSERT [data_out_cornerstone].[cornerstone_division] ON
MERGE [data_out_cornerstone].[cornerstone_division] AS target
USING @CornerstoneDivision AS source
ON (target.[OU ID] = source.[OU ID])
WHEN MATCHED THEN
    UPDATE SET [OU Name] = source.[OU Name], 
	[Parent ID] = source.[Parent ID],
	[Active] = 1,
	[Modified Date] = CASE
	WHEN (target.[OU Name] != source.[OU Name] or target.[Parent ID] != source.[Parent ID] or target.[Active] = 0)
	THEN GETDATE()
	ELSE target.[Modified Date]
	END
WHEN NOT MATCHED THEN
    INSERT ([OU ID], [OU Name], [Parent ID], [Active], [Modified Date], [Creation Date])
    VALUES (source.[OU ID], source.[OU Name], source.[Parent ID], 1, GETDATE(), GETDATE())
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
    ON OBJECT::[data_out_cornerstone].[spOverwriteCornerstoneDivision] TO [lingaro-mis-adf]
    AS [grzegorz.pawelec@lingarogroup.com];
GO


CREATE   PROCEDURE [data_out_cornerstone].[spOverwriteCornerstoneLocation] @CornerstoneLocation [data_out_cornerstone].[cornerstone_location_type] READONLY
AS
BEGIN
SET IDENTITY_INSERT [data_out_cornerstone].[cornerstone_location] ON
MERGE [data_out_cornerstone].[cornerstone_location] AS target
USING @CornerstoneLocation AS source
ON (target.[OU ID] = source.[OU ID])
WHEN MATCHED THEN
    UPDATE SET [OU Name] = source.[OU Name],
	[Time Zone] = source.[Time Zone],
	[Active] = 1,
	[Modified Date] = CASE
	WHEN (target.[OU Name] != source.[OU Name] or target.[Time Zone] != source.[Time Zone] or target.[Active] = 0)
	THEN GETDATE()
	ELSE target.[Modified Date]
	END
WHEN NOT MATCHED THEN
    INSERT ([OU ID], [OU Name], [Time Zone], [Active], [Modified Date], [Creation Date])
    VALUES (source.[OU ID], source.[OU Name], source.[Time Zone], 1, GETDATE(), GETDATE())
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
    ON OBJECT::[data_out_cornerstone].[spOverwriteCornerstoneLocation] TO [lingaro-mis-adf]
    AS [grzegorz.pawelec@lingarogroup.com];
GO


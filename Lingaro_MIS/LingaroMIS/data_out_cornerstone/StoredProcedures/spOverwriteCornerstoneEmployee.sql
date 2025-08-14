

CREATE   PROCEDURE [data_out_cornerstone].[spOverwriteCornerstoneEmployee] @CornerstoneEmployee [data_out_cornerstone].[cornerstone_employee_type] READONLY
AS
BEGIN
SET IDENTITY_INSERT [data_out_cornerstone].[cornerstone_employee] ON
MERGE [data_out_cornerstone].[cornerstone_employee] AS target
USING @CornerstoneEmployee AS source
ON (target.[User ID] = source.[User ID])
WHEN MATCHED THEN
    UPDATE SET [First Name] = source.[First Name],
	[Last Name] = source.[Last Name], 
	[Manager] = source.[Manager],
	[Email] = source.[Email],
	[Gender] = source.[Gender],
	[Mobile] = source.[Mobile],
	[User Type] = source.[User Type],
	[Employment Status] = source.[Employment Status],
	[Division] = source.[Division],
	[Position] = source.[Position],
	[Location] = source.[Location],
	[Dotted Line Manager/Indirect Manager] = source.[Dotted Line Manager/Indirect Manager],
	[Legal Entity] = source.[Legal Entity],
	[Is Project Manager] = source.[Is Project Manager],
	[Termination Date] = source.[Termination Date],
	[Is Line Manager] = source.[Is Line Manager],
	[Is Team Owner] = source.[Is Team Owner],
	[Is Service Level Manager] = source.[Is Service Level Manager],
	[Is MC Member] = source.[Is MC Member],
    [First Employment Date] = source.[First Employment Date],
    [BU ID] = source.[BU ID],
    [Sub BU ID] = source.[Sub BU ID],
	[Active] = CASE WHEN (source.[Employment Status] = 'Terminated') THEN 0 ELSE 1 END,
	[Modified Date] = CASE
	WHEN (target.[First Name] != source.[First Name] or target.[Last Name] != source.[Last Name] or target.[Manager] != source.[Manager]
	or target.[Email] != source.[Email] or target.[Gender] != source.[Gender] or target.[Mobile] != source.[Mobile] or target.[User Type] != source.[User Type]
	or target.[Employment Status] != source.[Employment Status] or target.[Division] != source.[Division] or target.[Position] != source.[Position]
	or target.[Location] != source.[Location] or target.[Dotted Line Manager/Indirect Manager] != source.[Dotted Line Manager/Indirect Manager] or target.[Legal Entity] != source.[Legal Entity]
	or target.[Is Project Manager] != source.[Is Project Manager] or target.[Termination Date] != source.[Termination Date] or target.[Is Line Manager] != source.[Is Line Manager]
	or target.[Is Team Owner] != source.[Is Team Owner] or target.[Is Service Level Manager] != source.[Is Service Level Manager] or target.[Is MC Member] != source.[Is MC Member] or target.[First Employment Date] != source.[First Employment Date]
    or target.[BU ID] != source.[BU ID] or target.[Sub BU ID] != source.[Sub BU ID]
	or target.[Active] != CASE WHEN (source.[Employment Status] = 'Terminated') THEN 0 ELSE 1 END)
	THEN GETDATE()
	ELSE target.[Modified Date]
	END
WHEN NOT MATCHED THEN
    INSERT ([User ID], [First Name], [Last Name], [Manager], [Email], [Gender], [Mobile], [User Type], [Employment Status], [Division], [Position], [Location], [Dotted Line Manager/Indirect Manager], [Legal Entity], [Is Project Manager], [Termination Date], [Is Line Manager], [Is Team Owner], [Is Service Level Manager], [Is MC Member], [First Employment Date], [BU ID], [Sub BU ID], [Active], [Modified Date], [Creation Date])
    VALUES (source.[User ID], source.[First Name], source.[Last Name], source.[Manager], source.[Email], source.[Gender], source.[Mobile], source.[User Type], source.[Employment Status], 
	source.[Division], source.[Position], source.[Location], source.[Dotted Line Manager/Indirect Manager], source.[Legal Entity], source.[Is Project Manager], source.[Termination Date],
	source.[Is Line Manager], source.[Is Team Owner], source.[Is Service Level Manager], source.[Is MC Member], source.[First Employment Date], source.[BU ID], source.[Sub BU ID], 1, GETDATE(), GETDATE())
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
    ON OBJECT::[data_out_cornerstone].[spOverwriteCornerstoneEmployee] TO [lingaro-mis-adf]
    AS [grzegorz.pawelec@lingarogroup.com];
GO


CREATE TRIGGER updateApplicationStatus ON dbo.feedback
FOR UPDATE AS
BEGIN
	UPDATE [application] 
	SET [application].[status] = inserted.[result]
	FROM [application] INNER JOIN inserted 
	ON [application].[applicationID] = inserted.[applicationID]
	WHERE inserted.[result] <> ''
END





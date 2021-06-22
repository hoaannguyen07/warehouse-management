USE [warehouse_management]
GO

-- PROCEDURE FOR HASING PASSWORDS IN THE PERSONNEL TABLE
--EXEC dbo.uspVerifyLogin
--	@username nvarchar(50), -- @username of personnel logging into
--	@password nvarchar(50) -- @password of corresponding username

-- OUTPUT(S) (by precedence):
--		1. 'Incorrect Username/Password' -> incorrect username or password; was not differentiated into individual 'Incorrect Username' & 'Incorrect Password' for security reasons
--		2. 'Successful Login' -> matching @username & @password in the database


CREATE OR ALTER PROCEDURE dbo.uspVerifyLogin
	@username nvarchar(50),
	@password nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @personnel_id uniqueidentifier = NULL
	DECLARE @response nvarchar(27) = NULL

	-- see if username exists
	IF EXISTS(SELECT TOP 1 id FROM dbo.personnel WHERE username=@username)
		BEGIN
			-- checking matching username & password
			SET @personnel_id = (SELECT id FROM dbo.personnel WHERE username=@username AND password_hash=HASHBYTES('SHA2_512', @password))

			IF (@personnel_id IS NULL)
				SET @response = 'Incorrect Username/Password'
			ELSE
				SET @response = 'Successful Login'
		END

	-- username doesn't exist in the database so return that message
	ELSE
		SET @response = 'Incorrect Username/Password'

	-- return reponse message
	SELECT @response as response
END
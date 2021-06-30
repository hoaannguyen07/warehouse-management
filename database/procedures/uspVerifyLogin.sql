USE [warehouse_management]
GO

-- PROCEDURE FOR HASING PASSWORDS IN THE PERSONNEL TABLE
--EXEC dbo.uspVerifyLogin
--	@username nvarchar(50), -- @username of personnel logging into
--	@password nvarchar(50) -- @password of corresponding username

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Incorrect Username/Password' -> incorrect username or password; was not differentiated into individual 'Incorrect Username' & 'Incorrect Password' for security reasons
--		0. 'Successful Login' -> matching @username & @password in the database

CREATE OR ALTER PROCEDURE dbo.uspVerifyLogin
	@username nvarchar(50),
	@password nvarchar(50),
	@response nvarchar(27) = NULL OUTPUT
AS
BEGIN

	SET NOCOUNT ON

	-- check if username-password combo exists in the system
	IF NOT EXISTS (SELECT id FROM dbo.personnel WHERE username=@username AND password_hash=HASHBYTES('SHA2_512', @password))
	BEGIN
		SET @response = 'Incorrect Username/Password'
		RETURN (1)
	END
	

	SET @response = 'Successful Login'
	RETURN (0)

END
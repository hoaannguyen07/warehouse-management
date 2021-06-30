USE [warehouse_management]
GO

-- Procedure to delete a personnel from the personnel table
--EXEC dbo.uspCreatePersonnel
--	@username nvarchar(50), -- new username to be put into the personnel table
--	@password nvarchar(50), -- new password corresponding to username to be put into database
--	@full_name nvarchar(100), -- full name of the personnel
--	@auth nvarchar(50), -- username of the person requesting this personnel creation
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Username already exist' -> @username already exists in the database, can't duplicate usernames in this database
--		2. ERROR: 'Unauthorized to create personnel' -> Authorizing username does not have the permission to insert into personnel
--		3. ERROR: ERROR_MESSAGE() -> Something went wrong during the INSERT operation of the @username, @password, and @full_name
--		4. ERROR: 'Error occurred during the INSERT operation' -> something went wrong during the INSERT operation into the personnel table but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		0. 'SUCCESS' -> Successfully removed @username from the database (that personnel no longer exists)


CREATE OR ALTER PROCEDURE dbo.uspCreatePersonnel
	@username nvarchar(50),
	@password nvarchar(50),
	@full_name nvarchar(100),
	@auth nvarchar(50),
	@response nvarchar(256) = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- check if @username is going to be unique in the db
	IF EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=@username)
	BEGIN
		SET @response = 'Username already exists'
		RETURN(1)
	END

	-- check if @auth has the authority to create personnel
	DECLARE @check_permissions_response nvarchar(3)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'create',
		@object = 'personnel',
		@response = @check_permissions_response OUTPUT

	IF (@check_permissions_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to create personnel'
		RETURN (2)
	END

	-- all verifications have been verified so can start inserting new personnel into db
	BEGIN TRY
			INSERT INTO dbo.personnel (username, password_hash, full_name)
			VALUES (@username, HASHBYTES('SHA2_512', @password), @full_name)					
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
		RETURN (3)
	END CATCH

	-- check if new personnel really exists in the db
	IF EXISTS(SELECT id FROM dbo.personnel WHERE username=@username)
	BEGIN
		-- new personnel is guarenteed to be in the db so return successful
		SET @response = 'SUCCESS'
		RETURN (0)
	END
	
	-- unable to find new personnel in db so something went wrong during the INSERT operation
	SET @response = 'Error occurred during the INSERT operation'
	RETURN (4)
END

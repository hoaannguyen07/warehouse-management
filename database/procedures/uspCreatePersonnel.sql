USE [warehouse_management]
GO

-- Procedure to delete a personnel from the personnel table
--EXEC dbo.uspCreatePersonnel
--	@username nvarchar(50), -- new username to be put into the personnel table
--	@password nvarchar(50), -- new password corresponding to username to be put into database
--	@full_name nvarchar(100), -- full name of the personnel
--	@auth nvarchar(50), -- username of the person requesting this personnel creation
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. 'Username already exist' -> @username already exists in the database, can't duplicate usernames in this database
--		2. 'Unauthorized to create personnel' -> Authorizing username does not have the permission to insert into personnel
--		3. ERROR_MESSAGE() -> Something went wrong during the INSERT operation of the @username, @password, and @full_name
--		3. 'SUCCESS' -> Successfully removed @username from the database (that personnel no longer exists)


CREATE OR ALTER PROCEDURE dbo.uspCreatePersonnel
	@username nvarchar(50),
	@password nvarchar(50),
	@full_name nvarchar(100),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @create_personnel_response nvarchar(256) = NULL

	IF NOT EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=@username)
	BEGIN
		-- check if @auth has the authority to create personnel
		DECLARE @check_permissions_response nvarchar(3)
		EXEC dbo.uspCheckPersonnelPermission
			@username = @auth,
			@action = 'create',
			@object = 'personnel',
			@response = @check_permissions_response OUTPUT

		-- if auth is granted, then go ahead with creating new personnel
		IF (@check_permissions_response = 'YES')
		BEGIN
			BEGIN TRY
					INSERT INTO dbo.personnel (username, password_hash, full_name)
					VALUES (@username, HASHBYTES('SHA2_512', @password), @full_name)

					IF EXISTS(SELECT id FROM dbo.personnel WHERE username=@username)
						SET @create_personnel_response = 'SUCCESS'
					
			END TRY
			BEGIN CATCH
				SET @create_personnel_response = ERROR_MESSAGE()
			END CATCH
		END
		ELSE
			SET @create_personnel_response = 'Unauthorized to create personnel'
	END
	ELSE
		SET @create_personnel_response = 'Username already exists'
	

	-- return response message
	SET @response = @create_personnel_response
	--SELECT @create_personnel_response as reponse
END

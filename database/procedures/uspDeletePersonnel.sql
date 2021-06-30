USE [warehouse_management]
GO

-- Procedure to delete a personnel from the personnel table
--EXEC dbo.uspDeletePersonnel
--	@username nvarchar(50), -- username to be taken out of the personnel table
--	@auth nvarchar(50), -- username of the person requesting this personnel creation
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Username does not exist' -> The input username does not exist in the personnel table
--		2. ERROR: 'Unauthorized to delete personnel' -> Authorizing username does not have the permission to insert into personnel
--		3. ERROR: ERROR_MESSAGE() -> Something went wrong during the DELETE operation of the @username
--		4. ERROR: 'Error occurred during the DELETE operation' -> something went wrong during the DELETE operation from the personnel table but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		3. 'SUCCESS' -> Successfully removed @username from the database (that personnel no longer exists)


CREATE OR ALTER PROCEDURE dbo.uspDeletePersonnel
	@username nvarchar(50),
	@auth nvarchar(50),
	@response nvarchar(256) = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- check if @username already exists in the db to be deleted (can't delete something that is nonexistent in the first place)
	IF NOT EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=@username)
	BEGIN
		SET @response = 'Username does not exist'
		RETURN (0)
	END


	-- check if @auth has the authority to delete personnel
	DECLARE @check_permissions_response nvarchar(3)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'delete',
		@object = 'personnel',
		@response = @check_permissions_response OUTPUT
	IF (@check_permissions_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to delete personnel'
		RETURN (2)
	END


	-- all verifications have been made so starting deleting from the db
	BEGIN TRY
		DELETE TOP (1) FROM dbo.personnel WHERE username=@username
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
	END CATCH

	IF EXISTS(SELECT id FROM dbo.personnel WHERE username=@username)
	BEGIN
		SET @response = 'Error occurred during the DELETE operation'
		RETURN (4)
	END

	-- personnel guarenteed to not exist in the db anymore so return successful
	SET @response = 'SUCCESS'
	RETURN (0)
END
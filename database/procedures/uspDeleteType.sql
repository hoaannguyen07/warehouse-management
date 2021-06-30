USE warehouse_management
GO

--EXEC [dbo].[uspDeleteType]
--	@name nvarchar(10), -- name of the type trying to delete
--	@unit nvarchar(10), -- unit of how this type is measured (kg, lbs, etc)
--	@auth nvarchar(50), -- username of person who wants to delete type, used to verify that personnel has the permission to delete a type
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Type does not exist' -> the [@name-@unit] combo does not exist in the database in the first place
--		2. ERROR: 'Unauthorized to delete types' -> @auth does not have the permission to delete types
--		3. ERROR: ERROR_MESSAGE() -> something went wrong during the DELETE operation of the new type into the database (unforseen error that wasn't checked for beforehand)
--		4. ERROR: 'Error occurred during the DELETE operation' -> something went wrong during the DELETE operation from the types table but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		0. 'SUCCESS' -> successfully delete type from db


CREATE OR ALTER PROCEDURE [dbo].[uspDeleteType]
	@name nvarchar(10),
	@unit nvarchar(10),
	@auth nvarchar(50),
	@response nvarchar(256) = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	
	-- check if [@name-@unit] combo is in the db to be deleted
	IF NOT EXISTS (SELECT id FROM dbo.types WHERE name = @name AND unit = @unit)
	BEGIN
		SET @response = 'Type does not exist'
		RETURN (1)
	END


	-- check authorization
	DECLARE @authorization_response nvarchar(3)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'delete',
		@object = 'types',
		@response = @authorization_response OUTPUT
	-- make sure @auth has the authorization to delete types to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to delete types'
		RETURN (2)
	END


	-- all verifications have been made so starting deleting from the db
	BEGIN TRY
		DELETE FROM dbo.types WHERE name = @name AND unit = @unit

		
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
		RETURN (3)
	END CATCH


	-- check if type was actually deleted from the db or not
	IF NOT EXISTS (SELECT id FROM dbo.types WHERE name=@unit AND unit=@unit)
	BEGIN
		-- type guarenteed to not exist in the db anymore so return successful
		SET @response = 'SUCCESS'
		RETURN (0)
		
	END
	
	-- able to still find type in db so something went wrong during the DELETE operation
	SET @response = 'Error occurred during the DELETE operation'
	RETURN (4)
END
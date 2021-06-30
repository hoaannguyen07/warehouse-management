USE warehouse_management
GO

--EXEC [dbo].[uspCreateType]
--	@name nvarchar(10), -- name of the new type
--	@unit nvarchar(10), -- unit of how this type is measured (kg, lbs, etc)
--	@auth nvarchar(50), -- username of person who wants to create type, used to verify that personnel has the permission to create a new type
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Type already exists' -> the [@name-@unit] combo already exists in the database
--		2. ERROR: 'Unauthorized to create types' -> @auth does not have the permission to create new types
--		3. ERROR: ERROR_MESSAGE() -> something went wrong during the INSERT operation of the new type into the database (unforseen error that wasn't checked for beforehand)
--		4. ERROR: 'Error occurred during the INSERT operation' -> something went wrong during the INSERT operation into the types table but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		0. 'SUCCESS' -> successfully inserted new type into db


CREATE OR ALTER PROCEDURE [dbo].[uspCreateType]
	@name nvarchar(10),
	@unit nvarchar(10),
	@auth nvarchar(50),
	@response nvarchar(256) = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	
	-- check if [@name-@unit] combo is in the db already
	IF EXISTS (SELECT id FROM dbo.types WHERE name = @name AND unit = @unit)
	BEGIN
		SET @response = 'Type already exists'
		RETURN (1)
	END


	-- check authorization
	DECLARE @authorization_response nvarchar(3)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'create',
		@object = 'types',
		@response = @authorization_response OUTPUT
	-- make sure @auth has the authorization to create types to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to create types'
		RETURN (2)
	END


	-- all verifications have been make so starting inserting into the db
	BEGIN TRY
		INSERT INTO dbo.types(name, unit) VALUES(@name, @unit)
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
		RETURN (3)
	END CATCH


	-- check if new type now exists in db or not
	IF NOT EXISTS (SELECT id FROM dbo.types WHERE name = @name AND unit = @unit)
	BEGIN
		SET @response = 'Error occurred during the INSERT operation'
		RETURN (4)
	END
	
	-- new type is guarenteed to be in the db so return successful
	SET @response = 'SUCCESS'
	RETURN (0)
END
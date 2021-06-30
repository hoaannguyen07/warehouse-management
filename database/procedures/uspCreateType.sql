USE warehouse_management
GO

--EXEC [dbo].[uspCreateType]
--	@name nvarchar(10), -- name of the new type
--	@unit nvarchar(10), -- unit of how this type is measured (kg, lbs, etc)
--	@auth nvarchar(50), -- username of person who wants to create type, used to verify that personnel has the permission to create a new type
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Type already exists' -> the [@name-@unit] combo already exists in the database
--		2. ERROR: 'Unauthorized to create types' -> @auth does not have the permission to create new types
--		3. ERROR: ERROR_MESSAGE() -> something went wrong during the INSERT operation of the new type into the database (unforseen error that wasn't checked for beforehand)
--		4. 'SUCCESS' -> successfully inserted new type into db

CREATE OR ALTER PROCEDURE [dbo].[uspCreateType]
	@name nvarchar(10),
	@unit nvarchar(10),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @create_type_response nvarchar(256) = NULL

	-- check if [@name-@unit] combo is in the db already
	IF NOT EXISTS (SELECT id FROM dbo.types WHERE name = @name AND unit = @unit)
	BEGIN
		-- check authorization
		DECLARE @authorization_response nvarchar(3)

		EXEC dbo.uspCheckPersonnelPermission
			@username = @auth,
			@action = 'create',
			@object = 'types',
			@response = @authorization_response OUTPUT

		-- make sure @auth has the authorization to create types
		IF (@authorization_response = 'YES')
		BEGIN
			BEGIN TRY
				INSERT INTO dbo.types(name, unit) VALUES(@name, @unit)

				-- check if new type now exists in db or not
				IF EXISTS (SELECT id FROM dbo.types WHERE name=@unit AND unit=@unit)
					SET @create_type_response = 'SUCCESS'
			END TRY
			BEGIN CATCH
				SET @create_type_response = ERROR_MESSAGE()
			END CATCH -- finish attempting to insert [@name-@unit] into db
		END
		ELSE
		BEGIN
			SET @create_type_response = 'Unauthorized to create types'
		END -- finish checking authorization
	END
	ELSE
	BEGIN
		SET @create_type_response = 'Type already exists'
	END -- finished checking if [@name-@unit] combo


	SET @response = @create_type_response
	--SELECT @response AS response
END
USE warehouse_management
GO

--EXEC [dbo].[uspDeleteType]
--	@name nvarchar(10), -- name of the type trying to delete
--	@unit nvarchar(10), -- unit of how this type is measured (kg, lbs, etc)
--	@auth nvarchar(50), -- username of person who wants to delete type, used to verify that personnel has the permission to delete a type
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Type does not exist' -> the [@name-@unit] combo does not exist in the database in the first place
--		2. ERROR: 'Unauthorized to delete types' -> @auth does not have the permission to delete types
--		3. ERROR: ERROR_MESSAGE() -> something went wrong during the DELETE operation of the new type into the database (unforseen error that wasn't checked for beforehand)
--		4. 'SUCCESS' -> successfully delete type from db

CREATE OR ALTER PROCEDURE [dbo].[uspDeleteType]
	@name nvarchar(10),
	@unit nvarchar(10),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @delete_type_response nvarchar(256) = NULL

	-- check if [@name-@unit] combo is in the db already
	IF EXISTS (SELECT id FROM dbo.types WHERE name = @name AND unit = @unit)
	BEGIN
		-- check authorization
		DECLARE @authorization_response nvarchar(3)

		EXEC dbo.uspCheckPersonnelPermission
			@username = @auth,
			@action = 'delete',
			@object = 'types',
			@response = @authorization_response OUTPUT

		-- make sure @auth has the authorization to delete types
		IF (@authorization_response = 'YES')
		BEGIN
			BEGIN TRY
				DELETE FROM dbo.types WHERE name = @name AND unit = @unit

				-- check if type was actually deleted from the db or not
				IF NOT EXISTS (SELECT id FROM dbo.types WHERE name=@unit AND unit=@unit)
					SET @delete_type_response = 'SUCCESS'
				ELSE
				BEGIN
					DECLARE @message nvarchar(256) = NULL
					SET @message = CONCAT('The DELETE operation was unable to remove the type [name, unit] = [', @name, ', ', @unit, '] from the database')

					RAISERROR(
						@message, -- Message
						16, -- Severity
						1 -- State
					)
				END
			END TRY
			BEGIN CATCH
				SET @delete_type_response = ERROR_MESSAGE()
			END CATCH -- finish attempting to insert [@name-@unit] into db
		END
		ELSE
		BEGIN
			SET @delete_type_response = 'Unauthorized to delete types'
		END -- finish checking authorization
	END
	ELSE
	BEGIN
		SET @delete_type_response = 'Type does not exist'
	END -- finished checking if [@name-@unit] combo


	SET @response = @delete_type_response
	--SELECT @response AS response
END
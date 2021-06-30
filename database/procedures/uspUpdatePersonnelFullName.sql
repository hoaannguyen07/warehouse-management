USE warehouse_management
GO

-- updating a personnel's password (only person with permission to update personnel)
--EXEC [dbo].[uspUpdatePersonnelFullName]
--	@username nvarchar(50), -- username that identifies the personnel trying to have his/her password changed
--	@updated_full_name nvarchar(100), -- new full_name for personnel
--	@auth nvarchar(50), --username of the person requesting this personnel update
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Username does not exist' -> username does not exist in the database in the first place, so he is not a personnel
--		2. ERROR: 'Unauthorized to update full names' -> @auth does not have the authorization to update full names in the database
--		3. ERROR: ERROR_MESSAGE() -> error occurred during the updating of the password (unforseen & unhandled error)
--		3. 'SUCCESS' -> successfully updated the password of @personnel_username in the db

CREATE OR ALTER PROCEDURE [dbo].[uspUpdatePersonnelFullName]
	@username nvarchar(50),
	@updated_full_name nvarchar(100),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @update_full_name_response nvarchar(256) = ''

	-- check existence of username in db to see if a change in password is feasible
	IF EXISTS (SELECT id FROM dbo.personnel WHERE username = @username)
	BEGIN
		-- check authorization (only people who can update personnel table can update personnel's full names)
		DECLARE @authorization_response nvarchar(3)

		EXEC dbo.uspCheckPersonnelPermission
			@username = @auth,
			@action = 'update',
			@object = 'personnel',
			@response = @authorization_response OUTPUT
		-- make sure @auth has the authorization to create locations
		IF (@authorization_response = 'YES')
		BEGIN
			BEGIN TRY
				-- because usernames are unique in the db, can make sure that only this personnel's full name will be changed
				UPDATE dbo.personnel
				SET full_name = @updated_full_name
				WHERE username = @username

				-- check to see if password has really been updated
				IF EXISTS (SELECT id FROM dbo.personnel WHERE username = @username AND full_name = @updated_full_name)
					SET @update_full_name_response = 'SUCCESS'
				ELSE
				BEGIN
					DECLARE @message nvarchar(256) = NULL
					SET @message = CONCAT('The UPDATE operation was unable update ', @username, '''s fullname to be ', @updated_full_name)

					RAISERROR(
						@message, -- Message
						16, -- Severity
						1 -- State
					)
				END
			END TRY
			BEGIN CATCH
				SET @update_full_name_response = ERROR_MESSAGE()
			END CATCH
		END
		ELSE
		BEGIN
			SET @update_full_name_response = 'Unauthorized to update full names'
		END
	END
	ELSE
	BEGIN
		SET @update_full_name_response = 'Username does not exist'
	END

	SET @response = @update_full_name_response
	--SELECT @reponse AS response
END

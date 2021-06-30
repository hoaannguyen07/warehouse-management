USE warehouse_management
GO

-- updating a personnel's password (only person with permission to update personnel or the person itself could update their passwords)
--EXEC [dbo].[uspUpdatePersonnelPassword]
--	@username nvarchar(50), -- username that identifies the personnel trying to have his/her password changed
--	@updated_password nvarchar(50), -- new password set for personnel
--	@auth nvarchar(50), --username of the person requesting this personnel update
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Username does not exist' -> username does not exist in the database in the first place, so he is not a personnel
--		2. ERROR: 'Unauthorized to update passwords' -> @auth does not have the authorization to update passwords in the database
--		3. ERROR: ERROR_MESSAGE() -> error occurred during the updating of the password (unforseen & unhandled error)
--		3. 'SUCCESS' -> successfully updated the password of @personnel_username in the db

CREATE OR ALTER PROCEDURE [dbo].[uspUpdatePersonnelPassword]
	@username nvarchar(50),
	@updated_password nvarchar(50),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @update_password_response nvarchar(256) = ''

	-- check existence of username in db to see if a change in password is feasible
	IF EXISTS (SELECT id FROM dbo.personnel WHERE username = @username)
	BEGIN
		-- check authorization (only people who can update personnel table or the personnel themselves can change @personnel_username's password)
		DECLARE @authorization_response nvarchar(3)

		EXEC dbo.uspCheckPersonnelPermission
			@username = @auth,
			@action = 'update',
			@object = 'personnel',
			@response = @authorization_response OUTPUT

		-- make sure @auth has the authorization to create locations
		IF (@authorization_response = 'YES') OR (@auth = @username)
		BEGIN
			BEGIN TRY
				-- because usernames are unique in the db, can make sure that only this personnel's password will be changed
				UPDATE dbo.personnel
				SET password_hash = HASHBYTES('SHA2_512', @updated_password)
				WHERE username = @username

				-- check to see if password has really been updated
				IF EXISTS (SELECT id FROM dbo.personnel WHERE username = @username AND password_hash = HASHBYTES('SHA2_512', @updated_password))
					SET @update_password_response = 'SUCCESS'
				ELSE
				BEGIN
					DECLARE @message nvarchar(256) = NULL
					SET @message = CONCAT('The UPDATE operation was unable update ', @username, '''s password to be ', @updated_password)

					RAISERROR(
						@message, -- Message
						16, -- Severity
						1 -- State
					)
				END
			END TRY
			BEGIN CATCH
				SET @update_password_response = ERROR_MESSAGE()
			END CATCH
		END
		ELSE
		BEGIN
			SET @update_password_response = 'Unauthorized to update passwords'
		END
	END
	ELSE
	BEGIN
		SET @update_password_response = 'Username does not exist'
	END

	SET @response = @update_password_response
	--SELECT @reponse AS response
END

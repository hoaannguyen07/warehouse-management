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
--		4. ERROR: 'Error occurred during the UPDATE operation' -> something went wrong during the UDPATE operation of the password but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		3. 'SUCCESS' -> successfully updated the password of @personnel_username in the db


CREATE OR ALTER PROCEDURE [dbo].[uspUpdatePersonnelPassword]
	@username nvarchar(50),
	@updated_password nvarchar(50),
	@auth nvarchar(50),
	@response nvarchar(256) = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- check existence of username in db to see if a change in password is feasible
	IF NOT EXISTS (SELECT id FROM dbo.personnel WHERE username = @username)
	BEGIN
		SET @response = 'Username does not exist'
		RETURN (1)
	END


	-- check authorization (only people who can update personnel table or the personnel themselves can change @personnel_username's password)
	DECLARE @authorization_response nvarchar(3)

	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'update',
		@object = 'personnel',
		@response = @authorization_response OUTPUT
	-- make sure @auth has the authorization to update personnel
	IF (@authorization_response = 'NO') AND (@auth <> @username)
	BEGIN
		SET @response = 'Unauthorized to update passwords'
		RETURN (2)
	END


	-- all verifications have been made so starting inserting into the db
	BEGIN TRY
		-- because usernames are unique in the db, can make sure that only this personnel's password will be changed
		UPDATE dbo.personnel
		SET password_hash = HASHBYTES('SHA2_512', @updated_password)
		WHERE username = @username
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
		RETURN (3)
	END CATCH


	-- check to see if password has really been updated
	IF EXISTS (SELECT id FROM dbo.personnel WHERE username = @username AND password_hash = HASHBYTES('SHA2_512', @updated_password))
	BEGIN
		-- password was updated so return successful
		SET @response = 'SUCCESS'
		RETURN (0)
	END

	-- unable to find the updated entry of the username-password combo so the UPDATE operation was unsuccessful
	SET @response = 'Error occurred during the UPDATE operation'
	RETURN (4)
	
END
GO
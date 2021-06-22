USE [warehouse_management]
GO

-- Procedure to delete a personnel from the personnel table
--EXEC dbo.uspDeletePersonnel
--	@username nvarchar(50), -- username to be taken out of the personnel table
--	@auth nvarchar(50), -- username of the person requesting this personnel creation
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. 'Username does not exist' -> The input username does not exist in the personnel table
--		2. 'Unauthorized to delete personnel' -> Authorizing username does not have the permission to insert into personnel
--		3. ERROR_MESSAGE() -> Something went wrong during the DELETE operation of the @username
--		3. 'SUCCESS' -> Successfully removed @username from the database (that personnel no longer exists)


CREATE OR ALTER PROCEDURE dbo.uspDeletePersonnel
	@username nvarchar(50),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @delete_personnel_response nvarchar(256) = NULL

	IF EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=@username)
	BEGIN
		-- check if @auth has the authority to create personnel
		DECLARE @check_permissions_response nvarchar(3)
		EXEC dbo.uspCheckPersonnelPermission
			@username = @auth,
			@action = 'delete',
			@object = 'personnel',
			@response = @check_permissions_response OUTPUT

		-- if auth is granted, then go ahead with creating new personnel
		IF (@check_permissions_response = 'YES')
		BEGIN
			BEGIN TRY
					DELETE FROM dbo.personnel WHERE username=@username

					IF NOT EXISTS(SELECT id FROM dbo.personnel WHERE username=@username)
						SET @delete_personnel_response = 'SUCCESS'
					ELSE
					BEGIN						
						DECLARE @message nvarchar(256) = NULL
						SET @message = CONCAT('The DELETE operation was unable to remove the username [',@username,'] from the database')

						RAISERROR(
							@message, -- Message
							16, -- Severity
							1 -- State
						)
					END
				
			END TRY
			BEGIN CATCH
				SET @delete_personnel_response = ERROR_MESSAGE()
			END CATCH
		END
		ELSE
			SET @delete_personnel_response = 'Unauthorized to delete personnel'
	END
	ELSE
		SET @delete_personnel_response = 'Username does not exist'
	

	-- return response message
	SET @response = @delete_personnel_response
	--SELECT @@delete_personnel_response as reponse
END

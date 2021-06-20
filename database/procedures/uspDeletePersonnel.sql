USE [warehouse_management]
GO

-- Procedure to delete a personnel from the personnel table


-- OUTPUT(S):
--		'Unauthorized to delete personnel' -> Authorizing username does not have the permission to insert into personnel
--		'Username does not exist' -> The input username does not exist in the personnel table
--		'SUCCESS' -> Entries of the personnel table with [username]=@username no longer exists in the personnel. 
--						DOES NOT signify that a DELETE operation was  called


CREATE OR ALTER PROCEDURE dbo.uspDeletePersonnel
	@username nvarchar(50), -- username to be taken out of the personnel table
	@auth nvarchar(50), -- username of the person requesting this personnel creation
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

					DELETE FROM dbo.personnel 
					WHERE username=@username

					SET @delete_personnel_response = 'SUCCESS'

				
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

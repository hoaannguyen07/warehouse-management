USE [warehouse_management]
GO

/****** Object:  StoredProcedure [dbo].[uspCheckPermissions]    Script Date: 6/14/2021 11:17:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Delete a personnel permission in the database
--EXEC [dbo].[uspDeletePersonnelPermission]
--	@username NVARCHAR(50), -- username of the personnel this permission will be revoked from
--	@action NVARCHAR(10), -- type of action the permission will be for (create/read/update/delete)
--	@object NVARCHAR(30), -- object the action can be used upon
--	@auth nvarchar(50), -- username of the person requesting to delete personnel permission
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. 'Username does not exist' -> @username is not a valid username in the database
--		2. 'Permission does not exist' -> [@action-@object] permission does not exist in the database
--		3. 'Personnel does not have this permission' -> @username does not have the [@action-@object] permission to begin with
--		4. 'Unauthorized to delete permission' -> @auth does not have the permission to perform this action 
--		5. ERROR_MESSAGE() -> error occurred during the DELETE operation of the personnel permission
--		5. 'SUCCESS' -> Successfully removed the [@action-@object] from @username on the personnel_permissions table


CREATE OR ALTER PROCEDURE [dbo].[uspDeletePersonnelPermission]
	@username NVARCHAR(50),
	@action NVARCHAR(10),
	@object NVARCHAR(30),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @delete_personnel_permission_response nvarchar(256) = NULL

	IF EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=@username)
	BEGIN
		IF EXISTS(SELECT dbo.permissions.id FROM dbo.permissions WHERE action=@action AND object=@object)
		BEGIN
				-- only delete permission from @username if @username has the [@action-@object] permission in the first place
				IF EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permissions.action, dbo.permissions.object
							FROM dbo.personnel_permissions
							INNER JOIN dbo.personnel
							ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
							INNER JOIN dbo.permissions
							ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
							WHERE dbo.personnel.username = @username 
							AND dbo.permissions.action = @action 
							AND dbo.permissions.object = @object)
				BEGIN
						-- check if @auth has the authority to create personnel
						DECLARE @check_permissions_response nvarchar(3)
						EXEC dbo.uspCheckPersonnelPermission
							@username = @auth,
							@action = 'delete',
							@object = 'personnel_permissions',
							@response = @check_permissions_response OUTPUT

						-- if auth is granted, then go ahead with creating new personnel
						IF (@check_permissions_response = 'YES')
						BEGIN
							BEGIN TRY
								DELETE FROM dbo.personnel_permissions 
								WHERE
								personnel_id=(SELECT TOP 1 id FROM dbo.personnel WHERE username=@username) AND
								permissions_id=(SELECT TOP 1 id FROM dbo.permissions WHERE action=@action AND object=@object)

								-- have to make sure permission is deleted from the database (in case no severe errors raised to push into CATCH block but database did not record properly)
								IF (NOT EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permissions.action, dbo.permissions.object
									FROM dbo.personnel_permissions
									INNER JOIN dbo.personnel
									ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
									INNER JOIN dbo.permissions
									ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
									WHERE dbo.personnel.username = @username
									AND dbo.permissions.action = @action 
									AND dbo.permissions.object = @object))
								BEGIN
									SET @delete_personnel_permission_response = 'SUCCESS'
								END
								ELSE
								BEGIN						
									DECLARE @message nvarchar(256) = NULL
									SET @message = CONCAT('The DELETE operation was unable to remove the [', @action, '-', @object, '] permission from the username [', @username , ']')

									RAISERROR(
										@message, -- Message
										16, -- Severity
										1 -- State
									)
								END
							END TRY
							BEGIN CATCH
								SET @delete_personnel_permission_response = ERROR_MESSAGE()
							END CATCH
						END
						ELSE
							SET @delete_personnel_permission_response = 'Unauthorized to delete permission'
				END
				ELSE
					SET @delete_personnel_permission_response = 'Personnel does not have this permission'
		END
		ELSE
			SET @delete_personnel_permission_response = 'Permission does not exist'
	END
	ELSE
		SET @delete_personnel_permission_response = 'Username does not exist'
	

	-- return response message
	SET @response = @delete_personnel_permission_response
	--SELECT @delete_personnel_permission_response as response
END
GO



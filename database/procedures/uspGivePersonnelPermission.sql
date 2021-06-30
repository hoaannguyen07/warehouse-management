USE [warehouse_management]
GO

-- Delete a personnel permission in the database
--EXEC [dbo].[uspGivePersonnelPermission]
--	@username NVARCHAR(50), -- username of the personnel this permission will be revoked from
--	@action NVARCHAR(10), -- type of action the permission will be for (create/read/update/delete)
--	@object NVARCHAR(30), -- object the action can be used upon
--	@auth nvarchar(50), -- username of the person requesting to delete personnel permission
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Username does not exist' -> @username is not a valid username in the database
--		2. ERROR: 'Permission does not exist' -> [@action-@object] permission does not exist in the database
--		3. ERROR: 'Personnel already has this permission' -> @username has the [@action-@object] permission already so nothing is added to the system
--		4. ERROR: 'Unauthorized to delete permission' -> @auth does not have the permission to perform this action 
--		5. ERROR: ERROR_MESSAGE() -> error occurred during the INSERT operation of the personnel permission
--		5. 'SUCCESS' -> Successfully gave @username the [@action-@object] permission


CREATE OR ALTER PROCEDURE [dbo].[uspGivePersonnelPermission]
	@username NVARCHAR(50),
	@action NVARCHAR(10),
	@object NVARCHAR(30),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @give_personnel_permission_response nvarchar(256) = NULL

	IF EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=@username)
	BEGIN
		IF EXISTS (SELECT permissions.id FROM permissions
					INNER JOIN dbo.permission_actions ON dbo.permissions.action_id = dbo.permission_actions.id
					INNER JOIN dbo.permission_objects ON dbo.permissions.object_id = dbo.permission_objects.id
					WHERE dbo.permission_actions.action = @action 
					AND dbo.permission_objects.object = @object)
		BEGIN
				-- only give permission to @username if @username does not have the [@action-@object] permission in the first place
				DECLARE @personnel_has_permission_response nvarchar(3)

				EXEC dbo.uspCheckPersonnelPermission
					@username = @username,
					@action = @action,
					@object = @object,
					@response = @personnel_has_permission_response OUTPUT


				IF (@personnel_has_permission_response = 'NO')
				BEGIN
						-- check if @auth has the authority to create personnel
						DECLARE @check_permissions_response nvarchar(3)
						EXEC dbo.uspCheckPersonnelPermission
							@username = @auth,
							@action = 'create',
							@object = 'personnel_permissions',
							@response = @check_permissions_response OUTPUT

						-- if auth is granted, then go ahead with creating new personnel
						IF (@check_permissions_response = 'YES')
						BEGIN
							BEGIN TRY
								INSERT INTO dbo.personnel_permissions (personnel_id, permissions_id)
								VALUES (
								(SELECT TOP 1 id FROM dbo.personnel WHERE username=@username),
								(SELECT TOP 1 id FROM dbo.permissions 
									WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = @action) 
									AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = @object))
								)

								-- have to make sure new entry is in the database (in case no severe errors raised to push into CATCH block but database did not record properly)
								EXEC dbo.uspCheckPersonnelPermission
									@username = @username,
									@action = @action,
									@object = @object,
									@response = @personnel_has_permission_response OUTPUT

								IF (@personnel_has_permission_response = 'YES')
								BEGIN
									SET @give_personnel_permission_response = 'SUCCESS'
								END

							END TRY
							BEGIN CATCH
								SET @give_personnel_permission_response = ERROR_MESSAGE()
							END CATCH
						END
						ELSE
							SET @give_personnel_permission_response = 'Unauthorized to give permission'
				END
				ELSE
					SET @give_personnel_permission_response = 'Personnel already has this permission'
		END
		ELSE
			SET @give_personnel_permission_response = 'Permission does not exist'
	END
	ELSE
		SET @give_personnel_permission_response = 'Username does not exist'
	

	-- return response message
	SET @response = @give_personnel_permission_response
	--SELECT @response as response
END
GO



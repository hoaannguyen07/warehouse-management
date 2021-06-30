USE [warehouse_management]
GO

-- Delete a personnel permission in the database
--EXEC [dbo].[uspDeletePersonnelPermission]
--	@username NVARCHAR(50), -- username of the personnel this permission will be revoked from
--	@action NVARCHAR(10), -- type of action the permission will be for (create/read/update/delete)
--	@object NVARCHAR(30), -- object the action can be used upon
--	@auth nvarchar(50), -- username of the person requesting to delete personnel permission
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Username does not exist' -> @username is not a valid username in the database
--		2. ERROR: 'Permission does not exist' -> [@action-@object] permission does not exist in the database
--		3. ERROR: 'Personnel does not have this permission' -> @username does not have the [@action-@object] permission to begin with
--		4. ERROR: 'Unauthorized to delete permission' -> @auth does not have the permission to perform this action 
--		5. ERROR: ERROR_MESSAGE() -> error occurred during the DELETE operation of the personnel permission
--		6. ERROR: 'Error occurred during the DELETE operation' -> something went wrong during the DELETE operation from the personnel_permissions table but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		0. 'SUCCESS' -> Successfully removed the [@action-@object] from @username on the personnel_permissions table


CREATE OR ALTER PROCEDURE [dbo].[uspDeletePersonnelPermission]
	@username NVARCHAR(50),
	@action NVARCHAR(10),
	@object NVARCHAR(30),
	@auth nvarchar(50),
	@response nvarchar(256) = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON	

	-- check for existence of personnel b/c every permission given is given to a personnel in the personnel table
	IF NOT EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=@username)
	BEGIN
		SET @response = 'Username does not exist'
		RETURN (1)
	END


	-- check for existence of permission in the db to make sure it is a valid permission
	IF NOT EXISTS(SELECT permissions.id FROM permissions
				INNER JOIN dbo.permission_actions ON dbo.permissions.action_id = dbo.permission_actions.id
				INNER JOIN dbo.permission_objects ON dbo.permissions.object_id = dbo.permission_objects.id
				WHERE dbo.permission_actions.action = @action 
				AND dbo.permission_objects.object = @object)
	BEGIN
		SET @response = 'Permission does not exist'
		RETURN (2)
	END


	-- only delete permission from @username if @username has the [@action-@object] permission in the first place
	DECLARE @personnel_has_permission_response nvarchar(3)

	EXEC dbo.uspCheckPersonnelPermission
		@username = @username,
		@action = @action,
		@object = @object,
		@response = @personnel_has_permission_response OUTPUT
	IF (@personnel_has_permission_response = 'NO')
	BEGIN
		SET @response = 'Personnel does not have this permission'
		RETURN (3)
	END


	-- check if @auth has the authority to delete personnel
	DECLARE @check_permissions_response nvarchar(3)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'delete',
		@object = 'personnel_permissions',
		@response = @check_permissions_response OUTPUT
	IF (@check_permissions_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to delete permission'
		RETURN (4)
	END


	-- all verifications have been made so starting deleting from the db
	BEGIN TRY
		DELETE FROM dbo.personnel_permissions 
		WHERE personnel_id = (SELECT TOP 1 id FROM dbo.personnel WHERE username=@username) 
		AND permissions_id = (SELECT TOP 1 id FROM dbo.permissions 
								WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = @action) 
								AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = @object)
							 )
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
		RETURN (5)
	END CATCH


	-- have to make sure permission is deleted from the database (in case no severe errors raised to push into CATCH block but database did not record properly)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @username,
		@action = @action,
		@object = @object,
		@response = @personnel_has_permission_response OUTPUT

	IF (@personnel_has_permission_response = 'NO')
	BEGIN
		-- personnel guarenteed to not have permission[@action-@object] in the db anymore so return successful
		SET @response = 'SUCCESS'
		RETURN (0)
	END
	

	-- able to still determine that the personnel still has permission [@action-@object] so something went wrong during the DELETE operation
	SET @response = 'Error occurred during the DELETE operation'
	RETURN (6)
END
GO



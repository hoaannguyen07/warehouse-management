USE [warehouse_management]
GO

-- Delete a personnel permission in the database
--EXEC [dbo].[uspGivePersonnelPermission]
--	@username NVARCHAR(50), -- username of the personnel this permission will be revoked from
--	@action NVARCHAR(10), -- type of action the permission will be for (create/read/update/delete)
--	@object NVARCHAR(30), -- object the action can be used upon
--	@auth nvarchar(50), -- username of the person requesting to delete personnel permission
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Username does not exist' -> @username is not a valid username in the database
--		2. ERROR: 'Permission does not exist' -> [@action-@object] permission does not exist in the database
--		3. ERROR: 'Personnel already has this permission' -> @username has the [@action-@object] permission already so nothing is added to the system
--		4. ERROR: 'Unauthorized to give permission' -> @auth does not have the permission to perform this action 
--		5. ERROR: ERROR_MESSAGE() -> error occurred during the INSERT operation of the personnel permission
--		6. ERROR: 'Error occurred during the INSERT operation' -> something went wrong during the INSERT operation into the personnel_permissions table but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		0. 'SUCCESS' -> Successfully gave @username the [@action-@object] permission


CREATE OR ALTER PROCEDURE [dbo].[uspGivePersonnelPermission]
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
	IF NOT EXISTS (SELECT permissions.id FROM permissions
				INNER JOIN dbo.permission_actions ON dbo.permissions.action_id = dbo.permission_actions.id
				INNER JOIN dbo.permission_objects ON dbo.permissions.object_id = dbo.permission_objects.id
				WHERE dbo.permission_actions.action = @action 
				AND dbo.permission_objects.object = @object)
	BEGIN
		SET @response = 'Permission does not exist'
		RETURN (2)
	END


	-- only give permission to @username if @username does not have the [@action-@object] permission in the first place
	DECLARE @personnel_has_permission_response nvarchar(3)

	EXEC dbo.uspCheckPersonnelPermission
		@username = @username,
		@action = @action,
		@object = @object,
		@response = @personnel_has_permission_response OUTPUT
	IF (@personnel_has_permission_response = 'YES')
	BEGIN
		SET @response = 'Personnel already has this permission'
		RETURN (3)
	END


	-- check if @auth has the authority to create personnel
	DECLARE @check_permissions_response nvarchar(3)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'create',
		@object = 'personnel_permissions',
		@response = @check_permissions_response OUTPUT

	-- make sure @auth has the authorization to give personnel permissions to continue
	IF (@check_permissions_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to give permission'
		RETURN (4)
	END


	-- all verifications have been make so starting inserting into the db
	BEGIN TRY
		INSERT INTO dbo.personnel_permissions (personnel_id, permissions_id)
		VALUES (
		(SELECT TOP 1 id FROM dbo.personnel WHERE username=@username),
		(SELECT TOP 1 id FROM dbo.permissions 
			WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = @action) 
			AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = @object))
		)
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
		RETURN (5)
	END CATCH


	-- check if the db has recorded that the personnel has the new permisson [@action-@object]
	EXEC dbo.uspCheckPersonnelPermission
		@username = @username,
		@action = @action,
		@object = @object,
		@response = @personnel_has_permission_response OUTPUT

	IF (@personnel_has_permission_response = 'YES')
	BEGIN
		-- personnel has been given a new permisson so return successful
		SET @response = 'SUCCESS'
		RETURN (0)
		
	END


	-- personnel still does not have the permission [@action-@object] so something went wrong during the INSERT operation
	SET @response = 'Error occurred during the INSERT operation'
	RETURN (6)
END
GO


USE warehouse_management
GO


--EXEC [dbo].[uspGetPersonnelPermissionsList]
--	@username nvarchar(50), -- username of user getting list of permissions for
--	@auth nvarchar(50), -- username of person who wants to get this list of user permissions (used to verify that the person actually has permission to read palettes)
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Username does not exist' -> @username is not a valid username in the database
--		2. ERROR: 'Unauthorized to retrieve permissions list' -> @auth does not have the permission to read the personnel permissions table
--		0. 'SUCCESS' -> successfully retrieved information on the palette from the db

-- get list of permissions @username has access to
CREATE OR ALTER PROCEDURE [dbo].[uspGetPersonnelPermissionsList]
	@username nvarchar(50),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- check for existence of personnel b/c every permission given is given to a personnel in the personnel table
	IF NOT EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=@username)
	BEGIN
		SET @response = 'Username does not exist'
		RETURN (1)
	END

	-- check authorization
	DECLARE @authorization_response nvarchar(3)

	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'read',
		@object = 'personnel',
		@response = @authorization_response OUTPUT

	-- make sure @auth has the authorization to create palettes to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to retrieve permissions list'
		RETURN (1)
	END
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'read',
		@object = 'personnel_permissions',
		@response = @authorization_response OUTPUT

	-- make sure @auth has the authorization to create palettes to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to retrieve permissions list'
		RETURN (1)
	END

	SELECT personnel.username, personnel.full_name, permission_actions.action, permission_objects.object
	FROM dbo.personnel_permissions
	INNER JOIN dbo.personnel
	ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
	INNER JOIN dbo.permissions
	ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
	INNER JOIN dbo.permission_actions
	ON dbo.permissions.action_id = dbo.permission_actions.id
	INNER JOIN dbo.permission_objects
	ON dbo.permissions.object_id = dbo.permission_objects.id
	WHERE personnel.username = @username
	ORDER BY permission_objects.object, permission_actions.action ASC
	
	SET @response = 'SUCCESS'
	RETURN (0)

END
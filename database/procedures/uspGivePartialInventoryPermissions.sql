USE warehouse_management
GO


--EXEC [dbo].[uspGivePartialInventoryPermissions]
--	@username nvarchar(50), -- username this set of permission will be given to
--	@auth nvarchar(50), -- username of person who wants to give this set of permissions (used to verify that the person actually has permission to read palettes)
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Username does not exist' -> @username is not a valid username in the database
--		2. ERROR: 'Unauthorized to give permissions' -> @auth does not have the permission to give permissions
--		0. 'SUCCESS' -> successfully retrieved information on the palette from the db

-- give read permissions in palettes & locations tables
CREATE OR ALTER PROCEDURE [dbo].[uspGivePartialInventoryPermissions]
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
		@action = 'create',
		@object = 'personnel_permissions',
		@response = @authorization_response OUTPUT

	-- make sure @auth has the authorization to create palettes to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to give permissions'
		RETURN (1)
	END

	-- check to see if user has permission in before adding it in because permissions can't be duplicated
	IF NOT EXISTS (SELECT 1 FROM dbo.personnel_permissions
					WHERE personnel_id = (SELECT id FROM dbo.personnel WHERE username = @username)
					AND permissions_id = (SELECT id FROM dbo.permissions
											WHERE action_id = (SELECT id FROM dbo.permission_actions WHERE action = 'read')
											AND object_id = (SELECT id FROM dbo.permission_objects WHERE object = 'locations')
										 )
				  )
	BEGIN
		INSERT INTO dbo.personnel_permissions (personnel_id, permissions_id)
		VALUES (
		(SELECT TOP 1 id FROM dbo.personnel WHERE username=@username),
		(SELECT TOP 1 id FROM dbo.permissions 
			WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
			AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'locations'))
		)
	END

	IF NOT EXISTS (SELECT 1 FROM dbo.personnel_permissions
					WHERE personnel_id = (SELECT id FROM dbo.personnel WHERE username = @username)
					AND permissions_id = (SELECT id FROM dbo.permissions
											WHERE action_id = (SELECT id FROM dbo.permission_actions WHERE action = 'read')
											AND object_id = (SELECT id FROM dbo.permission_objects WHERE object = 'palettes')
										 )
				  )
	BEGIN
		INSERT INTO dbo.personnel_permissions (personnel_id, permissions_id)
		VALUES (
		(SELECT TOP 1 id FROM dbo.personnel WHERE username=@username),
		(SELECT TOP 1 id FROM dbo.permissions 
			WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
			AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'palettes'))
		)
	END

	
	SET @response = 'SUCCESS'
	RETURN (0)

END
USE warehouse_management
GO


EXEC dbo.uspCreateAllPermissions

DECLARE @num_expected_permissions INT = (SELECT COUNT(id) FROM dbo.permission_actions) * (SELECT COUNT(id) FROm dbo.permission_objects)
DECLARE @num_permissions INT = (SELECT COUNT(id) FROM dbo.permissions)

IF (@num_expected_permissions = @num_permissions)
	PRINT 'Successfully created all permissions'
ELSE
	PRINT 'Failed to create all permissions'
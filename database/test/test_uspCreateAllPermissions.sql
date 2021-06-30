USE warehouse_management
GO

DECLARE @res NVARCHAR(256)
DECLARE @EXPECTED NVARCHAR(256)
DECLARE @test_num INT = 1

PRINT 'TESTING USER PROCEDURE uspCreateAllPermissions'
PRINT 'BEGINNING TEST...'
-- =======================================================================================================================================
-- TEST 1
-- Check if all permissions are present after executing the uspCreateAllPermissions procedure
-- EXPECTED OUTPUT = 'Successfully created all permissions'
--SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreateAllPermissions
	--@response = @res OUTPUT
DECLARE @num_expected_permissions INT = (SELECT COUNT(id) FROM dbo.permission_actions) * (SELECT COUNT(id) FROM dbo.permission_objects)
DECLARE @num_permissions INT = (SELECT COUNT(id) FROM dbo.permissions)

IF (@num_expected_permissions = @num_permissions)
	PRINT 'Successfully created all permissions'
ELSE
BEGIN
	PRINT 'Failed to create all permissions'
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
-- =======================================================================================================================================

--SELECT permission_actions.action, permission_objects.object
--FROM dbo.permissions
--INNER JOIN permission_actions
--ON permissions.action_id = permission_actions.id
--INNER JOIN permission_objects
--ON permissions.object_id = permission_objects.id

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER PROCEDURE uspCreateAllPermissions'
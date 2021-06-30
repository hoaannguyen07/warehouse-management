-- TEST uspDeletePersonnelPermission



USE [warehouse_management]
GO

SET NOCOUNT ON
DELETE FROM [dbo].[personnel] WHERE username='hoa'
SET NOCOUNT OFF

EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'test'

-- GIVE personnel_permissions PERMISSIONS TO @username=N'hoa' for this test (will be deleted after)
SET NOCOUNT ON
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel_permissions'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel_permissions'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel_permissions'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel_permissions'))
)
SET NOCOUNT OFF

--SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permission_actions.action, dbo.permission_objects.object
--FROM dbo.personnel_permissions
--INNER JOIN dbo.personnel
--ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
--INNER JOIN dbo.permissions
--ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
--INNER JOIN dbo.permission_actions
--ON dbo.permissions.action_id = dbo.permission_actions.id
--INNER JOIN dbo.permission_objects
--ON dbo.permissions.object_id = dbo.permission_objects.id
--WHERE dbo.personnel.username = 'hoa' 


DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

PRINT 'TESTING USER STORED PROCEDURE uspDeletePersonnelPermission'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- delete from invalid @username a valid permission with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'create',
	@object = N'personnel',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- delete from invalid @username a valid permission with invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'create',
	@object = N'personnel',
	@auth = N'sup',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- delete from invalid @username an invalid permission (invalid @action) with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'fish',
	@object = N'personnel',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- delete from invalid @username an invalid permission (invalid @action) with invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'fish',
	@object = N'personnel',
	@auth = N'chao',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- delete from invalid @username an invalid permission (invalid @object) with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'create',
	@object = N'tables',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- delete from invalid @username an invalid permission (invalid @object) with invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'create',
	@object = N'tables',
	@auth = N'bonjour',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- delete from invalid @username an invalid permission (invalid @action & @object) with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'fish',
	@object = N'farm',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 8
-- delete from invalid @username an invalid permission (invalid @action & @object) with invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'fish',
	@object = N'farm',
	@auth = N'konichiwa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 9
-- delete from valid @username an invalid permission (invalid @action) with valid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = 'Permission does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'fish',
	@object = N'personnel',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- delete from valid @username an invalid permission (invalid @action) with invalid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = 'Permission does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'fish',
	@object = N'personnel',
	@auth = N'fun',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 11
-- delete from valid @username an invalid permission (invalid @object) with valid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = 'Permission does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'delete',
	@object = N'sigh',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 12
-- delete from valid @username an invalid permission (invalid @object) with invalid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = 'Permission does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'awesome',
	@auth = N'fun',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 13
-- delete from valid @username an invalid permission (invalid @action & @object) with valid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = 'Permission does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'fish',
	@object = N'hamster',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 14
-- delete from valid @username an invalid permission (invalid @action & object) with invalid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = 'Permission does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'skin',
	@object = N'building',
	@auth = N'fun',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 15
-- delete from valid @username a valid permission that @username doesn't have with valid @auth
-- EXPECTED OUTPUT = 'Personnel does not have this permission'
SET @EXPECTED = 'Personnel does not have this permission'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'personnel',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 16
-- delete from valid @username a valid permission that @username doesn't have with invalid @auth
-- EXPECTED OUTPUT = 'Personnel does not have this permission'
SET @EXPECTED = 'Personnel does not have this permission'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'personnel',
	@auth = N'chao',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 17
-- delete from valid @username a valid permission with invalid @auth
-- EXPECTED OUTPUT = 'Unauthorized to delete permission'
SET @EXPECTED = 'Unauthorized to delete permission'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'personnel_permissions',
	@auth = N'asdf',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 18
-- delete from invalid @username a valid permission that @username doesn't have with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'create',
	@object = N'personnel',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 19
-- delete from valid @username an invalid permission (invalid @action) that @username doesn't have with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Permission does not exist'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'fly',
	@object = N'personnel',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 20
-- delete from valid @username a valid permission that the @username has with valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'read',
	@object = N'personnel_permissions',
	@auth = N'test',
	@response = @response OUTPUT
-- check if operation is SUCCESSFUL and and if the permission is truly deleted from the database
IF (@response <> @EXPECTED) 
	OR EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permission_actions.action, dbo.permission_objects.object
			FROM dbo.personnel_permissions
			INNER JOIN dbo.personnel
			ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
			INNER JOIN dbo.permissions
			ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
			INNER JOIN dbo.permission_actions
			ON dbo.permissions.action_id = dbo.permission_actions.id
			INNER JOIN dbo.permission_objects
			ON dbo.permissions.object_id = dbo.permission_objects.id
			WHERE dbo.personnel.username = 'hoa'
			AND dbo.permission_actions.action = 'read'
			AND dbo.permission_objects.object = 'personnel_permissions')
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 21
-- delete from valid @username a valid permission that the @username has with valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'personnel_permissions',
	@auth = N'hoa',
	@response = @response OUTPUT
-- check if operation is SUCCESSFUL and and if the permission is truly deleted from the database
IF (@response <> @EXPECTED) 
	OR EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permission_actions.action, dbo.permission_objects.object
			FROM dbo.personnel_permissions
			INNER JOIN dbo.personnel
			ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
			INNER JOIN dbo.permissions
			ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
			INNER JOIN dbo.permission_actions
			ON dbo.permissions.action_id = dbo.permission_actions.id
			INNER JOIN dbo.permission_objects
			ON dbo.permissions.object_id = dbo.permission_objects.id
			WHERE dbo.personnel.username = 'hoa'
			AND dbo.permission_actions.action = 'read'
			AND dbo.permission_objects.object = 'personnel_permissions')
BEGIN
	PRINT CONCAT('uspDeletePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspDeletePersonnelPermission'

--SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permission_actions.action, dbo.permission_objects.object
--FROM dbo.personnel_permissions
--INNER JOIN dbo.personnel
--ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
--INNER JOIN dbo.permissions
--ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
--INNER JOIN dbo.permission_actions
--ON dbo.permissions.action_id = dbo.permission_actions.id
--INNER JOIN dbo.permission_objects
--ON dbo.permissions.object_id = dbo.permission_objects.id
--WHERE dbo.personnel.username = 'hoa' 

-- delete all personnel used in this test to make sure that database in clean 
-- don't need to make sure to delete leftover personnel permissions b/c the personnel_permissions table Cascades on delete of a personnel_id & permissions_id
SET NOCOUNT ON
DELETE FROM [dbo].[personnel] WHERE username='hoa' 
SET NOCOUNT OFF

IF EXISTS (SELECT id FROM dbo.personnel WHERE username = 'hoa')
	PRINT 'Unable to fully erase everything created in the uspDeletePersonnelPermission Test'
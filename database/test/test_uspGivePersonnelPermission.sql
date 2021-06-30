-- TEST uspGivePersonnelPermission



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

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

PRINT 'TESTING USER STORED PROCEDURE uspGivePersonnelPermission'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- give valid @username a valid permission with valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspGivePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'personnel',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1

-- delete the created permission to make sure test doesn't affect database
EXEC dbo.uspDeletePersonnelPermission
	@username= 'hoa',
	@action = 'create',
	@object = N'personnel',
	@auth = 'test'
IF EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permission_actions.action, dbo.permission_objects.object
							FROM dbo.personnel_permissions
							INNER JOIN dbo.personnel
							ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
							INNER JOIN dbo.permissions
							ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
							INNER JOIN dbo.permission_actions
							ON dbo.permissions.action_id = dbo.permission_actions.id
							INNER JOIn dbo.permission_objects
							ON dbo.permissions.object_id = dbo.permission_objects.id
							WHERE dbo.personnel.username = N'hoa' 
							AND dbo.permission_actions.action = 'create' 
							AND dbo.permission_objects.object = 'personnel')
BEGIN
	SELECT 'Was not able to delete permission created in Test 1' AS error
END
-- ============================================================================


-- ============================================================================
-- TEST 2
-- give @username a different valid permission with valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspGivePersonnelPermission
	@username= N'hoa',
	@action = N'update',
	@object = N'palettes',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1

EXEC dbo.uspDeletePersonnelPermission
	@username= 'hoa',
	@action = 'update',
	@object = N'palettes',
	@auth = 'test'
IF EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permission_actions.action, dbo.permission_objects.object
							FROM dbo.personnel_permissions
							INNER JOIN dbo.personnel
							ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
							INNER JOIN dbo.permissions
							ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
							INNER JOIN dbo.permission_actions
							ON dbo.permissions.action_id = dbo.permission_actions.id
							INNER JOIn dbo.permission_objects
							ON dbo.permissions.object_id = dbo.permission_objects.id
							WHERE dbo.personnel.username = N'hoa' 
							AND dbo.permission_actions.action = 'update' 
							AND dbo.permission_objects.object = 'palettes')
BEGIN
	SELECT 'Was not able to delete permission created in Test 2' AS error
END
-- ============================================================================


-- ============================================================================
-- TEST 3
-- give valid @username a valid permission and valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspGivePersonnelPermission
	@username= N'hoa',
	@action = N'read',
	@object = N'rows',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
--TEST 4
-- give @username a duplicate permission with valid @auth
-- EXPECTED OUTPUT = 'Personnel already has this permission'
SET @EXPECTED = '%Personnel already has this permission%'
EXEC dbo.uspGivePersonnelPermission
	@username= N'hoa',
	@action = N'read',
	@object = N'rows',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1

EXEC dbo.uspDeletePersonnelPermission
	@username= 'hoa',
	@action = 'read',
	@object = N'rows',
	@auth = 'test'
IF EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permission_actions.action, dbo.permission_objects.object
							FROM dbo.personnel_permissions
							INNER JOIN dbo.personnel
							ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
							INNER JOIN dbo.permissions
							ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
							INNER JOIN dbo.permission_actions
							ON dbo.permissions.action_id = dbo.permission_actions.id
							INNER JOIn dbo.permission_objects
							ON dbo.permissions.object_id = dbo.permission_objects.id
							WHERE dbo.personnel.username = N'hoa' 
							AND dbo.permission_actions.action = 'read' 
							AND dbo.permission_objects.object = 'rows')
BEGIN
	SELECT 'Was not able to delete permission created in Test 2' AS error
END
-- ============================================================================


-- ============================================================================
-- TEST 5
-- give an invalid @username a valid permission with a valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hello',
	@action = 'update',
	@object = N'locations',
	@auth = '123',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- give an invalid @username an invalid permission (invalid @action) with a valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hello',
	@action = 'updater',
	@object = N'locations',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- give an invalid @username an invalid permission (invalid @action) with a invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hello',
	@action = 'updater',
	@object = N'locations',
	@auth = 'hai',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 8
-- give an invalid @username an invalid permission (invalid @object) with a valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hello',
	@action = 'update',
	@object = N'location',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 9
-- give an invalid @username an invalid permission (invalid @object) with a invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hello',
	@action = 'update',
	@object = N'location',
	@auth = 'asdf',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- give an invalid @username an invalid permission (invalid @action & @object) with a valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hello',
	@action = 'cancel',
	@object = N'location',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 11
-- give an invalid @username an invalid permission (invalid @action & @object) with a invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hello',
	@action = 'cancel',
	@object = N'location',
	@auth = 'qwer',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 12
-- give an valid @username an invalid permission (invalid @action) with a valid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hoa',
	@action = 'cancel',
	@object = N'rows',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 13
-- give an valid @username an invalid permission (invalid @action) with a invalid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hoa',
	@action = 'catch',
	@object = N'levels',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 14
-- give an valid @username an invalid permission (invalid @object) with a valid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hoa',
	@action = 'update',
	@object = N'fish',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 15
-- give an valid @username an invalid permission (invalid @object) with a invalid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hoa',
	@action = 'read',
	@object = N'fruit',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 16
-- give an valid @username an invalid permission (invalid @action & @object) with a valid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hoa',
	@action = 'grill',
	@object = N'fish',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 17
-- give an valid @username an invalid permission (invalid @action & @object) with a invalid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hoa',
	@action = 'poke',
	@object = N'cows',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 18
-- give valid @username a valid [@action-@object] but with invalid @auth
-- EXPECTED OUTPUT = 'Unauthorized to give permission'
SET @EXPECTED = '%Unauthorized to give permission%'
EXEC dbo.uspGivePersonnelPermission
	@username= 'hoa',
	@action = 'delete',
	@object = N'personnel',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspGivePersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspGivePersonnelPermission'

-- delete all personnel used in this test to make sure that database in clean 
-- don't need to make sure to delete leftover personnel permissions b/c the personnel_permissions table Cascades on delete of a personnel_id & permissions_id
DELETE FROM [dbo].[personnel] WHERE username='hoa' 


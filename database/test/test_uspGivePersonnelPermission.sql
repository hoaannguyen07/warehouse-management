-- TEST uspGivePersonnelPermission



USE [warehouse_management]
GO

DELETE FROM [dbo].[personnel] WHERE username='hoa'

EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'test'

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 1 SUCCESSFUL' AS test_output
ELSE
BEGIN
	SELECT @response AS response
	SELECT 'uspGivePersonnelPermission TEST 1 FAILED' AS test_output
END

-- delete the created permission to make sure test doesn't affect database
EXEC dbo.uspDeletePersonnelPermission
	@username= 'hoa',
	@action = 'create',
	@object = N'personnel',
	@auth = 'test'
IF EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permissions.action, dbo.permissions.object
			FROM dbo.personnel_permissions
			INNER JOIN dbo.personnel
			ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
			INNER JOIN dbo.permissions
			ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
			WHERE dbo.personnel.username = N'hoa' 
			AND dbo.permissions.action = N'create' 
			AND dbo.permissions.object = N'personnel')
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 2 SUCCESSFUL' AS test_output
ELSE
BEGIN
	SELECT @response AS response
	SELECT 'uspGivePersonnelPermission TEST 2 FAILED' AS test_output
END

EXEC dbo.uspDeletePersonnelPermission
	@username= 'hoa',
	@action = 'update',
	@object = N'palettes',
	@auth = 'test'
IF EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permissions.action, dbo.permissions.object
			FROM dbo.personnel_permissions
			INNER JOIN dbo.personnel
			ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
			INNER JOIN dbo.permissions
			ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
			WHERE dbo.personnel.username = N'hoa' 
			AND dbo.permissions.action = N'update' 
			AND dbo.permissions.object = N'palettes')
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 3 SUCCESSFUL' AS test_output
ELSE
BEGIN
	SELECT @response AS response
	SELECT 'uspGivePersonnelPermission TEST 3 FAILED' AS test_output
END
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 4 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 4 FAILED' AS test_output

EXEC dbo.uspDeletePersonnelPermission
	@username= 'hoa',
	@action = 'read',
	@object = N'rows',
	@auth = 'test'
IF EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permissions.action, dbo.permissions.object
			FROM dbo.personnel_permissions
			INNER JOIN dbo.personnel
			ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
			INNER JOIN dbo.permissions
			ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
			WHERE dbo.personnel.username = N'hoa' 
			AND dbo.permissions.action = N'read' 
			AND dbo.permissions.object = N'rows')
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 5 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 5 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 6 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 6 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 7 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 7 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 8 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 8 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 9 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 9 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 10 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 10 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 11 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 11 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 12 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 12 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 13 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 13 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 14 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 14 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 15 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 15 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 16 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 16 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 17 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 17 FAILED' AS test_output
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
IF (@response LIKE @EXPECTED)
	SELECT 'uspGivePersonnelPermission TEST 18 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspGivePersonnelPermission TEST 18 FAILED' AS test_output
-- ============================================================================


-- delete all personnel used in this test to make sure that database in clean 
-- don't need to make sure to delete leftover personnel permissions b/c the personnel_permissions table Cascades on delete of a personnel_id & permissions_id
DELETE FROM [dbo].[personnel] WHERE username='hoa' 
-- TEST uspDeletePersonnelPermission



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

-- GIVE personnel_permissions PERMISSIONS TO @username=N'hoa' for this test (will be deleted after)
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username=N'hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions WHERE action='create' AND object='personnel_permissions'))

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username=N'hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions WHERE action='read' AND object='personnel_permissions'))

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username=N'hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions WHERE action='update' AND object='personnel_permissions'))

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username=N'hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions WHERE action='delete' AND object='personnel_permissions'))


SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permissions.action, dbo.permissions.object
FROM dbo.personnel_permissions
INNER JOIN dbo.personnel
ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
INNER JOIN dbo.permissions
ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
WHERE dbo.personnel.username = 'hoa'



-- ============================================================================
-- TEST 1
-- delete from invalid @username a valid permission with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'create',
	@object = N'personnel',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 1 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 1 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 2
-- delete from invalid @username a valid permission with invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'create',
	@object = N'personnel',
	@auth = N'sup',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 2 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 2 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 3
-- delete from invalid @username an invalid permission (invalid @action) with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'fish',
	@object = N'personnel',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 3 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 3 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 4
-- delete from invalid @username an invalid permission (invalid @action) with invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'fish',
	@object = N'personnel',
	@auth = N'chao',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 4 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 3 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 5
-- delete from invalid @username an invalid permission (invalid @object) with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'create',
	@object = N'tables',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 5 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 5 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 6
-- delete from invalid @username an invalid permission (invalid @object) with invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'create',
	@object = N'tables',
	@auth = N'bonjour',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 6 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 6 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 7
-- delete from invalid @username an invalid permission (invalid @action & @object) with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'fish',
	@object = N'farm',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 7 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 7 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 8
-- delete from invalid @username an invalid permission (invalid @action & @object) with invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'fish',
	@object = N'farm',
	@auth = N'konichiwa',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 8 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 8 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 9
-- delete from valid @username an invalid permission (invalid @action) with valid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'fish',
	@object = N'personnel',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 9 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 9 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 10
-- delete from valid @username an invalid permission (invalid @action) with invalid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'fish',
	@object = N'personnel',
	@auth = N'fun',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 10 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 10 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 11
-- delete from valid @username an invalid permission (invalid @object) with valid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'delete',
	@object = N'sigh',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 11 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 11 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 12
-- delete from valid @username an invalid permission (invalid @object) with invalid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'awesome',
	@auth = N'fun',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 12 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 12 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 13
-- delete from valid @username an invalid permission (invalid @action & @object) with valid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'fish',
	@object = N'hamster',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 13 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 13 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 14
-- delete from valid @username an invalid permission (invalid @action & object) with invalid @auth
-- EXPECTED OUTPUT = 'Permission does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'skin',
	@object = N'building',
	@auth = N'fun',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 14 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 14 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 15
-- delete from valid @username a valid permission that @username doesn't have with valid @auth
-- EXPECTED OUTPUT = 'Personnel does not have this permission'
SET @EXPECTED = '%Personnel does not have this permission%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'personnel',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 15 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 15 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 15
-- delete from valid @username a valid permission that @username doesn't have with invalid @auth
-- EXPECTED OUTPUT = 'Personnel does not have this permission'
SET @EXPECTED = '%Personnel does not have this permission%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'personnel',
	@auth = N'chao',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 15 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 15 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 16
-- delete from valid @username a valid permission with invalid @auth
-- EXPECTED OUTPUT = 'Unauthorized to delete permission'
SET @EXPECTED = '%Unauthorized to delete permission%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'personnel_permissions',
	@auth = N'asdf',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 16 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 16 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 17
-- delete from invalid @username a valid permission that @username doesn't have with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'123',
	@action = N'create',
	@object = N'personnel',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 17 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 17 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 17
-- delete from valid @username an invalid permission (invalid @action) that @username doesn't have with valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = '%Permission does not exist%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'fly',
	@object = N'personnel',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED)
	SELECT 'uspDeletePersonnelPermission TEST 17 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnelPermission TEST 17 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 18
-- delete from valid @username a valid permission that the @username has with valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'read',
	@object = N'personnel_permissions',
	@auth = N'test',
	@response = @response OUTPUT
-- check if operation is SUCCESSFUL and and if the p
IF (@response LIKE @EXPECTED AND 
	NOT EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permissions.action, dbo.permissions.object
			FROM dbo.personnel_permissions
			INNER JOIN dbo.personnel
			ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
			INNER JOIN dbo.permissions
			ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
			WHERE dbo.personnel.username = N'hoa' 
			AND dbo.permissions.action = N'read' 
			AND dbo.permissions.object = N'personnel_permissions'))
BEGIN
	SELECT 'uspDeletePersonnelPermission TEST 18 SUCCESSFUL' AS test_output
END
ELSE
BEGIN
	SELECT @response AS response
	SELECT 'uspDeletePersonnelPermission TEST 18 FAILED' AS test_output
END
-- ============================================================================


-- ============================================================================
-- TEST 19
-- delete from valid @username a valid permission that the @username has with valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspDeletePersonnelPermission
	@username= N'hoa',
	@action = N'create',
	@object = N'personnel_permissions',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response LIKE @EXPECTED AND 
	NOT EXISTS (SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permissions.action, dbo.permissions.object
			FROM dbo.personnel_permissions
			INNER JOIN dbo.personnel
			ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
			INNER JOIN dbo.permissions
			ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
			WHERE dbo.personnel.username = N'hoa' 
			AND dbo.permissions.action = N'create' 
			AND dbo.permissions.object = N'personnel_permissions'))
	SELECT 'uspDeletePersonnelPermission TEST 19 SUCCESSFUL' AS test_output
ELSE
BEGIN
	SELECT @response AS response
	SELECT 'uspDeletePersonnelPermission TEST 19 FAILED' AS test_output
END
-- ============================================================================


-- delete all personnel used in this test to make sure that database in clean 
-- don't need to make sure to delete leftover personnel permissions b/c the personnel_permissions table Cascades on delete of a personnel_id & permissions_id
DELETE FROM [dbo].[personnel] WHERE username='hoa' 
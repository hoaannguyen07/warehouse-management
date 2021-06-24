-- TEST uspCheckPersonnelPermission



USE warehouse_management

DECLARE @res NVARCHAR(3)
DECLARE @EXPECTED NVARCHAR(256)
DECLARE @test_num INT = 1

PRINT 'TESTING USER STORED PROCEDURE uspCheckPersonnelPermission'
PRINT 'BEGINNING TEST...'
-- ****************************************************************************
-- *							PERSONNEL TABLE								  *
-- ****************************************************************************
PRINT 'Checking personnel table...'
-- ============================================================================
-- TEST 1
-- Check if [username]='test' has the permissions to [create] a [personnel]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================

-- ============================================================================
-- TEST 2
-- Check if [username]='hoa' has the permissions to [create] a [personnel]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'create',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Check if [username]='test' has the permissions to [update] a [personnel]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'update',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Check if [username]='hoa' has the permissions to [update] a [personnel]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'update',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Check if [username]='test' has the permissions to [read] a [personnel]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Check if [username]='binh' has the permissions to [read] a [personnel]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'read',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- Check if [username]='test' has the permissions to [delete] a [personnel]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'delete',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 8
-- Check if [username]='jordan' has the permissions to [delete] a [personnel]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'delete',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================




-- ****************************************************************************
-- *							PERMISSIONS TABLE							  *
-- ****************************************************************************
PRINT 'Checking permissions table...'
-- ============================================================================
-- TEST 9
-- Check if [username]='jason' has the permissions to [create] a [permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'create',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================

-- ============================================================================
-- TEST 10
-- Check if [username]='hoa' has the permissions to [create] a [permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'create',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 11
-- Check if [username]='test' has the permissions to [update] a [permissions]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'update',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 12
-- Check if [username]='hoa' has the permissions to [update] a [permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'update',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 13
-- Check if [username]='test' has the permissions to [read] a [permissions]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 14
-- Check if [username]='binh' has the permissions to [read] a [permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'read',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 15
-- Check if [username]='test' has the permissions to [delete] a [permissions]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'delete',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 16
-- Check if [username]='jordan' has the permissions to [delete] a [permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'delete',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================





-- ****************************************************************************
-- *					PERSONNEL_PERMISSIONS TABLE							  *
-- ****************************************************************************
PRINT 'Checking personnel_permissions table...'
-- ============================================================================
-- TEST 17
-- Check if [username]='binh' has the permissions to [create] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'create',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================

-- ============================================================================
-- TEST 18
-- Check if [username]='test' has the permissions to [create] a [personnel_permissions]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 19
-- Check if [username]='hai' has the permissions to [update] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hai',
	@action = 'update',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 20
-- Check if [username]='HELLO' has the permissions to [update] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'HELLO',
	@action = 'update',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 21
-- Check if [username]='test' has the permissions to [read] a [personnel_permissions]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 22
-- Check if [username]='jordan' has the permissions to [read] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'read',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 23
-- Check if [username]='jason' has the permissions to [delete] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'delete',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 24
-- Check if [username]='JaSoN' has the permissions to [delete] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'JaSoN',
	@action = 'delete',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================



-- ****************************************************************************
-- *								ROWS TABLE								  *
-- ****************************************************************************
PRINT 'Checking rows table...'
-- ============================================================================
-- TEST 25
-- Check if [username]='binh' has the permissions to [create] a [rows]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'create',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================

-- ============================================================================
-- TEST 26
-- Check if [username]='test' has the permissions to [create] a [rows]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 27
-- Check if [username]='hai' has the permissions to [update] a [rows]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hai',
	@action = 'update',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 28
-- Check if [username]='HELLO' has the permissions to [update] a [rows]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'HELLO',
	@action = 'update',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 29
-- Check if [username]='test' has the permissions to [read] a [rows]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 30
-- Check if [username]='jordan' has the permissions to [read] a [rows]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'read',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 31
-- Check if [username]='jason' has the permissions to [delete] a [rows]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'delete',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 32
-- Check if [username]='JaSoN' has the permissions to [delete] a [rows]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'JaSoN',
	@action = 'delete',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================



-- ****************************************************************************
-- *							COLUMNS TABLE								  *
-- ****************************************************************************
PRINT 'Checking columns table...'
-- ============================================================================
-- TEST 33
-- Check if [username]='test' has the permissions to [create] a [columns]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================

-- ============================================================================
-- TEST 34
-- Check if [username]='hoa' has the permissions to [create] a [columns]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'create',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 35
-- Check if [username]='test' has the permissions to [update] a [columns]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'update',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 36
-- Check if [username]='hoa' has the permissions to [update] a [columns]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'update',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 37
-- Check if [username]='test' has the permissions to [read] a [columns]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 38
-- Check if [username]='binh' has the permissions to [read] a [columns]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'read',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 39
-- Check if [username]='test' has the permissions to [delete] a [columns]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'delete',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 40
-- Check if [username]='jordan' has the permissions to [delete] a [columns]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'delete',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================




-- ****************************************************************************
-- *								TYPES TABLE								  *
-- ****************************************************************************
PRINT 'Checking types table...'
-- ============================================================================
-- TEST 41
-- Check if [username]='jason' has the permissions to [create] a [types]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'create',
	@object = 'types',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================

-- ============================================================================
-- TEST 42
-- Check if [username]='hoa' has the permissions to [create] a [types]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'create',
	@object = 'types',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 43
-- Check if [username]='test' has the permissions to [update] a [types]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'update',
	@object = 'types',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 44
-- Check if [username]='hoa' has the permissions to [update] a [types]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'update',
	@object = 'types',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 45
-- Check if [username]='test' has the permissions to [read] a [types]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'types',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 46
-- Check if [username]='binh' has the permissions to [read] a [types]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'read',
	@object = 'types',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 47
-- Check if [username]='test' has the permissions to [delete] a [types]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'delete',
	@object = 'types',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 48
-- Check if [username]='jordan' has the permissions to [delete] a [types]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'delete',
	@object = 'types',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================





-- ****************************************************************************
-- *								LEVELS TABLE							  *
-- ****************************************************************************
PRINT 'Checking levels table...'
-- ============================================================================
-- TEST 49
-- Check if [username]='binh' has the permissions to [create] a [levels]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'create',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================

-- ============================================================================
-- TEST 50
-- Check if [username]='test' has the permissions to [create] a [levels]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 51
-- Check if [username]='hai' has the permissions to [update] a [levels]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hai',
	@action = 'update',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 52
-- Check if [username]='HELLO' has the permissions to [update] a [levels]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'HELLO',
	@action = 'update',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 53
-- Check if [username]='test' has the permissions to [read] a [levels]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 54
-- Check if [username]='jordan' has the permissions to [read] a [levels]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'read',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 55
-- Check if [username]='jason' has the permissions to [delete] a [levels]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'delete',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 56
-- Check if [username]='JaSoN' has the permissions to [delete] a [levels]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'JaSoN',
	@action = 'delete',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================



-- ****************************************************************************
-- *							PALETTES TABLE								  *
-- ****************************************************************************
PRINT 'Checking palettes table...'
-- ============================================================================
-- TEST 57
-- Check if [username]='binh' has the permissions to [create] a [palettes]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'create',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================

-- ============================================================================
-- TEST 58
-- Check if [username]='test' has the permissions to [create] a [palettes]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 59
-- Check if [username]='hai' has the permissions to [update] a [palettes]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hai',
	@action = 'update',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 60
-- Check if [username]='HELLO' has the permissions to [update] a [palettes]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'HELLO',
	@action = 'update',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 61
-- Check if [username]='test' has the permissions to [read] a [palettes]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 62
-- Check if [username]='jordan' has the permissions to [read] a [palettes]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'read',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 63
-- Check if [username]='jason' has the permissions to [delete] a [palettes]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'delete',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 64
-- Check if [username]='JaSoN' has the permissions to [delete] a [palettes]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'JaSoN',
	@action = 'delete',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================



-- ****************************************************************************
-- *							LOCATIONS TABLE								  *
-- ****************************************************************************
PRINT 'Checking locations table...'
-- ============================================================================
-- TEST 65
-- Check if [username]='binh' has the permissions to [create] a [locations]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'create',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================

-- ============================================================================
-- TEST 66
-- Check if [username]='test' has the permissions to [create] a [locations]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 67
-- Check if [username]='hai' has the permissions to [update] a [locations]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hai',
	@action = 'update',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 68
-- Check if [username]='HELLO' has the permissions to [update] a [locations]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'HELLO',
	@action = 'update',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 69
-- Check if [username]='test' has the permissions to [read] a [locations]
-- EXPECTED OUTPUT = 'YES'
SET @EXPECTED = '%YES%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 70
-- Check if [username]='jordan' has the permissions to [read] a [locations]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'read',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 71
-- Check if [username]='jason' has the permissions to [delete] a [locations]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'delete',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 72
-- Check if [username]='JaSoN' has the permissions to [delete] a [locations]
-- EXPECTED OUTPUT = 'NO'
SET @EXPECTED = '%NO%'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'JaSoN',
	@action = 'delete',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCheckPersonnelPermission TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @res)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspCheckPersonnelPermission'
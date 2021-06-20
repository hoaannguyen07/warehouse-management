-- TEST uspCheckPersonnelPermission



USE warehouse_management

DECLARE @res NVARCHAR(3)

-- ****************************************************************************
-- *							PERSONNEL TABLE								  *
-- ****************************************************************************
SELECT 'PERSONNEL TABLE' AS table_name
-- ============================================================================
-- TEST 1
-- Check if [username]='test' has the permissions to [create] a [personnel]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 1 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 1 FAILED' AS test_output
-- ============================================================================

-- ============================================================================
-- TEST 2
-- Check if [username]='hoa' has the permissions to [create] a [personnel]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'create',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 2 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 2 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Check if [username]='test' has the permissions to [update] a [personnel]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'update',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 3 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 3 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Check if [username]='hoa' has the permissions to [update] a [personnel]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'update',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 4 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 4 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Check if [username]='test' has the permissions to [read] a [personnel]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 5 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 5 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Check if [username]='binh' has the permissions to [read] a [personnel]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'read',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 6 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 6 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 7
-- Check if [username]='test' has the permissions to [delete] a [personnel]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'delete',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 7 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 7 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 8
-- Check if [username]='jordan' has the permissions to [delete] a [personnel]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'delete',
	@object = 'personnel',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 8 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 8 FAILED' AS test_output
-- ============================================================================




-- ****************************************************************************
-- *							PERMISSIONS TABLE							  *
-- ****************************************************************************
SELECT 'PERMISSIONS TABLE' AS table_name
-- ============================================================================
-- TEST 9
-- Check if [username]='jason' has the permissions to [create] a [permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'create',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 9 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 9 FAILED' AS test_output
-- ============================================================================

-- ============================================================================
-- TEST 10
-- Check if [username]='hoa' has the permissions to [create] a [permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'create',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 10 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 10 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 11
-- Check if [username]='test' has the permissions to [update] a [permissions]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'update',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 11 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 11 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 12
-- Check if [username]='hoa' has the permissions to [update] a [permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'update',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 12 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 12 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 13
-- Check if [username]='test' has the permissions to [read] a [permissions]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 13 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 13 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 14
-- Check if [username]='binh' has the permissions to [read] a [permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'read',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 14 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 14 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 15
-- Check if [username]='test' has the permissions to [delete] a [permissions]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'delete',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 15 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 15 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 16
-- Check if [username]='jordan' has the permissions to [delete] a [permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'delete',
	@object = 'permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 16 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 16 FAILED' AS test_output
-- ============================================================================





-- ****************************************************************************
-- *					PERSONNEL_PERMISSIONS TABLE							  *
-- ****************************************************************************
SELECT 'PERSONNEL_PERMISSIONS TABLE' AS table_name
-- ============================================================================
-- TEST 17
-- Check if [username]='binh' has the permissions to [create] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'create',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 17 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 17 FAILED' AS test_output
-- ============================================================================

-- ============================================================================
-- TEST 18
-- Check if [username]='test' has the permissions to [create] a [personnel_permissions]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 18 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 18 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 19
-- Check if [username]='hai' has the permissions to [update] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hai',
	@action = 'update',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 19 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 19 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 20
-- Check if [username]='HELLO' has the permissions to [update] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'HELLO',
	@action = 'update',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 20 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 20 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 21
-- Check if [username]='test' has the permissions to [read] a [personnel_permissions]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 21 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 21 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 22
-- Check if [username]='jordan' has the permissions to [read] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'read',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 22 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 22 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 23
-- Check if [username]='jason' has the permissions to [delete] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'delete',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 23 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 23 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 24
-- Check if [username]='JaSoN' has the permissions to [delete] a [personnel_permissions]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'JaSoN',
	@action = 'delete',
	@object = 'personnel_permissions',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 24 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 24 FAILED' AS test_output
-- ============================================================================



-- ****************************************************************************
-- *								ROWS TABLE								  *
-- ****************************************************************************
SELECT 'ROWS TABLE' AS table_name
-- ============================================================================
-- TEST 25
-- Check if [username]='binh' has the permissions to [create] a [rows]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'create',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 25 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 25 FAILED' AS test_output
-- ============================================================================

-- ============================================================================
-- TEST 26
-- Check if [username]='test' has the permissions to [create] a [rows]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 26 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 26 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 27
-- Check if [username]='hai' has the permissions to [update] a [rows]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hai',
	@action = 'update',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 27 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 27 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 28
-- Check if [username]='HELLO' has the permissions to [update] a [rows]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'HELLO',
	@action = 'update',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 28 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 28 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 29
-- Check if [username]='test' has the permissions to [read] a [rows]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 29 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 29 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 30
-- Check if [username]='jordan' has the permissions to [read] a [rows]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'read',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 30 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 30 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 31
-- Check if [username]='jason' has the permissions to [delete] a [rows]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'delete',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 31 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 31 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 32
-- Check if [username]='JaSoN' has the permissions to [delete] a [rows]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'JaSoN',
	@action = 'delete',
	@object = 'rows',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 32 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 32 FAILED' AS test_output
-- ============================================================================



-- ****************************************************************************
-- *							COLUMNS TABLE								  *
-- ****************************************************************************
SELECT 'COLUMNS TABLE' AS table_name
-- ============================================================================
-- TEST 33
-- Check if [username]='test' has the permissions to [create] a [columns]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 33 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 33 FAILED' AS test_output
-- ============================================================================

-- ============================================================================
-- TEST 34
-- Check if [username]='hoa' has the permissions to [create] a [columns]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'create',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 34 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 34 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 35
-- Check if [username]='test' has the permissions to [update] a [columns]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'update',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 35 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 35 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 36
-- Check if [username]='hoa' has the permissions to [update] a [columns]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'update',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 36 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 36 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 37
-- Check if [username]='test' has the permissions to [read] a [columns]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 37 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 37 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 38
-- Check if [username]='binh' has the permissions to [read] a [columns]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'read',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 38 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 38 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 39
-- Check if [username]='test' has the permissions to [delete] a [columns]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'delete',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 39 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 39 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 40
-- Check if [username]='jordan' has the permissions to [delete] a [columns]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'delete',
	@object = 'columns',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 40 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 40 FAILED' AS test_output
-- ============================================================================




-- ****************************************************************************
-- *								TYPES TABLE								  *
-- ****************************************************************************
SELECT 'TYPES TABLE' AS table_name
-- ============================================================================
-- TEST 41
-- Check if [username]='jason' has the permissions to [create] a [types]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'create',
	@object = 'types',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 40 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 40 FAILED' AS test_output
-- ============================================================================

-- ============================================================================
-- TEST 42
-- Check if [username]='hoa' has the permissions to [create] a [types]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'create',
	@object = 'types',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 42 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 42 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 43
-- Check if [username]='test' has the permissions to [update] a [types]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'update',
	@object = 'types',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 43 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 43 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 44
-- Check if [username]='hoa' has the permissions to [update] a [types]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hoa',
	@action = 'update',
	@object = 'types',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 44 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 44 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 45
-- Check if [username]='test' has the permissions to [read] a [types]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'types',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 45 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 45 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 46
-- Check if [username]='binh' has the permissions to [read] a [types]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'read',
	@object = 'types',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 46 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 46 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 47
-- Check if [username]='test' has the permissions to [delete] a [types]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'delete',
	@object = 'types',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 47 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 47 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 48
-- Check if [username]='jordan' has the permissions to [delete] a [types]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'delete',
	@object = 'types',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 48 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 48 FAILED' AS test_output
-- ============================================================================





-- ****************************************************************************
-- *								LEVELS TABLE							  *
-- ****************************************************************************
SELECT 'LEVELS TABLE' AS table_name
-- ============================================================================
-- TEST 49
-- Check if [username]='binh' has the permissions to [create] a [levels]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'create',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 49 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 49 FAILED' AS test_output
-- ============================================================================

-- ============================================================================
-- TEST 50
-- Check if [username]='test' has the permissions to [create] a [levels]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 50 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 50 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 51
-- Check if [username]='hai' has the permissions to [update] a [levels]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hai',
	@action = 'update',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 51 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 51 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 52
-- Check if [username]='HELLO' has the permissions to [update] a [levels]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'HELLO',
	@action = 'update',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 52 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 52 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 53
-- Check if [username]='test' has the permissions to [read] a [levels]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 53 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 53 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 54
-- Check if [username]='jordan' has the permissions to [read] a [levels]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'read',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 54 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 54 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 55
-- Check if [username]='jason' has the permissions to [delete] a [levels]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'delete',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 55 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 55 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 56
-- Check if [username]='JaSoN' has the permissions to [delete] a [levels]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'JaSoN',
	@action = 'delete',
	@object = 'levels',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 56 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 56 FAILED' AS test_output
-- ============================================================================



-- ****************************************************************************
-- *							PALETTES TABLE								  *
-- ****************************************************************************
SELECT 'PALETTES TABLE' AS table_name
-- ============================================================================
-- TEST 57
-- Check if [username]='binh' has the permissions to [create] a [palettes]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'create',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 57 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 57 FAILED' AS test_output
-- ============================================================================

-- ============================================================================
-- TEST 58
-- Check if [username]='test' has the permissions to [create] a [palettes]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 58 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 58 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 59
-- Check if [username]='hai' has the permissions to [update] a [palettes]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hai',
	@action = 'update',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 59 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 59 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 60
-- Check if [username]='HELLO' has the permissions to [update] a [palettes]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'HELLO',
	@action = 'update',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 60 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 60 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 61
-- Check if [username]='test' has the permissions to [read] a [palettes]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 61 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 61 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 62
-- Check if [username]='jordan' has the permissions to [read] a [palettes]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'read',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 62 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 62 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 63
-- Check if [username]='jason' has the permissions to [delete] a [palettes]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'delete',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 63 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 63 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 64
-- Check if [username]='JaSoN' has the permissions to [delete] a [palettes]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'JaSoN',
	@action = 'delete',
	@object = 'palettes',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 64 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 64 FAILED' AS test_output
-- ============================================================================



-- ****************************************************************************
-- *							LOCATIONS TABLE								  *
-- ****************************************************************************
SELECT 'LOCATIONS TABLE' AS table_name
-- ============================================================================
-- TEST 65
-- Check if [username]='binh' has the permissions to [create] a [locations]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'binh',
	@action = 'create',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 65 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 65 FAILED' AS test_output
-- ============================================================================

-- ============================================================================
-- TEST 66
-- Check if [username]='test' has the permissions to [create] a [locations]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'create',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 66 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 66 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 67
-- Check if [username]='hai' has the permissions to [update] a [locations]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'hai',
	@action = 'update',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 67 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 67 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 68
-- Check if [username]='HELLO' has the permissions to [update] a [locations]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'HELLO',
	@action = 'update',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 68 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 68 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 69
-- Check if [username]='test' has the permissions to [read] a [locations]
-- EXPECTED OUTPUT = 'YES'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'test',
	@action = 'read',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res = 'YES')
	SELECT 'uspCheckPersonnelPermission TEST 69 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 69 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 70
-- Check if [username]='jordan' has the permissions to [read] a [locations]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jordan',
	@action = 'read',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 70 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 70 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 71
-- Check if [username]='jason' has the permissions to [delete] a [locations]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'jason',
	@action = 'delete',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 71 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 71 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 72
-- Check if [username]='JaSoN' has the permissions to [delete] a [locations]
-- EXPECTED OUTPUT = 'NO'
EXEC dbo.uspCheckPersonnelPermission
	@username = 'JaSoN',
	@action = 'delete',
	@object = 'locations',
	@response = @res OUTPUT
IF (@res = 'NO')
	SELECT 'uspCheckPersonnelPermission TEST 72 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCheckPersonnelPermission TEST 72 FAILED' AS test_output
-- ============================================================================
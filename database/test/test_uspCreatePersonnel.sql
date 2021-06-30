-- TEST uspCreatePersonnel



USE [warehouse_management]
GO

DELETE FROM [dbo].[personnel] WHERE username NOT IN ('test', 'hoaannguyen07')

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

PRINT 'TESTING USER STORED PROCEDURE uspCreatePersonnel'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Creating peronnel w/ correct authorization, correct & unique user information
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR NOT EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=N'hoa')
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Creating personnel w/ incorrect authorization, correct & unique user information, auth in personnel
-- EXPECTED OUTPUT = 'Unauthorized to create personnel'
SET @EXPECTED = '%Unauthorized to create personnel%'
EXEC dbo.uspCreatePersonnel
	@username = N'binh',
	@password = N'binh123',
	@full_name = N'Binh Nguyen',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Creating personnel w/ incorrect authorization, correct & unique user information, auth not in personnel
-- EXPECTED OUTPUT = 'Unauthorized to create personnel'
SET @EXPECTED = 'Unauthorized to create personnel'
EXEC dbo.uspCreatePersonnel
	@username = N'nhan',
	@password = N'nhan123',
	@full_name = N'Nhan Nguyen',
	@auth = N'hello',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Creating peronnel w/ correct authorization, fully repeating user information
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Creating peronnel w/ incorrect authorization, fully repeating user information, auth in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Creating peronnel w/ incorrect authorization, fully repeating user information, auth not in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'hello',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- Creating peronnel w/ correct authorization, repeating username but not password & full_name user information
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'haibabon',
	@full_name = N'i dont know',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 8
-- Creating peronnel w/ incorrect authorization, repeating username but not password & full_name user information, auth in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'onetwothree',
	@full_name = N'what to do',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 9
-- Creating peronnel w/ incorrect authorization, repeating username but not password & full_name user information, auth not in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'bonnamsau',
	@full_name = N'abc',
	@auth = N'hello',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- Creating peronnel w/ correct authorization, repeating username & password but not full_name user information
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'i dont know',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 11
-- Creating peronnel w/ incorrect authorization, repeating username & password but not full_name user information, auth in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'what to do',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 12
-- Creating peronnel w/ incorrect authorization, repeating username & password but not full_name user information, auth not in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'abc',
	@auth = N'hello',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 13
-- Creating peronnel w/ correct authorization, repeating password & full_name but not username user information
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa1',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR NOT EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=N'hoa1')
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 14
-- Creating peronnel w/ correct authorization, repeating full_name but not username & password user information
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa2',
	@password = N'123hoa',
	@full_name = N'Hoa Nguyen',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR NOT EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=N'hoa2')
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 15
-- Creating peronnel w/ incorrect authorization, repeating password & full_name but not username user information, auth in personnel
-- EXPECTED OUTPUT = 'Unauthorized to create personnel'
SET @EXPECTED = '%Unauthorized to create personnel%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa3',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 16
-- Creating peronnel w/ incorrect authorization, repeating full_name but not username & password user information, auth not in personnel
-- EXPECTED OUTPUT = 'Unauthorized to create personnel'
SET @EXPECTED = '%Unauthorized to create personnel%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa4',
	@password = N'hoa1234',
	@full_name = N'Hoa Nguyen',
	@auth = N'hello',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

--SELECT * FROM [dbo].[personnel]

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspCreatePersonnel'

DELETE FROM [dbo].[personnel] WHERE username='hoa' OR username='hoa1' OR username='hoa2' OR username='hoa3' OR username='hoa4' OR username='nhan' OR username='binh'

IF EXISTS (SELECT 1 FROM dbo.personnel WHERE username='hoa' OR username='hoa1' OR username='hoa2' OR username='hoa3' OR username='hoa4' OR username='nhan' OR username='binh')
	PRINT 'Unable to fully erase everything created in the uspCreatePersonnel Test'

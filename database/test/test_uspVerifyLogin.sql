-- TEST uspVerifyLogin



USE [warehouse_management]
GO

DECLARE @EXPECTED nvarchar(27)
DECLARE @response nvarchar(27)
DECLARE @test_num INT = 1


PRINT 'TESTING USER STORED PROCEDURE uspVerifyLogin'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Correct username and password
-- EXPECTED OUTPUT = 'Successful Login'
SET @EXPECTED = 'Successful Login'
EXEC dbo.uspVerifyLogin
	@username = N'test',
	@password = N'test123',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerfyLogin TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Incorrect username but correct password
-- EXPECTED OUTPUT = 'Incorrect Username/Password'
SET @EXPECTED = 'Incorrect Username/Password'
EXEC dbo.uspVerifyLogin
	@username = N'jason1',
	@password = N'jason123',
	@response = @response OUTPUT

IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerfyLogin TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Incorrect password but correct username
-- EXPECTED OUTPUT = 'Incorrect Username/Password'
SET @EXPECTED = 'Incorrect Username/Password'
EXEC dbo.uspVerifyLogin
	@username = N'hoa',
	@password = N'hoa1234',
	@response = @response OUTPUT

IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerfyLogin TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Incorrect username & password
-- EXPECTED OUTPUT = 'Incorrect Username/Password'
SET @EXPECTED = 'Incorrect Username/Password'
EXEC dbo.uspVerifyLogin
	@username = N'binh123',
	@password = N'binh1234',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerfyLogin TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspVerifyLogin'
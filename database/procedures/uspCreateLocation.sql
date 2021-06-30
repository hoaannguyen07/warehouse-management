USE warehouse_management
GO

-- create a new location in the database (can only create a location within the row-column-level constraints)
--EXEC [dbo].[uspCreateLocation]
--	@row_id nvarchar(1), -- row that this location will be at
--	@column_id int, -- column that this location will be at
--	@level_id int, -- level that this location will be at
--	@auth nvarchar(50), -- username of person who wants to create this palette, which will be used to verify that personnel has the permission to create a new location
--	@response nvarchar(256) = '' OUTPUT -- inputting a response variable is not mandatory

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Invalid row' -> row does not exist in the system
--		2. ERROR: 'Invalid column' -> column does not exist in the system
--		3. ERROR: 'Invalid level' -> level does not exist in the system
--		4. ERROR: 'Location already exists' -> this row-column-level location has already been recorded in the database; there can't be 2 of the same locations
--		5. ERROR: 'Unauthorized to create locations' -> @auth does not have permission to create new locations in the database
--		6. ERROR: ERROR_MESSAGE() -> something went wrong during the INSERT operation of the new location into the database (unforseen error that wasn't checked for beforehand)
--		7. ERROR: 'Error occurred during the INSERT operation' -> something went wrong during the INSERT operation into the locations table but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		0. 'SUCCESS' -> successfully inserted new location into the database


CREATE OR ALTER PROCEDURE [dbo].[uspCreateLocation]
	@row_id nvarchar(1),
	@column_id int,
	@level_id int,
	@auth nvarchar(50),
	@response nvarchar(256) = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- check for valid row-column-level location combo
	IF NOT EXISTS (SELECT 1 FROM dbo.rows WHERE id = @row_id)
	BEGIN
		SET @response = 'Invalid row'
		RETURN (1)
	END
	IF NOT EXISTS (SELECT 1 FROM dbo.columns WHERE id = @column_id)
	BEGIN
		SET @response = 'Invalid column'
		RETURN (2)
	END
	IF NOT EXISTS (SELECT 1 FROM dbo.levels WHERE id = @level_id)
	BEGIN
		SET @response = 'Invalid level'
		RETURN (3)
	END

	-- check if row-column-level combo already exists as a location in the db
	IF EXISTS (SElECT row_id, column_id, level_id FROM dbo.locations WHERE row_id = @row_id AND column_id = @column_id AND level_id = @level_id)
	BEGIN
		SET @response = 'Location already exists'
		RETURN (4)
	END

	-- check authorization
	DECLARE @authorization_response nvarchar(3)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'create',
		@object = 'locations',
		@response = @authorization_response OUTPUT
	-- make sure @auth has the authorization to create locations to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to create locations'
		RETURN (5)
	END

	-- all verifications have been make so starting inserting into the db
	BEGIN TRY
		INSERT INTO dbo.locations(row_id, column_id, level_id, created_by) 
		VALUES (
			@row_id,
			@column_id,
			@level_id,
			(SELECT TOP 1 id FROM dbo.personnel WHERE username = @auth)
		)
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
		RETURN (6)
	END CATCH

	-- check if the location has really been added into the db
	IF NOT EXISTS (
		SELECT 1 FROM dbo.locations
		WHERE row_id = @row_id
		AND column_id = @column_id
		AND level_id = @level_id
		AND created_by = (SELECT id FROM dbo.personnel WHERE username = @auth)
	)
	BEGIN
		SET @response = 'Error occurred during the INSERT operation'
		RETURN (7)
	END

	-- new location exists so return successful
	SET @response = 'SUCCESS'
	RETURN (0)
END


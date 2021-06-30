USE warehouse_management
GO

-- create a new location in the database (can only create a location within the row-column-level constraints)
--EXEC [dbo].[uspCreateLocation]
--	@row_id nvarchar(1), -- row that this location will be at
--	@column_id int, -- column that this location will be at
--	@level_id int, -- level that this location will be at
--	@auth nvarchar(50), -- username of person who wants to create this palette, which will be used to verify that personnel has the permission to create a new location
--	@response nvarchar(256) = '' OUTPUT -- inputting a response variable is not mandatory

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Invalid row' -> row does not exist in the system
--		2. ERROR: 'Invalid column' -> column does not exist in the system
--		3. ERROR: 'Invalid level' -> level does not exist in the system
--		4. ERROR: 'Location already exists' -> this row-column-level location has already been recorded in the database; there can't be 2 of the same locations
--		5. ERROR: 'Unauthorized to create locations' -> @auth does not have permission to create new locations in the database
--		6. ERROR: ERROR_MESSAGE() -> something went wrong during the INSERT operation of the new location into the database (unforseen error that wasn't checked for beforehand)
--		6. 'SUCCESS' -> successfully inserted new location into the database

CREATE OR ALTER PROCEDURE [dbo].[uspCreateLocation]
	@row_id nvarchar(1),
	@column_id int,
	@level_id int,
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @delete_location_response nvarchar(256) = NULL

	-- check for valid row-column-level location combo
	IF EXISTS (SELECT 1 FROM dbo.rows WHERE id = @row_id)
	BEGIN
		IF EXISTS (SELECT 1 FROM dbo.columns WHERE id = @column_id)
		BEGIN
			IF EXISTS (SELECT 1 FROM dbo.levels WHERE id = @level_id)
			BEGIN
				-- check if row-column-level combo already exists as a location in the database
				IF NOT EXISTS (SElECT row_id, column_id, level_id FROM dbo.locations WHERE row_id = @row_id AND column_id = @column_id AND level_id = @level_id)
				BEGIN
					-- check authorization
					DECLARE @authorization_response nvarchar(3)

					EXEC dbo.uspCheckPersonnelPermission
						@username = @auth,
						@action = 'create',
						@object = 'locations',
						@response = @authorization_response OUTPUT

					-- make sure @auth has the authorization to create locations
					IF (@authorization_response = 'YES')
					BEGIN
						BEGIN TRY
							INSERT INTO dbo.locations(row_id, column_id, level_id, created_by) VALUES(
								@row_id,
								@column_id,
								@level_id,
								(SELECT TOP 1 id FROM dbo.personnel WHERE username = @auth)
							)

							-- check if the location has really been added into the db
							IF EXISTS (
								SELECT 1 FROM dbo.locations
								WHERE row_id = @row_id
								AND column_id = @column_id
								AND level_id = @level_id
								AND created_by = (SELECT id FROM dbo.personnel WHERE username = @auth)
							)
							BEGIN
								SET @delete_location_response = 'SUCCESS'
							END
						END TRY
						BEGIN CATCH
							SET @delete_location_response = ERROR_MESSAGE()
						END CATCH -- finish trying to insert into dbo.locations
					END
					ELSE
					BEGIN
						SET @delete_location_response = 'Unauthorized to create locations'
					END -- finish checking for authorization
				END
				ELSE
				BEGIN
					SET @delete_location_response = 'Location already exists'
				END -- finish checking existence of location in db
			END
			ELSE
			BEGIN
				SET @delete_location_response = 'Invalid level'
			END -- finish checking if @level_id exists in db
		END
		ELSE
		BEGIN
			SET @delete_location_response = 'Invalid column'
		END -- finish checking if @column_id exists in db
	END
	ELSE
	BEGIN
		SET @delete_location_response = 'Invalid row'
	END -- finish checking if @row_id exists in db

	SET @response = @delete_location_response
	-- SELECT @response AS response
END

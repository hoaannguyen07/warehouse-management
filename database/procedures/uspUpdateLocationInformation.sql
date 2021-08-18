USE warehouse_management
GO

-- update information on a palette in the db (only people with express permission to update palettes will be able to do it)
-- update ALL information on a palette at the same time (can't update palette id, created_date, and created_by)
--EXEC [dbo].[uspUpdateLocationInformation]
--	@row_id nvarchar(1),
--	@column_id int,
--	@level_id int,
--	@palette_id nvarchar(10), -- palette id at location [@row_id, @column_id, @level_id] will update to be @palette_id
--	@auth nvarchar(50), -- username of person requesting this location update
--	@response nvarchar(256) = NULL OUTPUT


-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Location does not exist' -> Location [@row_id, @column_id, @level_id] does not exist in the db
--		2. ERROR: 'Invalid Palette ID' -> @palette_id DNE in db
--		3. ERROR: 'Unauthorized to update location information' -> @auth does not have the permission to update location information
--		4. ERROR: ERROR_MESSAGE() -> error occurred during the UPDATE operation of that was unaccounted for (but passed all previous checks)
--		5. ERROR: 'Error occurred during the UPDATE operation' -> something went wrong during the UDPATE operation of the palette but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		0. 'SUCCESS' -> successfully updated the information of palette id = @id

CREATE OR ALTER PROCEDURE [dbo].[uspUpdateLocationInformation]
	@row_id nvarchar(1),
	@column_id int,
	@level_id int,
	@palette_id nvarchar(10),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- verify validity of location
	IF NOT EXISTS (SELECT 1 FROM dbo.locations WHERE row_id=@row_id AND column_id=@column_id AND level_id=@level_id)
	BEGIN
		SET @response = 'Location does not exist'
		RETURN (1)
	END

	-- check @palette_id (take into account when @palette_id is NULL)
	IF (@palette_id IS NOT NULL) AND NOT EXISTS(SELECT 1 FROM dbo.palettes WHERE id=@palette_id)
	BEGIN
		SET @response = 'Invalid Palette ID'
		RETURN (2)
	END

	-- check authorization of requester
	DECLARE @authorization_response nvarchar(3)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'update',
		@object = 'locations',
		@response = @authorization_response OUTPUT
	-- must have permission to update locations in order to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to update location information'
		RETURN (3)
	END

	--set up @is_empty to update location with
	DECLARE @is_empty binary(1)
	IF (@palette_id IS NULL)
	BEGIN
		SET @is_empty = 1
	END
	ELSE
	BEGIN
		SET @is_empty = 0
	END

	-- update location since all checks have passed
	BEGIN TRY
		UPDATE dbo.locations
		SET is_empty = @is_empty,
		palette_id = @palette_id,
		last_modified = GETDATE(),
		last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = @auth)
		WHERE row_id=@row_id AND column_id=@column_id AND level_id=@level_id
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
		RETURN (4)
	END CATCH

	-- check if location was able to correctly update
	DECLARE @update_location_verification_response nvarchar(256)
	EXEC dbo.uspVerifyLocationInformation
		@row_id=@row_id,
		@column_id=@column_id,
		@level_id=@level_id,
		@is_empty=@is_empty,
		@palette_id=@palette_id,
		@last_modified_by=@auth,
		@response=@update_location_verification_response OUTPUT
	IF (@update_location_verification_response <> 'SUCCESS')
	BEGIN
		SET @response = 'Error occurred during the UPDATE operation'
		RETURN (5)
	END

	-- location was succesfully updated so return successful
	SET @response = 'SUCCESS'
	RETURN (0)
END
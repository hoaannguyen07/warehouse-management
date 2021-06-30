USE warehouse_management
GO

-- delete a palette from the database 
--EXEC [dbo].[uspDeletePalette]
--	@palette_id nvarchar(10), -- id this new palette will be set as
--	@auth nvarchar(50), -- username of person who wants to create this palette (used to verify that the person actually has permission to create new palettes)
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Palette ID does not exist' -> palette id does not exist in the database; cannot delete a non-existent palette
--		2. ERROR: 'Unauthorized to delete palettes' -> @auth does not have the permission to delete palettes
--		3. ERROR: ERROR_MESSAGE() -> something went wrong during the DELETE operation of the palette from the database (unforseen error that wasn't checked for beforehand)
--		4. ERROR: 'Error occurred during the DELETE operation' -> something went wrong during the DELETE operation from the palettes table but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		4. 'SUCCESS' -> successfully inserted the new palette into database (initialize nullable attributes to null, which could be updated using the "update palette" procedure)


CREATE OR ALTER PROCEDURE [dbo].[uspDeletePalette]
	@palette_id nvarchar(10),
	@auth nvarchar(50),
	@response nvarchar(256) = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- make sure that palette id is in the system (can't delete a nonexistent palette)
	IF NOT EXISTS (SELECT id FROM dbo.palettes WHERE id = @palette_id)
	BEGIN
		SET @response = 'Palette ID does not exist'
		RETURN (1)
	END 


	-- check authorization
	DECLARE @authorization_response nvarchar(3)

	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'delete',
		@object = 'palettes',
		@response = @authorization_response OUTPUT

	-- make sure @auth has the authorization to delete palettes to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to delete palettes'
		RETURN (2)
	END

	-- all verifications have been made so starting deleting from the db
	BEGIN TRY
		DELETE TOP (1) FROM dbo.palettes WHERE id = @palette_id
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
		RETURN (3)
	END CATCH


	-- make sure the palette doesn't exist in the database anymore
	IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @palette_id AND created_by = @auth)
	BEGIN
		-- palette guarenteed to not exist in the db anymore so return successful
		SET @response = 'SUCCESS'
		RETURN (0)
	END
	
	-- able to still find palette in db so something went wrong during the DELETE operation
	SET @response = 'Error occurred during the DELETE operation'
	RETURN (4)
END

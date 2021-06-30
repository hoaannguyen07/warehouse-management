USE warehouse_management
GO

-- delete a palette from the database 
--EXEC [dbo].[uspDeletePalette]
--	@palette_id nvarchar(10), -- id this new palette will be set as
--	@auth nvarchar(50), -- username of person who wants to create this palette (used to verify that the person actually has permission to create new palettes)
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Palette ID does not exist' -> palette id does not exist in the database; cannot delete a non-existent palette
--		2. ERROR: 'Unauthorized to create palettes' -> @auth does not have the permission to create palettes
--		3. ERROR: ERROR_MESSAGE() -> something went wrong during the DELETE operation of the palette from the database (unforseen error that wasn't checked for beforehand)
--		4. 'SUCCESS' -> successfully inserted the new palette into database (initialize nullable attributes to null, which could be updated using the "update palette" procedure)

CREATE OR ALTER PROCEDURE [dbo].[uspDeletePalette]
	@palette_id nvarchar(10),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @create_palette_response nvarchar(256) = NULL

	-- make sure that palette id is in the system
	IF EXISTS (SELECT id FROM dbo.palettes WHERE id = @palette_id)
	BEGIN
		-- check authorization
		DECLARE @authorization_response nvarchar(3)

		EXEC dbo.uspCheckPersonnelPermission
			@username = @auth,
			@action = 'delete',
			@object = 'palettes',
			@response = @authorization_response OUTPUT

		-- make sure @auth has the authorization to delete palettes
		IF (@authorization_response = 'YES')
		BEGIN
			BEGIN TRY
				DELETE TOP (1) FROM dbo.palettes WHERE id = @palette_id

				-- make sure the palette doesn't exist in the database anymore
				IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @palette_id AND created_by = @auth)
					SET @create_palette_response = 'SUCCESS'
				ELSE
				BEGIN
					DECLARE @message nvarchar(256) = NULL
					SET @message = CONCAT('The DELETE operation was unable to remove the palette ', @palette_id, ' from the database')

					RAISERROR(
						@message, -- Message
						16, -- Severity
						1 -- State
					)
				END
			END TRY
			BEGIN CATCH
				SET @create_palette_response = ERROR_MESSAGE()
			END CATCH
		END
		ELSE
		BEGIN
			SET @create_palette_response = 'Unauthorized to delete palettes'
		END
	END
	ELSE
	BEGIN
		SET @create_palette_response = 'Palette ID does not exist'
	END

	SET @response = @create_palette_response
	--SELECT @response AS response
END

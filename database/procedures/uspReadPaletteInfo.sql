USE warehouse_management
GO

--EXEC [dbo].[uspReadPaletteInfo]
--	@palette_id nvarchar(10), -- name of the palette wanted to read
--	@auth nvarchar(50), -- username of person who wants to read this palette (used to verify that the person actually has permission to read palettes)
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Unauthorized to read palettes' -> @auth does not have the permission to read palettes
--		0. 'SUCCESS' -> successfully retrieved information on the palette from the db

CREATE OR ALTER PROCEDURE [dbo].[uspReadPaletteInfo]
	@palette_id nvarchar(10),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- check authorization
	DECLARE @authorization_response nvarchar(3)

	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'read',
		@object = 'palettes',
		@response = @authorization_response OUTPUT

	-- make sure @auth has the authorization to create palettes to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to read palettes'
		RETURN (1)
	END

	-- search for palette information from the db
	SELECT * FROM dbo.palettes WHERE id = @palette_id
	SET @response = 'SUCCESS'
	RETURN (0)

END



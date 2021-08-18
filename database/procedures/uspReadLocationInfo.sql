USE warehouse_management
GO

--EXEC [dbo].[uspReadLocationInfo]
--	@row nvarchar(1),
--	@col int,
--	@level int,
--	@auth nvarchar(50), -- username of person who wants to read this location (used to verify that the person actually has permission to read locations)
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Unauthorized to read locations' -> @auth does not have the permission to read locations
--		0. 'SUCCESS' -> successfully retrieved information on the location from the db

CREATE OR ALTER PROCEDURE [dbo].[uspReadLocationInfo]
	@row nvarchar(1),
	@col int,
	@level int,
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
		@object = 'locations',
		@response = @authorization_response OUTPUT

	-- make sure @auth has the authorization to create locations to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to read locations'
		RETURN (1)
	END

	-- search for location information from the db
	SELECT * FROM dbo.locations WHERE row_id = @row AND column_id = @col AND level_id = @level
	SET @response = 'SUCCESS'
	RETURN (0)

END



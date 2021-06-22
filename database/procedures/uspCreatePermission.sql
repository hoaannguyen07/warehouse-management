USE [warehouse_management]
GO

-- Procedure to insert a permission into the permission table
--EXEC[dbo].[uspDeletePermission]
--	@action nvarchar(10), -- action that this permission will be used to perform
--	@object nvarchar(30), -- object that this permission will affect
--	@auth nvarchar(50), -- username of the person requesting this personnel creation
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S):
--		1.'Invalid permission' -> [@action-@object] combo does not exist in the permissions table
--		2.'Unauthorized to create permission' -> Authorizing username does not have the permission to insert into permission
--		3. ERROR_MESSAGE() -> error occurred during the INSERT operation of the permission
--		3.'SUCCESS' -> Successfully inserted [@action-@object] into the personnel table


CREATE OR ALTER PROCEDURE [dbo].[uspCreatePermission]
	@action nvarchar(10),
	@object nvarchar(30),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @create_permission_response nvarchar(256) = NULL

	IF EXISTS(SELECT dbo.permissions.id FROM dbo.permissions WHERE action=@action AND object=@object)
	BEGIN
		-- check if @auth has the authority to create personnel
		DECLARE @check_permissions_response nvarchar(3)
		EXEC dbo.uspCheckPersonnelPermission
			@username = @auth,
			@action = 'create',
			@object = 'permissions',
			@response = @check_permissions_response OUTPUT

		-- if auth is granted, then go ahead with creating new personnel
		IF (@check_permissions_response = 'YES')
		BEGIN
			BEGIN TRY
				INSERT INTO dbo.permissions (action, object) VALUES (@action, @object)

				-- make sure the new permission is in the permissions table
				IF EXISTS(SELECT dbo.permissions.id FROM dbo.permissions WHERE action=@action AND object=@object)
					SET @create_permission_response = 'SUCCESS'

			END TRY
			BEGIN CATCH
				SET @create_permission_response = ERROR_MESSAGE()
			END CATCH
		END
		ELSE
			SET @create_permission_response = 'Unauthorized to create permission'
	END
	ELSE
		SET @create_permission_response = 'Invalid permission'

	-- return response message
	SET @response = @create_permission_response
	--SELECT @create_permission_response as reponse
END

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
--		2.'Unauthorized to delete personnel' -> Authorizing username does not have the permission to insert into permission
--		3. ERROR_MESSAGE() -> error occurred during the DELETE operation of the permission
--		3.'SUCCESS' -> [@action-@object] combo is no longer in the permissions table. DOES NOT signify that a DELETE operation was made


CREATE OR ALTER PROCEDURE [dbo].[uspDeletePermission]
	@action nvarchar(10),
	@object nvarchar(30),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @delete_permission_response nvarchar(256) = NULL

	IF EXISTS(SELECT dbo.permissions.id FROM dbo.permissions WHERE action=@action AND object=@object)
	BEGIN
		-- check if @auth has the authority to create personnel
		DECLARE @check_permissions_response nvarchar(3)
		EXEC dbo.uspCheckPersonnelPermission
			@username = @auth,
			@action = 'delete',
			@object = 'permission',
			@response = @check_permissions_response OUTPUT

		-- if auth is granted, then go ahead with creating new personnel
		IF (@check_permissions_response = 'YES')
		BEGIN
			BEGIN TRY
				DELETE FROM dbo.permissions WHERE action=@action AND object=@object

				-- make sure the permission has been taken out of the permissions table
				IF NOT EXISTS(SELECT dbo.permissions.id FROM dbo.permissions WHERE action=@action AND object=@object)
					SET @delete_permission_response = 'SUCCESS'
				ELSE
				BEGIN						
					DECLARE @message nvarchar(256) = NULL
					SET @message = CONCAT('The DELETE operation was unable to remove the [', @action, '-', @object, '] permission ')

					RAISERROR(
						@message, -- Message
						16, -- Severity
						1 -- State
					)
				END

			END TRY
			BEGIN CATCH
				SET @delete_permission_response = ERROR_MESSAGE()
			END CATCH
		END
		ELSE
			SET @delete_permission_response = 'Unauthorized to delete permission'
	END
	ELSE
		SET @delete_permission_response = 'Invalid permission'

	-- return response message
	SET @response = @delete_permission_response
	--SELECT @@create_permission_response as reponse
END

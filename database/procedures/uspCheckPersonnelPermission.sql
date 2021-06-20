USE [warehouse_management]
GO

/****** Object:  StoredProcedure [dbo].[uspCheckPermissions]    Script Date: 6/14/2021 11:17:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Checking if a [username] can perform an [action] on an [object/table]
CREATE OR ALTER PROCEDURE [dbo].[uspCheckPersonnelPermission]
	@username NVARCHAR(50), 
	@action NVARCHAR(10), 
	@object NVARCHAR(30),
	@response NVARCHAR(3)='' OUTPUT
AS
BEGIN
	-- create response based on if an entry that relates @user to [@action-@object] exists in the table
	IF EXISTS(SELECT dbo.personnel_permissions.id
				FROM dbo.personnel
				INNER JOIN dbo.personnel_permissions
				ON personnel.id = personnel_permissions.personnel_id
				INNER JOIN dbo.[permissions]
				ON personnel_permissions.permissions_id = [permissions].id
				WHERE personnel.username = @username
				AND [permissions].action = @action
				AND [permissions].object = @object)
		SET @response = 'YES'
	ELSE
		SET @response = 'NO'
END
GO



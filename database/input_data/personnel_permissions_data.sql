USE warehouse_management

DELETE FROM dbo.personnel_permissions

-- give personnel_permissions table permission to test
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel_permissions'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel_permissions'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel_permissions'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel_permissions'))
)


-- give personnel table permission to test
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel'))
)


INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel'))
)


INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'personnel'))
)



-- GIVING THE ABILITY TO CHANGE THE PERMISSIONS TABLE COULD PROVE A CATESTROPHIC MISTAKE
-- B/C IT COULD LEAD TO CHANGING/ERASING PERSONNEL_PERMISSIONS, WHICH IS REALLY BAD
-- give permissions table permission to test
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'permissions'))
)


INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'permissions'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'permissions'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'permissions'))
)


-- give rows table permission to test
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'rows'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'rows'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'rows'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'rows'))
)


-- give columns table permission to test
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'columns'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'columns'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'columns'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'columns'))
)


-- give levels table permission to test
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'levels'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'levels'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'levels'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'levels'))
)


-- give types table permission to test
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'types'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'types'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'types'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'types'))
)


-- give palettes table permission to test
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'palettes'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'palettes'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'palettes'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'palettes'))
)


-- give locations table permission to test
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'locations'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'locations'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'locations'))
)

INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'locations'))
)


SELECT * FROM dbo.personnel_permissions

SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permission_actions.action, dbo.permission_objects.object
FROM dbo.personnel_permissions
INNER JOIN dbo.personnel
ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
INNER JOIN dbo.permissions
ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
INNER JOIN dbo.permission_actions
ON dbo.permissions.action_id = dbo.permission_actions.id
INNER JOIN dbo.permission_objects
ON dbo.permissions.object_id = dbo.permission_objects.id
--WHERE dbo.personnel.username = @username 
--AND dbo.permission_actions.action = @action 
--AND dbo.permission_objects.object = @object

--SELECT COUNT(*)
--FROM dbo.personnel_permissions
--INNER JOIN dbo.personnel
--ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
--INNER JOIN dbo.permissions
--ON dbo.personnel_permissions.permissions_id = dbo.permissions.id


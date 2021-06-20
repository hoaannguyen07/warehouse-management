USE warehouse_management

-- INPUT DATA FOR PERMISSIONS TABLE
-- personnel
INSERT INTO dbo.permissions(action, object) VALUES('create', 'personnel')
INSERT INTO dbo.permissions(action, object) VALUES('read', 'personnel')
INSERT INTO dbo.permissions(action, object) VALUES('update', 'personnel')
INSERT INTO dbo.permissions(action, object) VALUES('delete', 'personnel')

-- permissions
INSERT INTO dbo.permissions(action, object) VALUES('create', 'permissions')
INSERT INTO dbo.permissions(action, object) VALUES('read', 'permissions')
INSERT INTO dbo.permissions(action, object) VALUES('update', 'permissions')
INSERT INTO dbo.permissions(action, object) VALUES('delete', 'permissions')

-- personnel_permissions
INSERT INTO dbo.permissions(action, object) VALUES('create', 'personnel_permissions')
INSERT INTO dbo.permissions(action, object) VALUES('read', 'personnel_permissions')
INSERT INTO dbo.permissions(action, object) VALUES('update', 'personnel_permissions')
INSERT INTO dbo.permissions(action, object) VALUES('delete', 'personnel_permissions')

-- rows
INSERT INTO dbo.permissions(action, object) VALUES('create', 'rows')
INSERT INTO dbo.permissions(action, object) VALUES('read', 'rows')
INSERT INTO dbo.permissions(action, object) VALUES('update', 'rows')
INSERT INTO dbo.permissions(action, object) VALUES('delete', 'rows')

-- columns
INSERT INTO dbo.permissions(action, object) VALUES('create', 'columns')
INSERT INTO dbo.permissions(action, object) VALUES('read', 'columns')
INSERT INTO dbo.permissions(action, object) VALUES('update', 'columns')
INSERT INTO dbo.permissions(action, object) VALUES('delete', 'columns')

-- levels
INSERT INTO dbo.permissions(action, object) VALUES('create', 'levels')
INSERT INTO dbo.permissions(action, object) VALUES('read', 'levels')
INSERT INTO dbo.permissions(action, object) VALUES('update', 'levels')
INSERT INTO dbo.permissions(action, object) VALUES('delete', 'levels')

-- types
INSERT INTO dbo.permissions(action, object) VALUES('create', 'types')
INSERT INTO dbo.permissions(action, object) VALUES('read', 'types')
INSERT INTO dbo.permissions(action, object) VALUES('update', 'types')
INSERT INTO dbo.permissions(action, object) VALUES('delete', 'types')

-- palettes
INSERT INTO dbo.permissions(action, object) VALUES('create', 'palettes')
INSERT INTO dbo.permissions(action, object) VALUES('read', 'palettes')
INSERT INTO dbo.permissions(action, object) VALUES('update', 'palettes')
INSERT INTO dbo.permissions(action, object) VALUES('delete', 'palettes')

-- locations
INSERT INTO dbo.permissions(action, object) VALUES('create', 'locations')
INSERT INTO dbo.permissions(action, object) VALUES('read', 'locations')
INSERT INTO dbo.permissions(action, object) VALUES('update', 'locations')
INSERT INTO dbo.permissions(action, object) VALUES('delete', 'locations')

SELECT * FROM dbo.permissions ORDER BY object ASC

SELECT * FROM dbo.permissions

DELETE FROM dbo.permissions
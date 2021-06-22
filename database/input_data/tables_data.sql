USE warehouse_management

DELETE FROM dbo.tables

INSERT INTO dbo.tables (object) VALUES('personnel')
INSERT INTO dbo.tables (object) VALUES('permissions')
INSERT INTO dbo.tables (object) VALUES('personnel_permissions')
INSERT INTO dbo.tables (object) VALUES('rows')
INSERT INTO dbo.tables (object) VALUES('columns')
INSERT INTO dbo.tables (object) VALUES('levels')
INSERT INTO dbo.tables (object) VALUES('types')
INSERT INTO dbo.tables (object) VALUES('palettes')
INSERT INTO dbo.tables (object) VALUES('locations')

SELECT * FROM dbo.tables
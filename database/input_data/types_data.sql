USE warehouse_management

-- INPUT DATA FOR TYPES TABLE
INSERT INTO dbo.types(name, unit) VALUES('bao', 'kg/bao')
INSERT INTO dbo.types(name, unit) VALUES('phuy', 'kg/phuy')

SELECT * FROM dbo.types

DELETE dbo.types

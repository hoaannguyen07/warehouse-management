USE warehouse_management

-- give personnel_permissions table permission to test
--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='create' AND object='personnel_permissions'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='read' AND object='personnel_permissions'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='update' AND object='personnel_permissions'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='delete' AND object='personnel_permissions'))


---- give personnel table permission to test
--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='create' AND object='personnel'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='read' AND object='personnel'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='update' AND object='personnel'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='delete' AND object='personnel'))


---- GIVING THE ABILITY TO CHANGE THE PERMISSIONS TABLE COULD PROVE A CATESTROPHIC MISTAKE
---- B/C IT COULD LEAD TO CHANGING/ERASING PERSONNEL_PERMISSIONS, WHICH IS REALLY BAD
---- give permissions table permission to test
--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='create' AND object='permissions'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='read' AND object='permissions'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='update' AND object='permissions'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='delete' AND object='permissions'))


---- give rows table permission to test
--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='create' AND object='rows'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='read' AND object='rows'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='update' AND object='rows'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='delete' AND object='rows'))


---- give columns table permission to test
--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='create' AND object='columns'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='read' AND object='columns'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='update' AND object='columns'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='delete' AND object='columns'))


---- give levels table permission to test
--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='create' AND object='levels'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='read' AND object='levels'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='update' AND object='levels'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='delete' AND object='levels'))


---- give types table permission to test
--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='create' AND object='types'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='read' AND object='types'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='update' AND object='types'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='delete' AND object='types'))


---- give palettes table permission to test
--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='create' AND object='palettes'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='read' AND object='palettes'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='update' AND object='palettes'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='delete' AND object='palettes'))


---- give locations table permission to test
--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='create' AND object='locations'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='read' AND object='locations'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='update' AND object='locations'))

--INSERT INTO personnel_permissions(personnel_id, permissions_id) 
--VALUES(
--(SELECT TOP 1 id FROM dbo.personnel WHERE username='test' AND password_hash=HASHBYTES('SHA2_512', N'test123')),
--(SELECT TOP 1 id FROM dbo.permissions WHERE action='delete' AND object='locations'))


--SELECT * FROM dbo.personnel_permissions

SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permissions.action, dbo.permissions.object
FROM dbo.personnel_permissions
INNER JOIN dbo.personnel
ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
INNER JOIN dbo.permissions
ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
--WHERE dbo.personnel.username = N'test' AND dbo.permissions.action = 'updater' AND dbo.permissions.object = 'rows'

--SELECT COUNT(*)
--FROM dbo.personnel_permissions
--INNER JOIN dbo.personnel
--ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
--INNER JOIN dbo.permissions
--ON dbo.personnel_permissions.permissions_id = dbo.permissions.id


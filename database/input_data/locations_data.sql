USE warehouse_management
GO

-- ADD ALL LOCATIONS OF EVERY COMBINATION OF ROW, COL, AND LEVEL FIRST THEN TAKE OUT INVALID LOCATIONS

-- ADD ALL POSSIBLE COMBINATIONS OF ROW, COL, AND LEVEL INTO LOCATIONS TABLE
-- LOOP THROUGH ALL ROWS
DECLARE @num_rows INT
SET @num_rows = (SELECT COUNT(id) FROM dbo.rows)
DECLARE @rows_count INT = 0
DECLARE @rows_at_least NVARCHAR(1) = (SELECT TOP 1 id FROM dbo.rows ORDER BY id ASC)

WHILE(@rows_count < @num_rows)
BEGIN
	-- LOOP THROUGH ALL COLUMN IDs
	DECLARE @num_cols INT
	SET @num_cols = (SELECT COUNT(id) FROM dbo.columns)
	DECLARE @cols_count INT = 0
	DECLARE @cols_at_least INT = (SELECT TOP 1 id FROM dbo.columns ORDER BY id ASC) - 1

	WHILE (@cols_count < @num_cols)
	BEGIN
		SELECT TOP 1 @cols_at_least=id FROM dbo.columns WHERE id > @cols_at_least ORDER BY id ASC

		-- LOOP THROUGH ALL LEVELS
		DECLARE @num_levels INT
		SET @num_levels = (SELECT COUNT(id) FROM dbo.levels)
		DECLARE @levels_count INT = 0
		DECLARE @levels_at_least INT = (SELECT TOP 1 id FROM dbo.columns ORDER BY id ASC) - 1

		WHILE (@levels_count < @num_levels)
		BEGIN
			SELECT TOP 1 @levels_at_least=id FROM dbo.levels WHERE id > @levels_at_least ORDER BY id ASC
			--SELECT @rows_at_least AS row, @cols_at_least AS col, @levels_at_least AS level

			-- USE ALL THE INFORMATION (row_id, col_id, and level_id to create new location
			INSERT INTO dbo.locations(row_id, column_id, level_id, created_by)
			VALUES(
				@rows_at_least,
				@cols_at_least,
				@levels_at_least,
				(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoaannguyen07')
			)

			SET @levels_count = @levels_count + 1
		END
		-- END LOOPING THROUGH ALL LEVELS

		SET @cols_count = @cols_count + 1
	END
	-- END LOOPING THROUGH COLUMNS

	SELECT @rows_at_least as rows_at_least
	SELECT TOP 1 @rows_at_least=id FROM dbo.rows WHERE id > @rows_at_least ORDER BY id ASC
	SET @rows_count = @rows_count + 1

	
END
-- END LOOPING THROUGH ROWS

SELECT * FROM dbo.locations

-- TAKE OUT ALL LOCATIONS THAT ARE INVALID
-- rows H to P only have 10 columns each instead of 12 (all rows and columns have 3 levels
DELETE FROM dbo.locations WHERE row_id >= 'H' AND column_id > 10

SELECT * FROM dbo.locations

SELECT row_id, column_id, level_id FROM dbo.locations WHERE row_id >= 'H' AND column_id > 10

SELECT * FROM dbo.locations WHERE is_empty = 0x1
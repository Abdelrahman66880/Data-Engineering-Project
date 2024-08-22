USE gold_db;
GO

CREATE OR ALTER PROCEDURE CreateSQLServerlessView_Gold @viewname NVARCHAR(100)
AS
BEGIN
    DECLARE @statement NVARCHAR(MAX)

    SET @statement = N'
    CREATE OR ALTER VIEW ' + QUOTENAME(@viewname) + ' AS
    SELECT * 
    FROM OPENROWSET(
        BULK ''https://amfdatalakegen2.dfs.core.windows.net/gold/SalesLT/' + @viewname + '/'' ,
        FORMAT = ''DELTA''
    ) AS [result]'

    EXEC sp_executesql @statement
END
GO

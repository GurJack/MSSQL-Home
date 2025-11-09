
WITH CursTree AS (
    -- якорь рекурсии: корневые элементы (без родител€)
    SELECT 
        *,
        0 AS Level,
        CAST(c.Name AS NVARCHAR(MAX)) AS FullPath
    FROM [dbo].[Curs] c
    WHERE [ParentID] IS NULL
    
    UNION ALL
    
    -- –екурсивна€ часть: дочерние элементы
    SELECT 
        c.*,
        ct.Level + 1 AS Level,
        CAST(ct.FullPath + '\' + iif(trim(isnull(c.NumbCurs,'')) = '', '', trim(c.NumbCurs)+' ')+ c.[Name] AS NVARCHAR(MAX)) AS FullPath
    FROM [dbo].[Curs] c
    INNER JOIN CursTree ct ON c.[ParentID] = ct.[ID]
    
)
SELECT 
    'MKDIR "' + FullPath + '"' AS Command
FROM CursTree c

ORDER BY Level, FullPath;



WITH CursTree AS (
    -- якорь рекурсии: корневые элементы (без родител€)
    SELECT 
        *,
        0 AS Level,
        CAST(c.Name AS NVARCHAR(MAX)) AS FullPath
    FROM [dbo].[Curs] c
    WHERE [ParentID] IS NULL
    
    UNION ALL
    
    -- –екурсивна€ часть: дочерние элементы
    SELECT 
        c.*,
        ct.Level + 1 AS Level,
        CAST(ct.FullPath + '\' + iif(trim(isnull(c.NumbCurs,'')) = '', '', trim(c.NumbCurs)+' ')+ c.[Name] AS NVARCHAR(MAX)) AS FullPath
    FROM [dbo].[Curs] c
    INNER JOIN CursTree ct ON c.[ParentID] = ct.[ID]
    
)
SELECT 
    'MKDIR "' + FullPath+'\'+ replace(case
                            when l.DatePosition = 0 then ''
                            when l.DatePosition = 1 then cast(year(l.DateLection) as varchar)+' ' 
                            when l.DatePosition = 2 then cast(year(l.DateLection) as varchar)+'-'+iif(month(l.DateLection)<=9,'0','')+cast(month(l.DateLection) as varchar)+' '
                            else convert(varchar,l.DateLection,23)+' ' end +iif(l.Numb is not null,cast(l.Numb as varchar)+' ','')+l.Name,'"','''') + '"' AS Command
FROM CursTree c
inner join Lection l on l.CursID = c.ID
ORDER BY Level, FullPath;


WITH CursTree AS (
    -- якорь рекурсии: корневые элементы (без родител€)
    SELECT 
        *,
        0 AS Level,
        CAST(c.Name AS NVARCHAR(MAX)) AS FullPath
    FROM [dbo].[Curs] c
    WHERE [ParentID] IS NULL
    
    UNION ALL
    
    -- –екурсивна€ часть: дочерние элементы
    SELECT 
        c.*,
        ct.Level + 1 AS Level,
        CAST(ct.FullPath + '\' + iif(trim(isnull(c.NumbCurs,'')) = '', '', trim(c.NumbCurs)+' ')+ c.[Name] AS NVARCHAR(MAX)) AS FullPath
    FROM [dbo].[Curs] c
    INNER JOIN CursTree ct ON c.[ParentID] = ct.[ID]
    
)
SELECT 
    'echo ID-Lection "'+cast(l.NewID as varchar(36))+'" >  "' + FullPath+'\'+ replace(case
                            when l.DatePosition = 0 then ''
                            when l.DatePosition = 1 then cast(year(l.DateLection) as varchar)+' ' 
                            when l.DatePosition = 2 then cast(year(l.DateLection) as varchar)+'-'+iif(month(l.DateLection)<=9,'0','')+cast(month(l.DateLection) as varchar)+' '
                            else convert(varchar,l.DateLection,23)+' ' end +iif(l.Numb is not null,cast(l.Numb as varchar)+' ','')+l.Name,'"','''') + 
                             '\info.md"' AS Command
FROM CursTree c
inner join Lection l on l.CursID = c.ID
ORDER BY Level, FullPath;


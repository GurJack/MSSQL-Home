WITH CursTree AS (
    SELECT 
        [ID],
        [ParentID],
        [Name],
        [CompactName],
        _id,
        NumbCurs,
        Memo,
        0 AS Level,
        CAST([Name] AS NVARCHAR(MAX)) AS FullPath,
        CAST([ID] AS VARCHAR(36)) AS IDString
    FROM [dbo].[Curs]
    WHERE [ParentID] IS NULL
    
    UNION ALL
    
    SELECT 
        c.[ID],
        c.[ParentID],
        c.[Name],
        c.[CompactName],
        c._id,
        c.NumbCurs,
        c.Memo,
        ct.Level + 1 AS Level,
        CAST(ct.FullPath + '\\' + c.[Name] AS NVARCHAR(MAX)) AS FullPath,
        CAST(c.[ID] AS VARCHAR(36)) AS IDString
    FROM [dbo].[Curs] c
    INNER JOIN CursTree ct ON c.[ParentID] = ct.[ID]
),
TreeWithChildCount AS (
    SELECT 
        ct.*,
        (SELECT COUNT(*) FROM [dbo].[Curs] child WHERE child.ParentID = ct.ID) AS ChildCount
    FROM CursTree ct
)


insert into KnolageBaseDB.LUBO.hierarchy (_id, _title,_folder_name,_id_parent,_comment)   
SELECT t._id, t.Name, t.CompactName, c._id, t.Memo
FROM TreeWithChildCount t
left join Curs c on t.ParentID = c.ID
where CASE WHEN ChildCount = 0 THEN 1 ELSE 0 END = 0 or Level <= 1
ORDER BY Level, FullPath;

select * from KnolageBaseDB.LUBO.hierarchy

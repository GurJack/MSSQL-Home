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


insert into KnolageBaseDB.LUBO.Courses(_id, _title, _folder_name,_id_hierarchy, _number, _comment)
SELECT t._id, t.Name, t.CompactName, c._id, t.NumbCurs, t.Memo
FROM TreeWithChildCount t
left join Curs c on t.ParentID = c.ID
where CASE WHEN ChildCount = 0 THEN 1 ELSE 0 END = 1 and Level > 1
ORDER BY Level, FullPath;



insert into KnolageBaseDB.LUBO.Courses (_id, _title, _folder_name,_id_hierarchy, _number, _comment)
select distinct h._id, h._title, h._folder_name, h._id_parent, null,h._comment
from Lection l
inner join Curs c on c.ID = l.CursID
inner join KnolageBaseDB.LUBO.hierarchy h on c._id = h._id
LEFT join KnolageBaseDB.LUBO.hierarchy h_child on h._id = h_child._id_parent
where h._id_parent is not null and h_child._id is null


delete h
from Lection l
inner join Curs c on c.ID = l.CursID
inner join KnolageBaseDB.LUBO.hierarchy h on c._id = h._id
where h._id_parent is not null


--declare @id uniqueidentifier = '017951B0-0872-494D-A821-A511AA1CB643'
----insert into KnolageBaseDB.LUBO.Courses (_id, _title, _folder_name,_id_hierarchy, _number, _comment)
--select distinct @id, h._title,h._folder_name, h._id, null,h._comment
--from Lection l
--inner join Curs c on c.ID = l.CursID
--inner join KnolageBaseDB.LUBO.hierarchy h on c._id = h._id


--017951B0-0872-494D-A821-A511AA1CB643

select * from KnolageBaseDB.LUBO.Courses









--Нажно сделать проверку на дубликаты
--Проверку на нудевые файлы
--исключения desktop.ini


  SELECT cr.ID, cr._new_rec, cr.Numb, cr.Place, cr.PlaceName, cr._file_size, cr._on_delete, 
  ROW_NUMBER() OVER(PARTITION BY f._file_hash, f._file_size ORDER BY cr._new_rec, 
  CASE WHEN cr.Place LIKE '%\Картинки к лекциям1\%' THEN 3 WHEN cr.Place LIKE '%\Картинки к лекциям\%' THEN 2 ELSE 1 END) _number
  FROM [LUBO].[dbo].[Carrier] cr
  INNER JOIN
  (SELECT _file_hash, _file_size
  FROM [LUBO].[dbo].[Carrier] 
  WHERE TRIM(ISNULL(Place,'')) <> '' AND _on_delete = 0 AND _is_archive = 0
  GROUP BY _file_hash, _file_size
  HAVING COUNT(*) > 1) f ON f._file_hash = cr._file_hash AND f._file_size = cr._file_size
  WHERE cr._on_delete = 0 AND _is_archive = 0
  ORDER BY cr._file_size, cr._file_hash, cr.Place

	--delete FROM [LUBO].[dbo].[Carrier] WHERE PlaceName LIKE 'metadata.frdat%'
	--UPDATE [LUBO].[dbo].[Carrier] SET _is_archive = 1 WHERE id IN (181547)

	



  --delete from d 
  --FROM [LUBO].[dbo].[Carrier] cr
  --inner join [dbo].[Dublicates] d on d._id_original = cr.ID
  --inner join
  --(SELECT _file_hash, _file_size
  --FROM [LUBO].[dbo].[Carrier] where trim(isnull(Place,'')) <> ''
  --group by _file_hash, _file_size
  --having count(*) > 1) f on f._file_hash = cr._file_hash and f._file_size = cr._file_size
  --where d._id_duplicate in (0) and cr.PlaceName like '%.md'



  --update cr set cr._on_delete = 1
  --FROM [LUBO].[dbo].[Carrier] cr
  --inner join [dbo].[Dublicates] d on d._id_original = cr.ID
  --inner join
  --(SELECT _file_hash, _file_size
  --FROM [LUBO].[dbo].[Carrier] where trim(isnull(Place,'')) <> ''
  --group by _file_hash, _file_size
  --having count(*) > 1) f on f._file_hash = cr._file_hash and f._file_size = cr._file_size
  --where cr._on_delete = 0 
  --and d._id_duplicate in (0) 

  --update cr set cr._on_delete = 1 from
  --(SELECT cr.ID, cr._new_rec, cr.Numb, cr.Place, cr.PlaceName, cr._file_size, d._id_duplicate, cr._on_delete, 
  --ROW_NUMBER() over(partition by d._id_duplicate order by cr._new_rec, case when cr.Place like '%\Картинки к лекциям1\%' then 3 when cr.Place like '%\Картинки к лекциям\%' then 2 else 1 end) _number
  --FROM [LUBO].[dbo].[Carrier] cr
  --inner join [dbo].[Dublicates] d on d._id_original = cr.ID
  --inner join
  --(SELECT _file_hash, _file_size
  --FROM [LUBO].[dbo].[Carrier] where trim(isnull(Place,'')) <> '' and _on_delete = 0
  --group by _file_hash, _file_size
  --having count(*) > 1) f on f._file_hash = cr._file_hash and f._file_size = cr._file_size
  --where cr._on_delete = 0) res
  --inner join [LUBO].[dbo].[Carrier] cr on cr.ID = res.ID
  --where cr._new_rec = 1 and _number > 1

  --update [dbo].[Carrier] set _on_delete = 1
  --where id = 191641
  
  
  --Файлы, которые есть в архиве, но нет в рабочей базе
  select * from [dbo].[Carrier]  arc
  left join [dbo].[Carrier]  work on work._is_archive = 0 and work._file_hash = arc._file_hash and work._file_size = arc._file_size
  where arc._is_archive = 1 and work.PlaceName is null
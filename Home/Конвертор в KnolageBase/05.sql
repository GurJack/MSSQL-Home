declare @id uniqueidentifier = '24D4DBAE-C6E1-487D-A80E-F9E1C712B666'
insert [KnolageBaseDB].LUBO.[StorageLocations] (_id, _title, _id_parent, _id_type)
values 
(@id, 'Дом №9', NULL, '379D8149-4119-43FB-902F-E04C6E4991C5'),
('E7B7098A-6F55-4BFE-9B75-7F059295E02B', 'Main Сервер',  '24D4DBAE-C6E1-487D-A80E-F9E1C712B666','85D8D0E4-3AED-45CE-9534-C54550F5926E'),
('878CD0B6-FC05-4A8C-80F4-1C5BC1FA5406', 'Backup LUBO1', '24D4DBAE-C6E1-487D-A80E-F9E1C712B666','C2548F6D-85E8-4868-94D3-C35F464E2D3D'),
('975AE0D4-C555-43B1-B114-826CE34A1A4E', 'Backup LUBO2', '24D4DBAE-C6E1-487D-A80E-F9E1C712B666','C2548F6D-85E8-4868-94D3-C35F464E2D3D'),
('7C1CD2DF-4B28-4BF8-B26E-4596551CCDB2', 'Backup LUBO3', '24D4DBAE-C6E1-487D-A80E-F9E1C712B666','C2548F6D-85E8-4868-94D3-C35F464E2D3D')


--('4D6BD744-8057-44F0-AC4F-242132EFE87A','PlaceType','Аудио кассета','AdioCassete'),
--('94EDA8AE-0BCC-4188-BE49-46A74F9B6BBA','PlaceType','Бумажный документ','Paper'),
--('AB326E8A-8538-4084-BBA8-85ECF69E409F','PlaceType','Коробка','Box'),
--('FD12DA58-B029-4385-889B-C1F7134359B8','PlaceType','Комната','Room'),
--('379D8149-4119-43FB-902F-E04C6E4991C5','PlaceType','Дом','House'),
--('FCC7AC39-22B2-4CE3-948D-F6EA448A3CC8','PlaceType','Видео кассета','VideoCassete')
--('C2548F6D-85E8-4868-94D3-C35F464E2D3D','PlaceType','Жесткий диск','HDD'),
--('85D8D0E4-3AED-45CE-9534-C54550F5926E','PlaceType','Сервер','Server')

INSERT INTO KnolageBaseDB.[LUBO].StorageLocations
(
    _id,
    _title,
    _id_parent,
    _id_type,
    _comment,
    _sticker
)
SELECT NEWID(),c.Numb+CAST(c.NumbID AS VARCHAR(10)),'24D4DBAE-C6E1-487D-A80E-F9E1C712B666',	'4D6BD744-8057-44F0-AC4F-242132EFE87A',
c.Memo,c.Alfa
FROM [dbo].[Carrier] c 
WHERE TRIM(ISNULL(PlaceName,'')) = '' AND c.Numb LIKE 'ак%'

INSERT INTO KnolageBaseDB.[LUBO].StorageLocations
(
    _id,
    _title,
    _id_parent,
    _id_type,
    _comment,
    _sticker
)
select NEWID(),c.Numb+CAST(ISNULL(c.NumbID,0) AS VARCHAR(10)),'24D4DBAE-C6E1-487D-A80E-F9E1C712B666',	'FCC7AC39-22B2-4CE3-948D-F6EA448A3CC8',
c.Memo,c.Alfa
FROM [dbo].[Carrier] c 
where trim(isnull(PlaceName,'')) = '' AND c.Numb LIKE 'вк%'


--5B024009-FA5B-4B62-BE63-15F8DD3BCDA5	SourceType	Оцифрованная картинка	DigitalImage
--98889B77-0136-475F-94E8-5D34BEA084C9	SourceType	Видео кассета	PhysicalVideoTape
--375C1B78-53D6-454A-AEC4-821AAB1ED277	SourceType	Рукописных текст	PhysicalHandwritten
--73F9CD6A-5D23-4782-A692-9B9604C82C58	SourceType	Оцифрованное видео	DigitalVideo
--921AE0D1-9E59-4749-B278-A39BA6972F21	SourceType	Оцифрованный текст	DigitalText
--2C07676C-4CB6-4855-9D2B-BBBC3BAEA901	SourceType	Оцифрованное аудио	DigitalAudio
--6C2E4ED8-F7E5-4A2A-B88E-D0E796E7E3B1	SourceType	Печатный текст	PhysicalPrinted
--B6ADC358-749B-4BDF-BB38-EB1A5AE6F790	SourceType	Аудио кассета	PhysicalAudioTape

INSERT INTO KnolageBaseDB.[LUBO].Sources
(
    _id,
    _title,
    _prefix,
    _number,
    _id_source_type,
    _id_child,
    _id_quality,
    _id_original_location,
    _id_digital_location,
    _creation_date,
    _comment,
    _id_document
)

SELECT NEWID(), sl._title, c.Numb, c.NumbID, IIF(sl._id_type = 'FCC7AC39-22B2-4CE3-948D-F6EA448A3CC8', '73F9CD6A-5D23-4782-A692-9B9604C82C58','2C07676C-4CB6-4855-9D2B-BBBC3BAEA901')	
    ,NULL,NULL,sl._id, NULL,GETDATE(),c.Memo, NULL
FROM [dbo].[Carrier] c 
INNER JOIN KnolageBaseDB.[LUBO].StorageLocations sl ON c.Numb+CAST(ISNULL(c.NumbID,0) AS VARCHAR(10)) = sl._title
where trim(isnull(PlaceName,'')) = ''


select 'Не забыть!', c._file_size, c._file_hash, c.Place, c.PlaceName, NULL, 0	
,NULL, 0,c.Memo
FROM [dbo].[Carrier] c 
where trim(isnull(PlaceName,'')) <> ''  AND c._file_hash IS NULL



INSERT INTO KnolageBaseDB.[LUBO].[FileLocations]
(
    [_id],
    [_file_size],
    [_file_hash],
    [_file_path],
    [_file_name],
    [_id_original],
    [_is_source],
    [_digitization_date],
    [_file_state],
    [_comment]
)

select NEWID(), c._file_size, c._file_hash, c.Place, c.PlaceName, NULL, 0	
,NULL, 0,c.Memo
FROM [dbo].[Carrier] c 
where trim(isnull(PlaceName,'')) <> '' AND c._is_archive = 0 AND c._file_hash IS NOT NULL

---------------------------------------

INSERT INTO KnolageBaseDB.[LUBO].[FileLocations]
(
    [_id],
    [_file_size],
    [_file_hash],
    [_file_path],
    [_file_name],
    [_id_original],
    [_is_source],
    [_digitization_date],
    [_file_state],
    [_comment]
)

select NEWID(), c._file_size, c._file_hash, REPLACE(c.Place,'e:\','v:\Эзотерика\'), c.PlaceName, NULL, 0	
,NULL, 0,c.Memo
FROM [dbo].[Carrier] c 
left JOIN KnolageBaseDB.[LUBO].[FileLocations] m ON m._file_hash = c._file_hash AND m._file_size = c._file_size
                                                            AND m._id_original IS NULL
where trim(isnull(PlaceName,'')) <> '' AND c._is_archive = 1 AND m._id IS NULL AND c._file_size > 0



INSERT INTO KnolageBaseDB.[LUBO].[FileLocations]
(
    [_id],
    [_file_size],
    [_file_hash],
    [_file_path],
    [_file_name],
    [_id_original],
    [_is_source],
    [_digitization_date],
    [_file_state],
    [_comment]
)

select NEWID(), c._file_size, c._file_hash, c.Place, c.PlaceName, m._id, 0	
,NULL, 0,c.Memo
FROM [dbo].[Carrier] c 
INNER JOIN KnolageBaseDB.[LUBO].[FileLocations] m ON m._file_hash = c._file_hash AND m._file_size = c._file_size
                                                            AND m._id_original IS NULL
where trim(isnull(PlaceName,'')) <> '' AND c._is_archive = 1





select c.ID,c.Place,c.PlaceName,c._archive_name
FROM [dbo].[Carrier] c 
left JOIN KnolageBaseDB.[LUBO].[FileLocations] m ON m._file_hash = c._file_hash AND m._file_size = c._file_size
                                                            AND m._id_original IS NULL
where trim(isnull(PlaceName,'')) <> '' AND c._is_archive = 1 AND m._id IS NULL AND c._file_size > 0
ORDER BY c._archive_name, c.Place





('E7B7098A-6F55-4BFE-9B75-7F059295E02B', 'Main Сервер',  '24D4DBAE-C6E1-487D-A80E-F9E1C712B666','85D8D0E4-3AED-45CE-9534-C54550F5926E'),
('878CD0B6-FC05-4A8C-80F4-1C5BC1FA5406', 'Backup LUBO1', '24D4DBAE-C6E1-487D-A80E-F9E1C712B666','C2548F6D-85E8-4868-94D3-C35F464E2D3D'),
('975AE0D4-C555-43B1-B114-826CE34A1A4E', 'Backup LUBO2', '24D4DBAE-C6E1-487D-A80E-F9E1C712B666','C2548F6D-85E8-4868-94D3-C35F464E2D3D'),
('7C1CD2DF-4B28-4BF8-B26E-4596551CCDB2', 'Backup LUBO3', '24D4DBAE-C6E1-487D-A80E-F9E1C712B666','C2548F6D-85E8-4868-94D3-C35F464E2D3D')



INSERT INTO KnolageBaseDB.[LUBO].Sources
(
    _id,
    _title,
    _prefix,
    _number,
    _id_source_type,
    _id_child,
    _id_quality,
    _id_original_location,
    _id_digital_location,
    _creation_date,
    _comment,
    _id_document
)

select NEWID(), c._file_size, c._file_hash, c.Place, c.PlaceName, NULL, 0	
,NULL, 0,c.Memo
FROM [dbo].[Carrier] c 
INNER JOIN KnolageBaseDB.[LUBO].[FileLocations] fl ON c.Place = fl._file_path AND c.PlaceName = fl._file_name
where trim(isnull(PlaceName,'')) <> '' AND c._is_archive = 0




SELECT * FROM [KnolageBaseDB].[LUBO].[Sources]
SELECT * FROM [KnolageBaseDB].[LUBO].StorageLocations

SELECT * FROM [KnolageBaseDB].[LUBO].LectionReferences WHERE _object_name = 'SourceType'


--SELECT *
--  FROM [LUBO].[dbo].[Carrier] ca
--  left join [dbo].[DocumentPosition] i on i.CarrierID = ca.ID
--  order by ca.ID
  
--  select cd.ID, cd.Name, cd.Comp, ct.Name _type, ct.ID _id_carrier_type from [dbo].[CarrierDict] cd
--  inner join [dbo].[CarrierType] ct on cd.TypeID = ct.ID

--  select * from [dbo].[Document] d
--  inner join (select cd.ID, cd.Name, cd.Comp, ct.Name _type, ct.ID _id_carrier_type from [dbo].[CarrierDict] cd
--  inner join [dbo].[CarrierType] ct on cd.TypeID = ct.ID) carr on carr.ID = d.DataTypeID


--  select * from [dbo].[CarrierTypeExt]

--update [LUBO].[dbo].[Carrier] set _file_size = 2 where ID = 301904
  

  --update [LUBO].[dbo].[Carrier]
  --set PlaceName = '07-2 ак319 Часть 1 v1 (d312558c322088).flac', _file_size = 1
  --where ID = 111511

  --SELECT *
  --FROM [LUBO].[dbo].[Carrier] where Place like 'E:\Эзотерика\Знание ЛЮБО\%' 
  --order by Place

  

  
  
insert INTO KnolageBaseDB.[LUBO].[LectionReferences] (_id ,_object_name, _name, _code)
VALUES
('921AE0D1-9E59-4749-B278-A39BA6972F21','SourceType','Оцифрованный текст','DigitalText'),
('2C07676C-4CB6-4855-9D2B-BBBC3BAEA901','SourceType','Оцифрованное аудио','DigitalAudio'),
('73F9CD6A-5D23-4782-A692-9B9604C82C58','SourceType','Оцифрованное видео','DigitalVideo'),
('5B024009-FA5B-4B62-BE63-15F8DD3BCDA5','SourceType','Оцифрованная картинка','DigitalImage'),
('6C2E4ED8-F7E5-4A2A-B88E-D0E796E7E3B1','SourceType','Печатный текст','PhysicalPrinted'),
('375C1B78-53D6-454A-AEC4-821AAB1ED277','SourceType','Рукописных текст','PhysicalHandwritten'),
('B6ADC358-749B-4BDF-BB38-EB1A5AE6F790','SourceType','Аудио кассета','PhysicalAudioTape'),
('98889B77-0136-475F-94E8-5D34BEA084C9','SourceType','Видео кассета','PhysicalVideoTape')


--SELECT * FROM KnolageBaseDB.[LUBO].[LectionReferences] WHERE _object_name = 'SourceType'

INSERT INTO KnolageBaseDB.[LUBO].[LectionReferences] (_object_name, _name, _code)
VALUES
('ContentType','Text','Text'),
('ContentType','Audio','Audio')


INSERT INTO KnolageBaseDB.[LUBO].[LectionReferences] (_id, _object_name, _name, _code)
VALUES
('4D6BD744-8057-44F0-AC4F-242132EFE87A','PlaceType','Аудио кассета','AdioCassete'),
('94EDA8AE-0BCC-4188-BE49-46A74F9B6BBA','PlaceType','Бумажный документ','Paper'),
('AB326E8A-8538-4084-BBA8-85ECF69E409F','PlaceType','Коробка','Box'),
('FD12DA58-B029-4385-889B-C1F7134359B8','PlaceType','Комната','Room'),
('379D8149-4119-43FB-902F-E04C6E4991C5','PlaceType','Дом','House'),
('FCC7AC39-22B2-4CE3-948D-F6EA448A3CC8','PlaceType','Видео кассета','VideoCassete'),
('C2548F6D-85E8-4868-94D3-C35F464E2D3D','PlaceType','Жесткий диск','HDD'),
('85D8D0E4-3AED-45CE-9534-C54550F5926E','PlaceType','Сервер','Server')






INSERT INTO KnolageBaseDB.[LUBO].[LectionReferences] (_id,_object_name, _name, _code)
VALUES
('604C8AE3-2D37-4054-BA51-0872823023B6','HierarchyType','Lecture','Lecture'),
('9AD5A82C-81F8-4D02-9BA3-CB95A2039AD9','HierarchyType','Law','Law')


INSERT INTO KnolageBaseDB.[LUBO].[LectionReferences] (_object_name, _name, _code, _int_value)
  SELECT 'RecordQuality', [Name],[Name], [ID]
  FROM [LUBO].[dbo].[RecordQualityType]

--insert into KnolageBaseDB.[LUBO].[LectionReferences] 
--SELECT 'Extension', [Ext]
--  FROM [LUBO].[dbo].[CarrierTypeExt]


--  SELECT TOP (1000) [ID]
--      ,[Name]
--  FROM [LUBO].[dbo].[CarrierType]




--  SELECT TOP (1000) [ID]
--      ,[TypeID]
--      ,[Name]
--      ,[Comp]
--  FROM [LUBO].[dbo].[CarrierDict]


select * from KnolageBaseDB.[LUBO].[LectionReferences]

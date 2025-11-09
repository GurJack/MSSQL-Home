select * from  [dbo].[Carrier] where Place like 'e:%' or (_file_size = 0 and PlaceName like '%.txt')
order by PlaceName


select * from  [dbo].[Carrier] where PlaceName like '%DIG573%'

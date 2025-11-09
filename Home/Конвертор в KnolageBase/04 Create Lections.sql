INSERT INTO KnolageBaseDB.LUBO.Lectures(_id, _title,_folder_name,_id_course, _date,_date_position,_number,_comment)
SELECT [NewID], l.Name,NULL, c._id, l.DateLection,l.DatePosition, l.Numb, l.Memo FROM Lection l
INNER JOIN Curs c ON c.ID = l.CursID

SELECT * FROM KnolageBaseDB.LUBO.Lectures



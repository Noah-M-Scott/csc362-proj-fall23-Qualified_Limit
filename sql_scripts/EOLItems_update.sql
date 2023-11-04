DELIMITER //

CREATE PROCEDURE eolitemsInsert(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

UPDATE BaseEOLItems
   SET catalogId = catalogIdIn, 
       dateDiscontinued = dateDiscontinuedIn, 
WHERE catalogId = catalogIdIn, dateDiscontinued = dateDiscontinuedIn;

END;
//

DELIMITER ;

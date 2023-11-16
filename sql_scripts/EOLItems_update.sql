DELIMITER //

CREATE PROCEDURE eolitemsUpdate(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

UPDATE BaseEOLItems
   SET catalogId = catalogIdIn, 
       dateDiscontinued = dateDiscontinuedIn
WHERE catalogId = catalogIdIn AND dateDiscontinued = dateDiscontinuedIn;

END;
//

DELIMITER ;

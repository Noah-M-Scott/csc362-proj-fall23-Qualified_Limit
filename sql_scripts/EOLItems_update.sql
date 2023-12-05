DELIMITER //

CREATE PROCEDURE eolitemsUpdate(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

UPDATE BaseEOLItems
   SET catalog_catalogId = catalogIdIn, 
       EOL_dateDiscontinued = dateDiscontinuedIn
WHERE catalog_catalogId = catalogIdIn AND EOL_dateDiscontinued = dateDiscontinuedIn;

END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE eolitemsUpdate(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

 -- update a eol

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseEOLItems
   SET catalog_catalogId = catalogIdIn, 
       EOL_dateDiscontinued = dateDiscontinuedIn
WHERE catalog_catalogId = catalogIdIn AND EOL_dateDiscontinued = dateDiscontinuedIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;

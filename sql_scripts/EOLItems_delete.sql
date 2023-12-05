DELIMITER  //

CREATE PROCEDURE eolitemsDelete(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

UPDATE BaseEOLItems
   SET deleted = TRUE
 WHERE catalog_catalogId = catalogIdIn AND EOL_dateDiscontinued = dateDiscontinuedIn;


END;
//

DELIMITER ;

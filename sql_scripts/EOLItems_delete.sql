DELIMITER  //

CREATE PROCEDURE eolitemsDelete(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

UPDATE BaseEOLItems
   SET deleted = TRUE
 WHERE catalogId = catalogIdIn, dateDiscontinued = dateDiscontinuedIn;


END;
//

DELIMTER ;

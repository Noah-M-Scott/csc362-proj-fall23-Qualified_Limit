DELIMITER  //

CREATE PROCEDURE eolitemsDelete(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

UPDATE BaseEOLItems
   SET deleted = TRUE
 WHERE catalogId = catalogIdIn AND dateDiscontinued = dateDiscontinuedIn;


END;
//

DELIMITER ;

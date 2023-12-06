DELIMITER  //

CREATE PROCEDURE eolitemsDelete(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

 -- deny deletion eolitems

SET FOREIGN_KEY_CHECKS=0;
UPDATE BaseEOLItems
   SET deleted = TRUE
 WHERE catalog_catalogId = catalogIdIn AND EOL_dateDiscontinued = dateDiscontinuedIn;
SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;

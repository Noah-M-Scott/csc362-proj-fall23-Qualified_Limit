DELIMITER //

CREATE PROCEDURE eolitemsInsert(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

SET FOREIGN_KEY_CHECKS=0;

INSERT INTO BaseEOLItems (
       catalog_catalogId, 
       EOL_dateDiscontinued)
VALUES (catalogIdIn,
       dateDiscontinuedIn);

SET FOREIGN_KEY_CHECKS=1;

END;
//
DELIMITER ;

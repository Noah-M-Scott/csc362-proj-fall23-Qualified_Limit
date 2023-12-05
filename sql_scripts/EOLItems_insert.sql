DELIMITER //

CREATE PROCEDURE eolitemsInsert(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

INSERT INTO BaseEOLItems (
       catalog_catalogId, 
       EOL_dateDiscontinued)
VALUES (catalogIdIn,
       dateDiscontinuedIn);

END;
//
DELIMITER ;

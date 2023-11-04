DELIMITER //

CREATE PROCEDURE eolitemsInsert(catalogIdIn INT, dateDiscontinuedIn DATE)
BEGIN

INSERT INTO BaseEOLItems (
       catalogId, 
       dateDiscontinued)
VALUES (catalogIdIn,
       dateDiscontinuedIn);

END;
//
DELIMITER ;

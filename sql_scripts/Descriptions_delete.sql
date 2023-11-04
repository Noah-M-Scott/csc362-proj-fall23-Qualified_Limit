DELIMITER  //

CREATE PROCEDURE descriptionDelete(catalogIdIn INT)
BEGIN

UPDATE BaseDescription
   SET deleted = TRUE
 WHERE catalogId = catalogIdIn;


END;
//

DELIMTER ;

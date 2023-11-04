DELIMITER  //

CREATE PROCEDURE descriptionDelete(catalogIdIn INT)
BEGIN

UPDATE baseDescription
   SET deleted = TRUE
 WHERE catalogId = catalogIdIn;


END;
//

DELIMTER ;
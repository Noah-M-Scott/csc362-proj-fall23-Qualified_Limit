DELIMITER  //

CREATE PROCEDURE catalogDelete(catalogIdIn INT)
BEGIN

UPDATE BaseCatalog
   SET deleted = TRUE
 WHERE catalogId = accountIdIn;


END;
//

DELIMTER ;
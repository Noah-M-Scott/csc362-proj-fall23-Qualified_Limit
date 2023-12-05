DELIMITER  //

CREATE PROCEDURE catalogDelete(catalogIdIn INT)
BEGIN

UPDATE BaseCatalog
   SET deleted = TRUE
 WHERE catalog_catalogId = catalogIdIn;


END;
//

DELIMITER ;
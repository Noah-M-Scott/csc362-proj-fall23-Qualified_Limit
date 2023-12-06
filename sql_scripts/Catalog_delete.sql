DELIMITER  //

CREATE PROCEDURE catalogDelete(catalogIdIn INT)
BEGIN

   SET FOREIGN_KEY_CHECKS=0;
UPDATE BaseCatalog
   SET deleted = TRUE
 WHERE catalog_catalogId = catalogIdIn;
   SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
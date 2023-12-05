DELIMITER  //

CREATE PROCEDURE warrantyDelete(warrantyIdIn INT)
BEGIN

UPDATE BaseWarranties
   SET deleted = TRUE
 WHERE warranty_warrantyId = warrantyIdIn;


END;
//

DELIMITER ;
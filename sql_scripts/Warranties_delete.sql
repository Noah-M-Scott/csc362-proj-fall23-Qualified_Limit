DELIMITER  //

CREATE PROCEDURE warrantyDelete(warrantyIdIn INT)
BEGIN

UPDATE BaseWarranties
   SET deleted = TRUE
 WHERE warrantyId = warrantyIdIn;


END;
//

DELIMTER ;
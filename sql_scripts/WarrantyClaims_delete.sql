DELIMITER //

CREATE PROCEDURE warrantyClaimDelete(warrantyIdIn INT)
BEGIN


UPDATE BaseWarrantyClaims
   SET deleted = TRUE
 WHERE warranty_warrantyId = warrantyIdIn;

END;
//

DELIMITER ;
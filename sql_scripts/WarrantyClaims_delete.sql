DELIMITER //

CREATE PROCEDURE warrantyClaimDelete(warrantyIdIn INT)
BEGIN

SET FOREIGN_KEY_CHECKS=0;

 -- deny delete claim

UPDATE BaseWarrantyClaims
   SET deleted = TRUE
 WHERE warranty_warrantyId = warrantyIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
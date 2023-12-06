DELIMITER  //

CREATE PROCEDURE warrantyDelete(warrantyIdIn INT)
BEGIN

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseWarranties
   SET deleted = TRUE
 WHERE warranty_warrantyId = warrantyIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;

DELIMITER  //

CREATE PROCEDURE warrantyDeleteByTransaction(transactionIdIn INT)
BEGIN

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseWarranties
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
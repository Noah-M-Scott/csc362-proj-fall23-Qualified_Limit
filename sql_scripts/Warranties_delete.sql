DELIMITER  //

CREATE PROCEDURE warrantyDelete(warrantyIdIn INT)
BEGIN

 -- deny delete a warranty

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

 -- delete the warranties linked to a transaction

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseWarranties
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
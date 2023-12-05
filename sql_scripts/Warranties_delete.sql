DELIMITER  //

CREATE PROCEDURE warrantyDelete(warrantyIdIn INT)
BEGIN

UPDATE BaseWarranties
   SET deleted = TRUE
 WHERE warranty_warrantyId = warrantyIdIn;


END;
//

DELIMITER ;

DELIMITER  //

CREATE PROCEDURE warrantyDeleteByTransaction(transactionIdIn INT)
BEGIN

UPDATE BaseWarranties
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;


END;
//

DELIMITER ;
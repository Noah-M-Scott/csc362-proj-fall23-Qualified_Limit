DELIMITER //

CREATE PROCEDURE transactionDelete(transactionIdIn INT)
BEGIN

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseTransactions
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;

SELECT warranty_warrantyId INTO @x FROM Warranties
 WHERE transaction_transactionId = transactionIdIn;
  CALL warrantyDelete(@x);
  CALL warrantyClaimDelete(@x);

  CALL returnsDelete(transactionIdIn);
  CALL shippingDataDeleteAll(transactionIdIn);

SELECT financialDatum_financialId INTO @x FROM FinancialData
 WHERE transaction_transactionId = transactionIdIn;
  CALL financialDataDelete(@x);

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
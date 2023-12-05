DELIMITER //

CREATE PROCEDURE transactionDelete(transactionIdIn INT)
BEGIN


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

END;
//

DELIMITER ;
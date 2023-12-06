DELIMITER //

CREATE PROCEDURE transactionUpdate(transactionIdIn INT, finished BOOLEAN, onHold BOOLEAN, payed DECIMAL(6,2))
BEGIN

SET FOREIGN_KEY_CHECKS=0;

SELECT transaction_currentAmountPaid
  INTO @amountPaid 
  FROM Transactions 
 WHERE transaction_transactionId = transactionIdIn 
 LIMIT 1;

SELECT transaction_currentAmountOwed
  INTO @amountOwed
  FROM Transactions 
 WHERE transaction_transactionId = transactionIdIn 
 LIMIT 1;

SET @amountPaid = @amountPaid + payed;
SET @amountOwed = @amountOwed - payed;

UPDATE BaseTransactions
   SET transaction_transactionCompleteBool = finished,
       transaction_onHold = onHold,
       transaction_currentAmountPaid = @amountPaid,
       transaction_currentAmountOwed = @amountOwed
 WHERE transaction_transactionId = transactionIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;


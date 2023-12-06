DELIMITER //

CREATE PROCEDURE transactionUpdate(transactionIdIn INT, finished BOOLEAN, onHold BOOLEAN, payed DECIMAL(6,2))
BEGIN
START TRANSACTION;

 -- this is dealing with finacial data, so transaction

SET FOREIGN_KEY_CHECKS=0;

 -- amount paid to the transaction
SELECT transaction_currentAmountPaid
  INTO @amountPaid 
  FROM Transactions 
 WHERE transaction_transactionId = transactionIdIn 
 LIMIT 1;

 -- how much is owed
SELECT transaction_currentAmountOwed
  INTO @amountOwed
  FROM Transactions 
 WHERE transaction_transactionId = transactionIdIn 
 LIMIT 1;

 -- update counters
SET @amountPaid = @amountPaid + payed;
SET @amountOwed = @amountOwed - payed;

 -- update other sections
UPDATE BaseTransactions
   SET transaction_transactionCompleteBool = finished,
       transaction_onHold = onHold,
       transaction_currentAmountPaid = @amountPaid,
       transaction_currentAmountOwed = @amountOwed
 WHERE transaction_transactionId = transactionIdIn;

SET FOREIGN_KEY_CHECKS=1;

COMMIT;
END;
//

DELIMITER ;


DELIMITER //

CREATE PROCEDURE transactionUpdate(transactionIdIn INT, finished BOOLEAN, onHold BOOLEAN)
BEGIN

UPDATE BaseTransactions
   SET transaction_transactionCompleteBool = finished,
       transaction_onHold = onHold
 WHERE transaction_transactionId = transactionIdIn;

END;
//

DELIMITER ;
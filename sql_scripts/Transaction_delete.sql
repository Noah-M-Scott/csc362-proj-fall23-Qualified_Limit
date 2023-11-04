DELIMITER //

CREATE PROCEDURE transactionDelete(transactionIdIn INT)
BEGIN


UPDATE BaseTransactions
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;

END;
//

DELIMITER ;
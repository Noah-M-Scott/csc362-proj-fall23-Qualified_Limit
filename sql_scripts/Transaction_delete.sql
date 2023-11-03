DELIMITER //

CREATE PROCEDURE transactionUpdate(transactionIdIn INT)
BEGIN


UPDATE BaseTransactions
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;

END;
//

DELIMITER ;
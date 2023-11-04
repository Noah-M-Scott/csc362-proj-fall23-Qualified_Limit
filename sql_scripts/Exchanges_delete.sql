DELIMITER //

CREATE PROCEDURE exchangeDelete(transactionIdIn INT)
BEGIN


UPDATE BaseExchanges
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;

END;
//

DELIMITER ;
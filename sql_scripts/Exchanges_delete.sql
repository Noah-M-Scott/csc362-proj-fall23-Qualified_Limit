DELIMITER //

CREATE PROCEDURE exchangeDelete(transactionIdIn INT)
BEGIN

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseExchanges
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
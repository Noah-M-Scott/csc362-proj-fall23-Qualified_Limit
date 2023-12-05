DELIMITER  //

CREATE PROCEDURE returnsDelete(transactionIdIn INT)
BEGIN

UPDATE BaseReturns
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;


END;
//

DELIMITER ;

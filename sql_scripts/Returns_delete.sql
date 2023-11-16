DELIMITER  //

CREATE PROCEDURE returnsDelete(transactionIdIn INT)
BEGIN

UPDATE BaseReturns
   SET deleted = TRUE
 WHERE transactionId = transactionIdIn;


END;
//

DELIMITER ;

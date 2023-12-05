DELIMITER //

CREATE PROCEDURE returnsUpdate(transactionIdIn INT, dateReturnedIn DATE)
BEGIN

UPDATE BaseReturns
   SET transaction_transactionId = transactionIdIn, 
       return_dateReturned = dateReturnedIn 
WHERE transaction_transactionId = transactionIdIn;

END;
//

DELIMITER ;

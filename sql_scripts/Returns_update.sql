DELIMITER //

CREATE PROCEDURE returnsUpdate(transactionIdIn INT, dateReturnedIn DATE)
BEGIN

 -- update a return

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseReturns
   SET transaction_transactionId = transactionIdIn, 
       return_dateReturned = dateReturnedIn 
WHERE transaction_transactionId = transactionIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;

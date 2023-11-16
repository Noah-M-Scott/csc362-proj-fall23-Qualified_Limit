DELIMITER //

CREATE PROCEDURE returnsUpdate(transactionIdIn INT, dateReturnedIn DATE)
BEGIN

UPDATE BaseReturns
   SET transactionId = transactionIdIn, 
       dateReturned = dateReturnedIn 
WHERE transactionId = transactionIdIn;

END;
//

DELIMITER ;

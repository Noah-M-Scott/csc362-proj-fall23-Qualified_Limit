DELIMITER //

CREATE PROCEDURE returnsInsert(transactionIdIn INT, dateReturnedIn DATE)
BEGIN

SET FOREIGN_KEY_CHECKS=0;

INSERT INTO BaseReturns (
       transaction_transactionId, 
       return_dateReturned)
VALUES (transactionIdIn,
       dateReturnedIn);

SET FOREIGN_KEY_CHECKS=1;

END;
//
DELIMITER ;

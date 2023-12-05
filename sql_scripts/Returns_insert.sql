DELIMITER //

CREATE PROCEDURE returnsInsert(transactionIdIn INT, dateReturnedIn DATE)
BEGIN

INSERT INTO BaseReturns (
       transaction_transactionId, 
       return_dateReturned)
VALUES (transactionIdIn,
       dateReturnedIn);

END;
//
DELIMITER ;

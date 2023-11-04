DELIMITER //

CREATE PROCEDURE returnsInsert(transactionIdIn INT, dateReturnedIn DATE)
BEGIN

INSERT INTO BaseReturns (
       transactionId, 
       dateReturned)
VALUES (transactionIdIn,
       dateReturnedIn);

END;
//
DELIMITER ;

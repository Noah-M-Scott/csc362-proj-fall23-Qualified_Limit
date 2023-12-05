DELIMITER //

CREATE PROCEDURE warrantyInsertion(TransactionIdIn INT, warrantyCostIn DECIMAL(6,2), lengthInDaysIn INT)
BEGIN

SET FOREIGN_KEY_CHECKS = 0;

SELECT COUNT(transaction_transactionId) INTO @x FROM Warranties
WHERE transaction_transactionId = TransactionIdIn AND 
(ADDDATE(warranty_warrantyDate, INTERVAL warranty_lengthInDays DAY)) > CURDATE();

IF @x IS NULL OR @x = 0 THEN

INSERT INTO BaseWarranties (
       transaction_transactionId, 
       warranty_warrantyCost, 
       warranty_warrantyDate,
       warranty_lengthInDays)
VALUES (TransactionIdIn,
       warrantyCostIn,
       CURDATE(),
       lengthInDaysIn);

END IF;


SET FOREIGN_KEY_CHECKS = 1;

END;
//
DELIMITER ;
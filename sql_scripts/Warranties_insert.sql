DELIMITER //
CREATE OR REPLACE TRIGGER ensure_no_dup
BEFORE INSERT ON BaseWarranties FOR EACH ROW
BEGIN

SELECT COUNT(transaction_transactionId) INTO @x FROM Warranties
WHERE transaction_transactionId = NEW.transaction_transactionId AND 
(ADDDATE(warranty_warrantyDate, INTERVAL warranty_lengthInDays DAY)) >= CURDATE();

IF @x > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one warranty can be active at once.';
END IF;

END //
DELIMITER ;
/*---------------------------------------------------------------------------------------------------------*/

 -- We use a trigger here to ensure only one warranty is active on one transaction at once

/*---------------------------------------------------------------------------------------------------------*/
DELIMITER //

CREATE PROCEDURE warrantyInsertion(TransactionIdIn INT, warrantyCostIn DECIMAL(6,2), lengthInDaysIn INT)
BEGIN
DECLARE EXIT HANDLER FOR 1644 
GET DIAGNOSTICS CONDITION 1
    @err_state = RETURNED_SQLSTATE,
    @err_msg   = MESSAGE_TEXT;
SELECT 'Transfer not executed' AS 'RESULT',
       @err_state              AS 'ERROR',
       @err_msg                AS 'MESSAGE',
       TransactionIdIn         AS 'SRC';
START TRANSACTION;

 -- trigger and transaction for error handling

SET FOREIGN_KEY_CHECKS = 0;

 -- insert warranty
INSERT INTO BaseWarranties (
       transaction_transactionId, 
       warranty_warrantyCost, 
       warranty_warrantyDate,
       warranty_lengthInDays)
VALUES (TransactionIdIn,
       warrantyCostIn,
       CURDATE(),
       lengthInDaysIn);


SET FOREIGN_KEY_CHECKS = 1;

COMMIT;
END;
//
DELIMITER ;
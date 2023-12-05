DELIMITER //

CREATE PROCEDURE warrantyInsertion(TransactionIdIn INT, warrantyCostIn DECIMAL(6,2), warrantyDateIn DATE, lengthInDaysIn INT)
BEGIN

INSERT INTO BaseWarranties (
       transaction_transactionId, 
       warranty_warrantyCost, 
       warranty_warrantyDate,
       warranty_lengthInDays)
VALUES (TransactionIdIn,
       warrantyCostIn,
       warrantyDateIn,
       lengthInDaysIn);

END;
//
DELIMITER ;
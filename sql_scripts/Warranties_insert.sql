DELIMITER //

CREATE PROCEDURE warrantyInsertion(TransactionIdIn INT, warrantyCostIn DECIMAL(8,2), warrantyDateIn DATE, lengthInDaysIn INT)
BEGIN

INSERT INTO BaseWarranties (
       transactionId, 
       warrantyCost, 
       warrantyDate,
       lengthInDays)
VALUES (TransactionIdIn,
       warrantyCostIn,
       warrantyDateIn,
       lengthInDaysIn);

END;
//
DELIMITER ;
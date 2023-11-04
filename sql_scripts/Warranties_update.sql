DELIMITER //

CREATE PROCEDURE warrantyUpdate(TransactionIdIn INT, warrantyCostIn DECIMAL(8,2), warrantyDateIn DATE, lengthInDaysIn INT)
BEGIN

INSERT INTO BaseWarranties (
       transactionId, 
       warrantyCost, 
       warrantyDate,
       lengthInDays)
VALUES (TransactionIdIn,
       warrantyCostIn,
       warrantyDateIn,
       lengthInDaysIn)
WHERE  warrantyId = warrantyIdIn;

END;
//
DELIMITER ;
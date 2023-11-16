DELIMITER //

CREATE PROCEDURE warrantyUpdate(TransactionIdIn INT, warrantyCostIn DECIMAL(8,2), warrantyDateIn DATE, lengthInDaysIn INT)
BEGIN

UPDATE BaseWarranties
   SET transactionId = transactionIdIn, 
       warrantyCost = warrantyCostIn, 
       warrantyDate = warrantyDate,
       lengthInDays = lengthInDaysIn
WHERE  warrantyId = warrantyIdIn;

END;
//
DELIMITER ;
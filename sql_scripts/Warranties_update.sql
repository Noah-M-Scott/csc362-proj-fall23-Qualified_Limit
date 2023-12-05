DELIMITER //

CREATE PROCEDURE warrantyUpdate(TransactionIdIn INT, warrantyCostIn DECIMAL(6,2), warrantyDateIn DATE, lengthInDaysIn INT)
BEGIN

UPDATE BaseWarranties
   SET transaction_transactionId = transactionIdIn, 
       warranty_warrantyCost = warrantyCostIn, 
       warranty_warrantyDate = warrantyDate,
       warranty_lengthInDays = lengthInDaysIn
WHERE  warranty_warrantyId = warrantyIdIn;

END;
//
DELIMITER ;
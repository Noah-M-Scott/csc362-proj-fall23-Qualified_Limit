DELIMITER //

CREATE PROCEDURE warrantyUpdate(TransactionIdIn INT, warrantyCostIn DECIMAL(6,2), warrantyDateIn DATE, lengthInDaysIn INT)
BEGIN

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseWarranties
   SET transaction_transactionId = transactionIdIn, 
       warranty_warrantyCost = warrantyCostIn, 
       warranty_warrantyDate = warrantyDate,
       warranty_lengthInDays = lengthInDaysIn
WHERE  warranty_warrantyId = warrantyIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//
DELIMITER ;
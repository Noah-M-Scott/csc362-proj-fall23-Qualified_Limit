DELIMITER //

CREATE PROCEDURE financialDataDelete(financialIdIn INT)
BEGIN
START TRANSACTION;

 -- finacial stuff, so we do this in a transaction

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseFinancialData
   SET deleted = TRUE
 WHERE financialDatum_financialId = financialIdIn;

SET FOREIGN_KEY_CHECKS=1;

COMMIT;
END;
//

DELIMITER ;
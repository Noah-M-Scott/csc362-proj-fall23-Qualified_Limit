DELIMITER //

CREATE PROCEDURE financialDataDelete(financialIdIn INT)
BEGIN

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseFinancialData
   SET deleted = TRUE
 WHERE financialDatum_financialId = financialIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
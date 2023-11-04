DELIMITER //

CREATE PROCEDURE financialDataDelete(financialIdIn INT)
BEGIN


UPDATE BaseFinancialData
   SET deleted = TRUE
 WHERE financialDatum_financialId = financialIdIn;

END;
//

DELIMITER ;
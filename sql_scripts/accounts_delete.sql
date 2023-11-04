DELIMITER  //

CREATE PROCEDURE accountDelete(accountIdIn INT)
BEGIN

UPDATE BaseAccounts
   SET deleted = TRUE
 WHERE account_accountId = accountIdIn;


END;
//

DELIMTER ;
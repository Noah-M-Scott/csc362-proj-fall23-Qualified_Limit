DELIMITER  //

CREATE PROCEDURE accountDelete(accountIdIn INT)
BEGIN

 -- delete account
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM Accounts WHERE account_accountId = accountIdIn;


 -- preform nullify on transactions
UPDATE BaseTransactions
   SET account_accountId = NULL
 WHERE account_accountId = accountIdIn;


SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
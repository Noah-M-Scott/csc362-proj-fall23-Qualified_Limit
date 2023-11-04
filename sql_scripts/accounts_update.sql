DELIMITER //

CREATE PROCEDURE accountsUpdate(accountIdIn INT, accountEmailIn VARCHAR(80), phoneIn INT(12), userNameIn VARCHAR(30))
BEGIN

UPDATE baseAccounts
   SET accountEmail = accountEmailIn, 
       userName = userNameIn, 
       phone = phoneIn
WHERE accountId = accountIdIn;

END;
//

DELIMITER ;
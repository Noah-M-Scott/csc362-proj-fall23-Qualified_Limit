DELIMITER //

CREATE PROCEDURE accountsUpdate(accountIdIn INT, accountEmailIn VARCHAR(80), phoneIn INT(12), userNameIn VARCHAR(30))

UPDATE accounts
   SET accountEmail = accountEmailIn, 
       userName = userNameIn, 
       phone = phoneIn
WHERE accountId = accountIdIn;

END;
//

DELIMITER ;
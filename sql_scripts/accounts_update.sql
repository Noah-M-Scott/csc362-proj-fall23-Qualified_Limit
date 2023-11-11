DELIMITER //

CREATE PROCEDURE accountsUpdate(accountIdIn INT, accountEmailIn VARCHAR(80), phoneIn CHAR(10), userNameIn VARCHAR(30), userPassWordIn VARCHAR(30))
BEGIN

UPDATE accounts
   SET accountEmail = accountEmailIn, 
       userName = userNameIn, 
       phone = phoneIn,
       userPassWord = userPassWordIn
WHERE accountId = accountIdIn;

END;
//

DELIMITER ;
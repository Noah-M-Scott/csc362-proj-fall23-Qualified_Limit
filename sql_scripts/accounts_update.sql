DELIMITER //

CREATE PROCEDURE accountsUpdate(accountIdIn INT, accountEmailIn VARCHAR(128), phoneIn CHAR(10), userNameIn VARCHAR(32), userPassWordIn VARCHAR(32))
BEGIN

 -- update Account information
UPDATE Accounts
   SET account_accountEmail = accountEmailIn, 
       account_userName = userNameIn, 
       account_phone = phoneIn,
       account_userPassWord = userPassWordIn
WHERE account_accountId = accountIdIn;

END;
//

DELIMITER ;
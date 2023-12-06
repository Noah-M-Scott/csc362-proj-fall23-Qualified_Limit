DELIMITER //

CREATE PROCEDURE accountInsertion(accountEmailIn VARCHAR(128), phoneIn CHAR(10), userNameIn VARCHAR(32), userPassWordIn VARCHAR(32))
BEGIN

-- create a new account into Accounts
INSERT INTO Accounts (
       account_accountEmail, 
       account_phone, 
       account_userName, account_userPassWord)
VALUES (accountEmailIn,
       phoneIn,
       userNameIn, userPassWordIn);

END;
//
DELIMITER ;
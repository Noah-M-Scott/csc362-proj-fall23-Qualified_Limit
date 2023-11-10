DELIMITER //

CREATE PROCEDURE accountInsertion(accountEmailIn VARCHAR(80), phoneIn INT(12), userNameIn VARCHAR(30), userPassWordIn VARCHAR(30))
BEGIN

INSERT INTO BaseAccounts (
       accountEmail, 
       phone, 
       userName, userPassWord)
VALUES (accountEmailIn,
       phoneIn,
       userNameIn, userPassWordIn);

END;
//
DELIMITER ;
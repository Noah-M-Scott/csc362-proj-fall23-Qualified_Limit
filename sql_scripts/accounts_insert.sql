DELIMITER //

CREATE PROCEDURE accountInsertion(accountEmailIn VARCHAR(80), phoneIn CHAR(10), userNameIn VARCHAR(30), userPassWordIn VARCHAR(30))
BEGIN

INSERT INTO accounts (
       accountEmail, 
       accountPhone, 
       userName, userPassWord)
VALUES (accountEmailIn,
       phoneIn,
       userNameIn, userPassWordIn);

END;
//
DELIMITER ;
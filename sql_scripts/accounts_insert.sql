DELIMITER //

CREATE PROCEDURE accountInsertion(accountEmailIn VARCHAR(80), phoneIn INT(12), userNameIn VARCHAR(30))
BEGIN

INSERT INTO BaseAccounts (
       accountEmail, 
       phone, 
       userName)
VALUES (accountEmailIn,
       phoneIn,
       userNameIn);

END;
//
DELIMITER ;
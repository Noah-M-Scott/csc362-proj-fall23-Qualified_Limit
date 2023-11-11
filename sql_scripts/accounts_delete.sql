DELIMITER  //

CREATE PROCEDURE accountDelete(accountIdIn INT)
BEGIN

DELETE FROM accounts WHERE accountId = accountIdIn;

END;
//

DELIMITER ;
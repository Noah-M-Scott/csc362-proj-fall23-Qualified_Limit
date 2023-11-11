DELIMITER  //

CREATE PROCEDURE accountDelete(accountIdIn INT)
BEGIN

DELETE FROM account WHERE accountId = accountIdIn;

END;
//

DELIMITER ;
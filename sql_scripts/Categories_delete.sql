DELIMITER //

CREATE PROCEDURE categoriesDelete(categoryIdIn INT)
BEGIN

UPDATE accounts
   SET deleted = TRUE
WHERE categoryId = categoryIdIn;

END;
//

DELIMITER ;
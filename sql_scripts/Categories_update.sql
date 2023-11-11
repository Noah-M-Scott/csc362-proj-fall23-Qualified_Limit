DELIMITER //

CREATE PROCEDURE categoriesUpdate(categoryIdIn INT, categoryNameIn VARCHAR(32))
BEGIN

UPDATE accounts
   SET categoryName = categoryNameIn
WHERE categoryId = categoryIdIn;

END;
//

DELIMITER ;
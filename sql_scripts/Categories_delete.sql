DELIMITER //

CREATE PROCEDURE categoriesDelete(categoryIdIn INT)
BEGIN

UPDATE BaseCatagories
   SET deleted = TRUE
WHERE catagory_categoryId = categoryIdIn;

END;
//

DELIMITER ;
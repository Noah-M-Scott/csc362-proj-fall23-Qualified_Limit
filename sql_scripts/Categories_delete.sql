DELIMITER //

CREATE PROCEDURE categoriesDelete(categoryIdIn INT)
BEGIN

 -- deny delete catagory

UPDATE BaseCatagories
   SET deleted = TRUE
WHERE catagory_categoryId = categoryIdIn;

END;
//

DELIMITER ;
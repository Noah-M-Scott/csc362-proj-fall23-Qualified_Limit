DELIMITER //

CREATE PROCEDURE categoriesUpdate(categoryIdIn INT, categoryNameIn VARCHAR(32))
BEGIN

 -- update a catagory

UPDATE BaseCatagories
   SET catagory_categoryName = categoryNameIn
WHERE catagory_categoryId = categoryIdIn;

END;
//

DELIMITER ;
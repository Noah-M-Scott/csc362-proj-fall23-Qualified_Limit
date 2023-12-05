DELIMITER //

CREATE PROCEDURE categoryInsertion(categoryNameIn VARCHAR(32))
BEGIN

INSERT INTO BaseCategories (
       catagory_categoryName)
VALUES (categoryNameIn);


END;
//
DELIMITER ;
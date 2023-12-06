DELIMITER //

CREATE PROCEDURE categoryInsertion(categoryNameIn VARCHAR(32))
BEGIN

 -- add a new catagory

INSERT INTO BaseCategories (
       catagory_categoryName)
VALUES (categoryNameIn);


END;
//
DELIMITER ;
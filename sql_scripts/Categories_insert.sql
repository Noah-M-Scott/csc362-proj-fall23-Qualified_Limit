DELIMITER //

CREATE PROCEDURE categoryInsertion(categoryNameIn VARCHAR(32))
BEGIN

INSERT INTO BaseCategories (
       categoryName)
VALUES (categoryNameIn);


END;
//
DELIMITER ;
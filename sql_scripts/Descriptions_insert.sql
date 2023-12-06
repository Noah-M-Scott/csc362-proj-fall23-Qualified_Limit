DELIMITER //

CREATE PROCEDURE descriptionsInsertion(catalogIdIn INT, textIn VARCHAR(5000))
BEGIN

       -- create a new description

INSERT INTO BaseDescriptions (
       description_Id, 
       description_text)
VALUES (catalogIdIn,
       textIn);

END;
//
DELIMITER ;

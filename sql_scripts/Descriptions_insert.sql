DELIMITER //

CREATE PROCEDURE descriptionsInsertion(catalogIdIn INT, textIn VARCHAR(5000))
BEGIN

INSERT INTO BaseDescriptions (
       catalogId, 
       text)
VALUES (catalogIdIn,
       textIn);

END;
//
DELIMITER ;

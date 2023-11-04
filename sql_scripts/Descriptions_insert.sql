DELIMITER //

CREATE PROCEDURE descriptionsInsertion(catalogIdIn INT, textIn VARCHAR(5000))
BEGIN

INSERT INTO baseDescriptions (
       catalogId, 
       text)
VALUES (catalogIdIn,
       textIn);

END;
//
DELIMITER ;
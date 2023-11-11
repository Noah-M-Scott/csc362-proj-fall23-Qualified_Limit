DELIMITER //

CREATE PROCEDURE descriptionsUpdate(catalogIdIn INT, textIn VARCHAR(5000))
BEGIN

UPDATE BaseDescriptions
   SET text = textIn
WHERE catalogId = catalogIdIn;

END;
//

DELIMITER ;

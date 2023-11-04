DELIMITER //

CREATE PROCEDURE descriptionsUpdate(catalogIdIn INT, textIn VARCHAR(5000))
BEGIN

UPDATE baseDescriptions
   SET catalogId = catalogIdIn, 
       text = textIn, 
WHERE catalogId = catalogIdIn;

END;
//

DELIMITER ;
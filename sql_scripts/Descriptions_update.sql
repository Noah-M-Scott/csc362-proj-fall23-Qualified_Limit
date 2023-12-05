DELIMITER //

CREATE PROCEDURE descriptionsUpdate(catalogIdIn INT, textIn VARCHAR(5000))
BEGIN

UPDATE BaseDescriptions
   SET description_text = textIn
WHERE description_Id = catalogIdIn;

END;
//

DELIMITER ;

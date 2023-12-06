DELIMITER //

CREATE PROCEDURE descriptionsUpdate(descriptionIdIn INT, textIn VARCHAR(5000))
BEGIN

   -- update description

UPDATE BaseDescriptions
   SET description_text = textIn
WHERE description_Id = descriptionIdIn;

END;
//

DELIMITER ;

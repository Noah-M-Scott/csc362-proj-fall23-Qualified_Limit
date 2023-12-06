DELIMITER  //

CREATE PROCEDURE descriptionDelete(catalogIdIn INT)
BEGIN

  -- deny delete descriptions

UPDATE BaseDescription
   SET deleted = TRUE
 WHERE description_Id = catalogIdIn;


END;
//

DELIMITER ;

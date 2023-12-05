DELIMITER  //

CREATE PROCEDURE descriptionDelete(catalogIdIn INT)
BEGIN

UPDATE BaseDescription
   SET deleted = TRUE
 WHERE description_Id = catalogIdIn;


END;
//

DELIMITER ;

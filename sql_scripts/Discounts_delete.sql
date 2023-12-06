DELIMITER  //

CREATE PROCEDURE discountDelete(catalogIdIn INT, startDateIn DATE, endDateIn DATE)
BEGIN


 -- deny delete discount

SET FOREIGN_KEY_CHECKS=0;
UPDATE BaseDiscounts
   SET deleted = TRUE
 WHERE catalog_catalogId = catalogIdIn AND discount_startDate = startDateIn AND discount_endDate = endDateIn;
SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;

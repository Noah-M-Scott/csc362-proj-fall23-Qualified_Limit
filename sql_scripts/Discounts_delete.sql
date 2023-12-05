DELIMITER  //

CREATE PROCEDURE discountDelete(catalogIdIn INT, startDateIn DATE, endDateIn DATE)
BEGIN

UPDATE BaseDiscounts
   SET deleted = TRUE
 WHERE catalog_catalogId = catalogIdIn AND discount_startDate = startDateIn AND discount_endDate = endDateIn;


END;
//

DELIMITER ;

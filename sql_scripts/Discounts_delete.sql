DELIMITER  //

CREATE PROCEDURE discountDelete(catalogIdIn INT, startDateIn DATE, endDateIn DATE)
BEGIN

UPDATE BaseDiscounts
   SET deleted = TRUE
 WHERE catalogId = catalogIdIn AND startDate = startDateIn AND endDate = endDateIn;


END;
//

DELIMITER ;

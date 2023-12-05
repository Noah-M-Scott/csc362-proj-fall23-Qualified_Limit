DELIMITER //

CREATE PROCEDURE discountsUpdate(catalogIdIn INT, priceOffPercentIn DECIMAL(3,0), startDateIn DATE, endDateIn DATE)
BEGIN

UPDATE BaseDiscounts
   SET catalog_catalogId = catalogIdIn, 
       discount_priceOffPercent = priceOffPercentIn, 
       discount_startDate = startDateIn,
       discount_endDate = endDateIn
 WHERE catalog_catalogId = catalogIdIn AND discount_startDate = startDateIn AND discount_endDate = endDateIn;

END;
//

DELIMITER ;

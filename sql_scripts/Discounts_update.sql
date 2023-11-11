DELIMITER //

CREATE PROCEDURE discountsUpdate(catalogIdIn INT, priceOffPercentIn DECIMAL(3,0), startDateIn DATE, endDateIn DATE)
BEGIN

UPDATE BaseDiscounts
   SET catalogId = catalogIdIn, 
       priceOffPercent = priceOffPercentIn, 
       startDate = startDateIn,
       endDate = endDateIn
WHERE catalogId = catalogIdIn AND startDate = startDateIn AND endDate = endDateIn;

END;
//

DELIMITER ;

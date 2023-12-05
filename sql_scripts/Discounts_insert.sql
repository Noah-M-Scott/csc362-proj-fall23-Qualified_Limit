DELIMITER //

CREATE PROCEDURE discountInsertion(catalogIdIn INT, priceOffPercentIn DECIMAL(3,0), startDateIn DATE, endDateIn DATE)
BEGIN

INSERT INTO BaseDiscounts (
       catalog_catalogId, 
       discount_priceOffPercent, 
       discount_startDate,
       discount_endDate)
VALUES (catalogIdIn,
       priceOffPercentIn,
       startDateIn,
       endDateIn);

END;
//
DELIMITER ;

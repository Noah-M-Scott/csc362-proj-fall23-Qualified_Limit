DELIMITER //

CREATE PROCEDURE discountInsertion(catalogIdIn INT, priceOffPercentIn DECIMAL(3,0), startDateIn DATE, endDateIn DATE)
BEGIN

INSERT INTO BaseDiscounts (
       catalogId, 
       priceOffPercent, 
       startDate,
       endDate)
VALUES (catalogIdIn,
       priceOffPercentIn,
       startDateIn,
       endDateIn);

END;
//
DELIMITER ;

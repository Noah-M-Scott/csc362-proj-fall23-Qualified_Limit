DELIMITER //

CREATE PROCEDURE catalogInsertion(catalogIdIn INT, itemNameIn VARCHAR(150), categoryIn VARCHAR(100), 
                                    currentPriceIn DECIMAL(8,2), dateFirstAvailableIn DATETIME, 
                                    numberInStockIn INT, manufacturerIn VARCHAR(80))
BEGIN

UPDATE BaseCatalog
   SET itemName = itemNameIn,
       category= categoryIn,
       currentPrice = currentPriceIn,
       dateFirstAvailable =dateFirstAvailableIn,
       numberInStock = numberInStockIn,
       manufacturer = manufacturerIn
 WHERE catalogId = catalogIdIn;

END;
//
DELIMITER ;
DELIMITER //

CREATE PROCEDURE catalogUpdate(catalogIdIn INT, itemNameIn VARCHAR(128), categoryIn VARCHAR(128), 
                                    currentPriceIn DECIMAL(6,2), dateFirstAvailableIn DATETIME, 
                                    numberInStockIn INT, manufacturerIn VARCHAR(128))
BEGIN

UPDATE BaseCatalog
   SET catalog_itemName = itemNameIn,
       catalog_category= categoryIn,
       catalog_currentPrice = currentPriceIn,
       catalog_dateFirstAvailable =dateFirstAvailableIn,
       catalog_numberInStock = numberInStockIn,
       catalog_manufacturer = manufacturerIn
 WHERE catalog_catalogId = catalogIdIn;

END;
//
DELIMITER ;
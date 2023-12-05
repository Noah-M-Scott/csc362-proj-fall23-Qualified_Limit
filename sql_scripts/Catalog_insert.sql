DELIMITER //

CREATE PROCEDURE catalogInsertion(itemNameIn VARCHAR(128), categoryIn VARCHAR(128), 
                                    currentPriceIn DECIMAL(6,2), dateFirstAvailableIn DATETIME, 
                                    numberInStockIn INT, manufacturerIn VARCHAR(128), descriptionIn VARCHAR(4096))
BEGIN

INSERT INTO BaseCatalog ( 
       catalog_itemName, 
       catalog_category,
       catalog_currentPrice,
       catalog_dateFirstAvailable,
       catalog_numberInStock,
       catalog_manufacturer,
       description_Id)
VALUES (itemNameIn,
       categoryIn,
       currentPriceIn,
       dateFirstAvailableIn,
       numberInStockIn,
       manufacturerIn,
       descriptionIn);

END;
//
DELIMITER ;
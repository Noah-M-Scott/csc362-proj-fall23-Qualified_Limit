DELIMITER //

CREATE PROCEDURE catalogInsertion(catalogIdIn INT, itemNameIn VARCHAR(150), categoryIn VARCHAR(100), 
                                    currentPriceIn DECIMAL(8,2), dateFirstAvailableIn DATETIME, 
                                    numberInStockIn INT, manufacturerIn VARCHAR(80))
BEGIN

INSERT INTO BaseCatalog (
       catalogId, 
       itemName, 
       category,
       currentPrice,
       dateFirstAvailable,
       numberInStock,
       manufacturer)
VALUES (catalogIdIn,
       itemNameIn,
       categoryIn,
       currentPriceIn,
       dateFirstAvailableIn,
       numberInStockIn,
       manufacturerIn);

END;
//
DELIMITER ;
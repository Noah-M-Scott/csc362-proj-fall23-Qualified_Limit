DELIMITER //

CREATE PROCEDURE catalogUpdate(catalogIdIn INT, itemNameIn VARCHAR(128), categoryIn VARCHAR(128), 
                                    currentPriceIn DECIMAL(6,2), dateFirstAvailableIn DATETIME, 
                                    numberInStockIn INT, manufacturerIn VARCHAR(128))
BEGIN

   SET FOREIGN_KEY_CHECKS=0;
UPDATE BaseCatalog
   SET catalog_itemName = itemNameIn,
       catalog_category= categoryIn,
       catalog_currentPrice = currentPriceIn,
       catalog_dateFirstAvailable =dateFirstAvailableIn,
       catalog_numberInStock = numberInStockIn,
       catalog_manufacturer = manufacturerIn
 WHERE catalog_catalogId = catalogIdIn;



 -- update transactions on hold
SELECT catalog_numberInStock INTO @x FROM BaseCatalog;

WHILE @x > 0 DO
   UPDATE Transactions
      SET transactions_onHold = FALSE
    WHERE catalog_catalogId = catalogIdIn
 ORDER BY transaction_dateMade DESC
    LIMIT 1;

   UPDATE BaseCatalog
      SET catalog_numberInStock = (catalog_numberInStock - 1)
    WHERE catalog_catalogId = catalogIdIn;

   SELECT catalog_numberInStock INTO @x FROM BaseCatalog;

END WHILE;


   SET FOREIGN_KEY_CHECKS=1;

END;
//
DELIMITER ;

DELIMITER //

CREATE PROCEDURE catalogDecrement(catalogIdIn INT)
BEGIN

UPDATE BaseCatalog
   SET catalog_numberInStock = (catalog_numberInStock - 1)
 WHERE catalog_catalogId = catalogIdIn;

END;
//
DELIMITER ;
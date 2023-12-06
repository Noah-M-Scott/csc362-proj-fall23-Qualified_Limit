DELIMITER //

CREATE FUNCTION transactionInsert(catalogIdIn INT, accountIdIn INT)
RETURNS INT
BEGIN

 -- insert a new transaction

SET FOREIGN_KEY_CHECKS = 0;

 -- get the item's current price
SELECT catalog_currentPrice 
  INTO @PRICE 
  FROM Catalog 
 WHERE catalog_catalogId = catalogIdIn 
 LIMIT 1;

 -- get the discount rate
SELECT discount_priceOffPercent 
  INTO @DISCOUNT 
  FROM Discounts 
 WHERE catalog_catalogId = catalogIdIn
   AND discount_endDate < CURDATE()
 LIMIT 1;

 -- fix nulls
SELECT IF(@DISCOUNT != NULL, @DISCOUNT, 0) INTO @DISCOUNT;

 -- apply the discount
SET @PRICE = @PRICE - (@PRICE * (@DISCOUNT / 100));

 -- get the number in stock
SELECT catalog_numberInStock 
  INTO @AMOUNT
  FROM Catalog 
 WHERE catalog_catalogId = catalogIdIn 
 LIMIT 1;

 -- insert
INSERT INTO BaseTransactions (
       catalog_catalogId,
       account_accountId,
       transaction_dateMade,
       transaction_originalPriceAtTransaction,
       transaction_currentAmountOwed,
       transaction_currentAmountPaid,
       transaction_transactionCompleteBool,
       transaction_onHold)
VALUES (catalogIdIn, 
       accountIdIn, 
       CURDATE(),
       @PRICE,
       @PRICE,
       0,
       FALSE,
       (@AMOUNT > 0)); -- handle on holds

 -- return the id of the transaction we made
SELECT transaction_transactionId INTO @x FROM Transactions ORDER BY transaction_transactionId DESC LIMIT 1;

SET FOREIGN_KEY_CHECKS = 1;

RETURN @x;
END;
//

DELIMITER ;




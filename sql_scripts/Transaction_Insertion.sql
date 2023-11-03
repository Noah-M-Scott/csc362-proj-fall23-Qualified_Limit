DELIMITER //

CREATE PROCEDURE transactionInsert(catalogIdIn INT, accountIdIn INT)
BEGIN

SELECT currentPrice INTO @PRICE FROM catalog WHERE catalogId = catalogIdIn LIMIT 1;

SELECT priceOffPercent INTO @DISCOUNT FROM discounts WHERE catalogId = catalogIdIn LIMIT 1;

IF (@DICOUNT != NULL) THEN @PRICE = @PRICE * @DISCOUNT;

SELECT numberInStock INTO @AMOUNT FROM catalog WHERE catalogId = catalogIdIn LIMIT 1;

INSERT INTO BaseTransactions (
       catalog_catalogId,
       account_accountId,
       transaction_dateMade,
       transaction_originalPriceAtTransaction,
       transaction_currentAmountOwed,
       transaction_currentAmountPaid,
       transaction_transactionCompleteBool,
       transaction_onHold)
VALUES (catalogId, 
       accountId, 
       GETDATE(),
       @PRICE,
       @PRICE,
       0,
       FALSE,
       (@AMOUNT > 0));

END;
//

DELIMITER ;




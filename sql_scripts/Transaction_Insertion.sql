DELIMITER //

CREATE PROCEDURE transactionInsert(catalogIdIn INT, accountIdIn INT)
BEGIN

SELECT currentPrice INTO @PRICE FROM catalog WHERE catalogId = catalogIdIn LIMIT 1;

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




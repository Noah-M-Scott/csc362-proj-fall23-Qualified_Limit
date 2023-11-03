CREATE PROCEDURE transactionInsert(catalogId INT, accountId INT)
BEGIN

SET @PRICE = (SELECT catalog_currentPrice FROM Catalogs WHERE catalog_catalogId = catalogId);

SET @AMOUNT = (SELECT catalog_numberInStock FROM Catalogs WHERE catalog_catalogId = catalogId);

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
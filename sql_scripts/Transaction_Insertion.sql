CREATE PROCEDURE transactionInsert(catalogIdIn INT, accountIdIn INT)
BEGIN

SET @PRICE = (SELECT currentPrice FROM catalog WHERE catalogId = catalogIdIn);

SET @AMOUNT = (SELECT numberInStock FROM catalog WHERE catalogId = catalogIdIn);

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
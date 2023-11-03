CREATE TABLE BaseTransactions (
    transaction_transactionId INT AUTO_INCREMENT,
    PRIMARY KEY(transaction_transactionId),

    catalog_catalogId INT,
    account_accountId INT,
    FOREIGN KEY (catalog_catalogId) REFERENCES Catalogs (catalog_catalogId),
    FOREIGN KEY (account_accountId) REFERENCES Accounts (account_accountId),

    transaction_dateMade DATETIME,
    transaction_originalPriceAtTransaction DECIMAL(8,2),
    transaction_currentAmountOwed DECIMAL(8,2),
    transaction_currentAmountPaid DECIMAL(8,2),
    transaction_transactionCompleteBool BOOLEAN,
    transaction_onHold BOOLEAN,
    deleted BOOLEAN DEFAULT FALSE
);

CREATE VIEW Transactions AS
SELECT transaction_transactionId,
       catalog_catalogId,
       account_accountId,
       transaction_dateMade,
       transaction_originalPriceAtTransaction,
       transaction_currentAmountOwed,
       transaction_currentAmountPaid,
       transaction_transactionCompleteBool,
       transaction_onHold FROM BaseTransactions WHERE deleted = FALSE;

SOURCE Transaction_Insertion.sql
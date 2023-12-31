CREATE TABLE BaseExchanges (
    exchange_amountOwedAtExchange DECIMAL(6,2),

    transaction_transactionId INT,
    PRIMARY KEY(transaction_transactionId),
    FOREIGN KEY(transaction_transactionId) REFERENCES Transactions (transaction_transactionId),

    exchange_idOfExchangedTransaction INT,
    FOREIGN KEY(exchange_idOfExchangedTransaction) REFERENCES Transactions (transaction_transactionId),
    
    exchange_returnTrackId VARCHAR(128),
    deleted BOOLEAN DEFAULT FALSE
);

 -- view for deny delete
CREATE VIEW Exchanges AS
SELECT exchange_amountOwedAtExchange,
       transaction_transactionId,
       exchange_idOfExchangedTransaction,
       exchange_returnTrackId
       FROM BaseExchanges WHERE deleted = FALSE;

SOURCE Exchanges_insert.sql
SOURCE Exchanges_delete.sql
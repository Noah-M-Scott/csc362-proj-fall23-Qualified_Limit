use upward;

CREATE TABLE returns (
    transactionId           INT unsigned NOT NULL UNIQUE,
    dateReturned            DATE NOT NULL,
    PRIMARY KEY             (transactionId),
    FOREIGN KEY             (transactionId) REFERENCES
                                Transactions(transaction_transactionId)
);
use upward;

CREATE TABLE BaseReturns (
    transaction_transactionId           INT unsigned NOT NULL UNIQUE,
    return_dateReturned                 DATE NOT NULL,
    PRIMARY KEY                         (transaction_transactionId),
    FOREIGN KEY                         (transaction_transactionId) REFERENCES Transactions(transaction_transactionId),
    deleted                             BOOLEAN DEFAULT FALSE
);


CREATE VIEW Returns AS
SELECT transaction_transactionId,      
       return_dateReturned     
  FROM BaseReturns
 WHERE deleted = FALSE;

SOURCE Returns_insert.sql
SOURCE Returns_delete.sql
SOURCE Returns_update.sql
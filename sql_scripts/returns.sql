use upward;

CREATE TABLE BaseReturns (
    transactionId           INT unsigned NOT NULL UNIQUE,
    dateReturned            DATE NOT NULL,
    PRIMARY KEY             (transactionId),
    FOREIGN KEY             (transactionId) REFERENCES
                                Transactions(transaction_transactionId),
    deleted                 BOOLEAN DEFAULT FALSE
);


CREATE VIEW returns AS
SELECT transactionId,      
dateReturned     
  FROM BaseReturns
 WHERE deleted = FALSE;

SOURCE Returns_insert.sql
SOURCE Returns_delete.sql
SOURCE Returns_update.sql
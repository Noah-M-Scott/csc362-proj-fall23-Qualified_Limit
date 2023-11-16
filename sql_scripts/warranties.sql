USE upward;

CREATE TABLE BaseWarranties (
    warrantyId              INT unsigned NOT NULL AUTO_INCREMENT UNIQUE,
    transactionId           INT unsigned NOT NULL UNIQUE,
    warrantyCost            DECIMAL(8,2) NOT NULL,
    warrantyDate            DATE NOT NULL,
    lengthInDays            INT NOT NULL NOT NULL,
    PRIMARY KEY             (warrantyId, transactionId),
    FOREIGN KEY             (transactionId) REFERENCES
                                Transactions(transaction_transactionId),
    deleted                 BOOLEAN DEFAULT FALSE
);

CREATE VIEW warranties AS
SELECT warrantyId,
       transactionId,
       warrantyCost,
       warrantyDate,
       lengthInDays
  FROM BaseWarranties
 WHERE deleted = FALSE;

SOURCE Warranties_insert.sql
SOURCE Warranties_delete.sql
SOURCE Warranties_update.sql
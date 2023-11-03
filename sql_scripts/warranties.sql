USE upward;

CREATE TABLE warranties (
    warrantyId              INT unsigned NOT NULL AUTO_INCREMENT UNIQUE,
    transactionId           INT unsigned NOT NULL UNIQUE,
    warrantyCost            DECIMAL(8,2) NOT NULL,
    warrantyDate            DATE NOT NULL,
    lengthInDays            INT NOT NULL NOT NULL,
    PRIMARY KEY             (warrantyId, transactionId),
    FOREIGN KEY             transactionId REFERENCES
                                Transactions(transaction_transactionId)
)
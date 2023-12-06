USE upward;

CREATE TABLE BaseWarranties (
    warranty_warrantyId         INT unsigned NOT NULL AUTO_INCREMENT UNIQUE,
    transaction_transactionId   INT unsigned NOT NULL,
    warranty_warrantyCost       DECIMAL(6,2) NOT NULL,
    warranty_warrantyDate       DATE NOT NULL,
    warranty_lengthInDays       INT NOT NULL NOT NULL,
    PRIMARY KEY                 (warranty_warrantyId, transaction_transactionId),
    FOREIGN KEY                 (transaction_transactionId) REFERENCES Transactions(transaction_transactionId),
    deleted                     BOOLEAN DEFAULT FALSE
);

 -- view for deny delete
CREATE VIEW Warranties AS
SELECT warranty_warrantyId,
       transaction_transactionId,
       warranty_warrantyCost,
       warranty_warrantyDate,
       warranty_lengthInDays
  FROM BaseWarranties
 WHERE deleted = FALSE AND (ADDDATE(warranty_warrantyDate, INTERVAL warranty_lengthInDays DAY)) >= CURDATE();

SOURCE Warranties_insert.sql
SOURCE Warranties_delete.sql
SOURCE Warranties_update.sql
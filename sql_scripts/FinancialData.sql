CREATE TABLE BaseFinancialData (
    financialDatum_financialId INT AUTO_INCREMENT,
    PRIMARY KEY (financialDatum_financialId),

    transaction_transactionId INT,
    FOREIGN KEY (transaction_transactionId) REFERENCES Transactions (transaction_transactionId),

    financialDatum_amountOwedAtPayment DECIMAL(8,2),
    financialDatum_amountPayedAtPayment DECIMAL(8,2),
    financialDatum_last4digitsOfCard CHAR(4),
    financialDatum_billingAddress VARCHAR(128),
    financialDatum_datePayed DATETIME,
    deleted BOOLEAN DEFAULT FALSE
);

CREATE VIEW FinancialData AS
SELECT financialDatum_financialId,
       transaction_transactionId,
       financialDatum_amountOwedAtPayment,
       financialDatum_amountPayedAtPayment,
       financialDatum_last4digitsOfCard,
       financialDatum_billingAddress,
       financialDatum_datePayed 
       FROM BaseFinancialData WHERE deleted = FALSE;
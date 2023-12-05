DELIMITER //

CREATE PROCEDURE financialDataInsert(
       transaction_transactionIdIN INT,
       financialDatum_amountOwedAtPaymentIN DECIMAL(6,2),
       financialDatum_amountPayedAtPaymentIN DECIMAL(6,2),
       financialDatum_last4digitsOfCardIN CHAR(4),
       financialDatum_billingAddressIN VARCHAR(128),
       financialDatum_datePayedIN DATETIME
    )
BEGIN

INSERT INTO BaseFinancialData (
       transaction_transactionId,
       financialDatum_amountOwedAtPayment,
       financialDatum_amountPayedAtPayment,
       financialDatum_last4digitsOfCard,
       financialDatum_billingAddress,
       financialDatum_datePayed
       )
VALUES (
       transaction_transactionIdIN,
       financialDatum_amountOwedAtPaymentIN,
       financialDatum_amountPayedAtPaymentIN,
       financialDatum_last4digitsOfCardIN,
       financialDatum_billingAddressIN,
       financialDatum_datePayedIN
       );

END;
//

DELIMITER ;
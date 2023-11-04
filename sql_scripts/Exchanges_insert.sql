DELIMITER //

CREATE PROCEDURE exchangeInsert(
    exchange_amountOwedAtExchangeIN DECIMAL(8,2),
    transaction_transactionIdIN INT,
    exchange_idOfExchangedTransactionIN INT,
    exchange_returnTrackIdIN VARCHAR(128)
    )
BEGIN

INSERT INTO BaseExchanges (
       exchange_amountOwedAtExchange,
       transaction_transactionId,
       exchange_idOfExchangedTransaction,
       exchange_returnTrackId)
VALUES (
       exchange_amountOwedAtExchangeIN,
       transaction_transactionIdIN,
       exchange_idOfExchangedTransactionIN,
       exchange_returnTrackIdIN
       );

END;
//

DELIMITER ;
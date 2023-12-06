DELIMITER //

CREATE PROCEDURE exchangeInsert(
    exchange_amountOwedAtExchangeIN DECIMAL(6,2),
    transaction_transactionIdIN INT,
    exchange_idOfExchangedTransactionIN INT,
    exchange_returnTrackIdIN VARCHAR(128)
    )
BEGIN

SET FOREIGN_KEY_CHECKS=0;

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

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
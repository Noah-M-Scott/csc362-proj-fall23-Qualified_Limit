DELIMITER //

CREATE PROCEDURE shippingDataDelete(transactionIdIn INT, trackingIdIn VARCHAR(128))
BEGIN


UPDATE BaseShippingData
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn
   AND shippingDatum_trackingId = trackingIdIn;

END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE shippingDataDeleteAll(transactionIdIn INT)
BEGIN


UPDATE BaseShippingData
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;

END;
//

DELIMITER ;
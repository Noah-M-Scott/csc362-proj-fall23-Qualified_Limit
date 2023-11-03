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
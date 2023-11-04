DELIMITER //

CREATE PROCEDURE shippingDataUpdate(transactionIdIn INT, trackingIdIn VARCHAR(128), itemArrived BOOLEAN)
BEGIN


UPDATE BaseShippingData
   SET shippingDatum_itemArrivedBool = itemArrived
 WHERE transaction_transactionId = transactionIdIn
   AND shippingDatum_trackingId = trackingIdIn;

END;
//

DELIMITER ;
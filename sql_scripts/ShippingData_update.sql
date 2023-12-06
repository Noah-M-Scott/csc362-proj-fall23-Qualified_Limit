DELIMITER //

CREATE PROCEDURE shippingDataUpdate(transactionIdIn INT, trackingIdIn VARCHAR(128), itemArrived BOOLEAN)
BEGIN

 -- update a shipping datum

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseShippingData
   SET shippingDatum_itemArrivedBool = itemArrived
 WHERE transaction_transactionId = transactionIdIn
   AND shippingDatum_trackingId = trackingIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
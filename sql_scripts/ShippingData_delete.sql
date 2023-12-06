DELIMITER //

CREATE PROCEDURE shippingDataDelete(transactionIdIn INT, trackingIdIn VARCHAR(128))
BEGIN

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseShippingData
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn
   AND shippingDatum_trackingId = trackingIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE shippingDataDeleteAll(transactionIdIn INT)
BEGIN

SET FOREIGN_KEY_CHECKS=0;

UPDATE BaseShippingData
   SET deleted = TRUE
 WHERE transaction_transactionId = transactionIdIn;

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
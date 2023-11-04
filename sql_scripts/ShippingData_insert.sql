DELIMITER //

CREATE PROCEDURE shippingDataInsert(
       transaction_transactionIdIN INT,
       shippingDatum_trackingIdIN VARCHAR(128),
       shippingDatum_destinationAddressIN VARCHAR(256),
       shippingDatum_shippingCostIN DECIMAL(8,2),
       shippingDatum_shippingServiceIN DECIMAL(8,2),
       shippingDatum_itemArrivedBoolIN BOOLEAN
    )
BEGIN

INSERT INTO BaseShippingData (
       transaction_transactionId,
       shippingDatum_trackingId,
       shippingDatum_destinationAddress,
       shippingDatum_shippingCost,
       shippingDatum_shippingService,
       shippingDatum_itemArrivedBool
       )
VALUES (
       transaction_transactionIdIN,
       shippingDatum_trackingIdIN,
       shippingDatum_destinationAddressIN,
       shippingDatum_shippingCostIN,
       shippingDatum_shippingServiceIN,
       shippingDatum_itemArrivedBoolIN
       );

END;
//

DELIMITER ;
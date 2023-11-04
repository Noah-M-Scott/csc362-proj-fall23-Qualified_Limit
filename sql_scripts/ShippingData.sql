CREATE TABLE BaseShippingData (
    transaction_transactionId INT,
    shippingDatum_trackingId VARCHAR(128),

    PRIMARY KEY (transaction_transactionId, shippingDatum_trackingId),
    FOREIGN KEY (transaction_transactionId) REFERENCES Transactions (transaction_transactionId),

    shippingDatum_destinationAddress VARCHAR(256),
    shippingDatum_shippingCost DECIMAL(8,2),
    shippingDatum_shippingService VARCHAR(128),
    shippingDatum_itemArrivedBool BOOLEAN,
    deleted BOOLEAN DEFAULT FALSE
);

CREATE VIEW ShippingData AS
SELECT transaction_transactionId,
       shippingDatum_trackingId,
       shippingDatum_destinationAddress,
       shippingDatum_shippingCost,
       shippingDatum_shippingService,
       shippingDatum_itemArrivedBool
       FROM BaseShippingData WHERE deleted = FALSE;

SOURCE ShippingData_insert.sql
SOURCE ShippingData_update.sql
SOURCE ShippingData_delete.sql
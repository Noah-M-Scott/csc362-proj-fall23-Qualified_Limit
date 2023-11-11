USE upward;

CREATE TABLE BaseDiscounts (
    catalogId               INT unsigned NOT NULL UNIQUE,
    priceOffPercent         DECIMAL(3,0) NOT NULL,
    startDate               DATE NOT NULL,
    endDate                 DATE NOT NULL,
    PRIMARY KEY             (catalogId, startDate, endDate),
    FOREIGN KEY             (catalogId) REFERENCES
                                catalog(catalogId),
    deleted                 BOOLEAN DEFAULT FALSE
);

CREATE VIEW discounts AS
SELECT catalogId,      
priceOffPercent,
startDate,
endDate        
  FROM BaseDiscounts
 WHERE deleted = FALSE;

SOURCE Discounts_insert.sql
SOURCE Discounts_delete.sql
SOURCE Discounts_update.sql
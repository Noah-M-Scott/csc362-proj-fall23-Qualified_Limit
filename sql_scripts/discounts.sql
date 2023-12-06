USE upward;

CREATE TABLE BaseDiscounts (
    catalog_catalogId               INT unsigned NOT NULL UNIQUE,
    discount_priceOffPercent        DECIMAL(3,0) NOT NULL,
    discount_startDate              DATE NOT NULL,
    discount_endDate                DATE NOT NULL,
    PRIMARY KEY                     (catalog_catalogId, discount_startDate, discount_endDate),
    FOREIGN KEY                     (catalog_catalogId) REFERENCES Catalog(catalog_catalogId),
    deleted                         BOOLEAN DEFAULT FALSE
);

 -- view for deny delete
CREATE VIEW Discounts AS
SELECT  catalog_catalogId,      
        discount_priceOffPercent,
        discount_startDate,
        discount_endDate        
  FROM BaseDiscounts
 WHERE deleted = FALSE;

SOURCE Discounts_insert.sql
SOURCE Discounts_delete.sql
SOURCE Discounts_update.sql
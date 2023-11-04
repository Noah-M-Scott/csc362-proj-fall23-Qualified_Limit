USE upward;

CREATE TABLE discounts (
    catalogId               INT unsigned NOT NULL UNIQUE,
    priceOffPercent         DECIMAL(3,0) NOT NULL,
    startDate               DATE NOT NULL,
    endDate                 DATE NOT NULL,
    PRIMARY KEY             (catalogId, startDate, endDate),
    FOREIGN KEY             (catalogId) REFERENCES
                                catalog(catalogId)
);
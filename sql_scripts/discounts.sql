USE upwards;

CREATE TABLE descriptions (
    catalogId               INT unsigned NOT NULL Unique,
    priceOffPercent         INT(3) NOT NULL,
    startDate               DATE NOT NULL,
    endDate                 DATE NOT NULL,
    PRIMARY KEY             (catalogId, startDate, endDate),
    FOREIGN KEY             (catalogId) REFERENCES
                                catalog(catalogId)
);
USE upward;

CREATE TABLE catalog (
    catalogId           INT unsigned NOT NULL AUTO_INCREMENT UNIQUE,
    itemName            VARCHAR(150) NOT NULL,
    category            VARCHAR(100) NOT NULL,
    currentPrice        DECIMAL(7,2) NOT NULL,
    dateFirstAvailable  DATETIME DEFAULT CURDATE(),
    numberInStock       INT(5) NOT NULL,
    manufacturer        VARCHAR(80) NOT NULL,
    PRIMARY KEY         (catalogId)
);
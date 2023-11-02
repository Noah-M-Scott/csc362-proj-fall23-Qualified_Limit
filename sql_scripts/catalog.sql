/* Create the database (dropping the previous version if necessary */
USE upwards;

CREATE TABLE catalog (
    PRIMARY KEY         (catalogId),
    catalogId           INT unsigned NOT NULL AUTO_INCREMENT UNIQUE,
    itemName            VARCHAR(150) NOT NULL,
    category            VARCHAR(100) NOT NULL,
    currentPrice        DECIMAL(7,2) NOT NULL,
    dateFirstAvailable  DATETIME DEFAULT CURDATE(),
    numberInStock       INT(5) NOT NULL,
    manufacturer        VARCHAR(80) NOT NULL
);
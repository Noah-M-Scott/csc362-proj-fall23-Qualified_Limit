USE upward;

CREATE TABLE BaseCatalog (
    catalogId           INT unsigned NOT NULL AUTO_INCREMENT UNIQUE,
    itemName            VARCHAR(150) NOT NULL,
    category            VARCHAR(100) NOT NULL,
    currentPrice        DECIMAL(8,2) NOT NULL,
    dateFirstAvailable  DATETIME DEFAULT CURDATE(),
    numberInStock       INT(5) NOT NULL,
    manufacturer        VARCHAR(80) NOT NULL,
    PRIMARY KEY         (catalogId),
    deleted             BOOLEAN DEFAULT FALSE
);

CREATE VIEW catalog AS
SELECT catalogId,
    itemName,
    category,
    currentPrice,
    dateFirstAvailable,
    numberInStock,
    manufacturer
  FROM BaseCatalog
 WHERE deleted = FALSE;

SOURCE Catalog_insert.sql
SOURCE Catalog_delete.sql
SOURCE Catalog_update.sql
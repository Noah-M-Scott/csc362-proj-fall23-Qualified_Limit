USE upward;

CREATE TABLE BaseCatalog (
    catalog_catalogId           INT unsigned NOT NULL AUTO_INCREMENT UNIQUE,
    catalog_itemName            VARCHAR(128) NOT NULL,
    catalog_category            VARCHAR(128) NOT NULL,
    catalog_currentPrice        DECIMAL(6,2) NOT NULL,
    catalog_dateFirstAvailable  DATETIME DEFAULT CURDATE(),
    catalog_numberInStock       INT NOT NULL,
    catalog_manufacturer        VARCHAR(128) NOT NULL,
    description_Id              INT,
    PRIMARY KEY                 (catalog_catalogId),
    FOREIGN KEY                 (description_Id) REFERENCES Descriptions(description_Id),
    deleted                     BOOLEAN DEFAULT FALSE
);

CREATE VIEW Catalog AS
SELECT  catalog_catalogId,
        catalog_itemName,
        catalog_category,
        catalog_currentPrice,
        catalog_dateFirstAvailable,
        catalog_numberInStock,
        catalog_manufacturer,
        description_Id
  FROM BaseCatalog
 WHERE deleted = FALSE;

SOURCE Catalog_insert.sql
SOURCE Catalog_delete.sql
SOURCE Catalog_update.sql
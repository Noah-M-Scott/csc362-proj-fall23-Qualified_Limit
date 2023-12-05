USE upward;

CREATE TABLE BaseEOLItems (
    catalog_catalogId               INT unsigned NOT NULL UNIQUE,
    EOL_dateDiscontinued            DATE NOT NULL,
    PRIMARY KEY                     (catalog_catalogId, EOL_dateDiscontinued),
    FOREIGN KEY                     (catalog_catalogId) REFERENCES Catalog(catalog_catalogId),       
    deleted                         BOOLEAN DEFAULT FALSE
);


CREATE VIEW EOLitems AS
SELECT catalog_catalogId,      
       EOL_dateDiscontinued
  FROM BaseEOLItems
 WHERE deleted = FALSE;

SOURCE EOLItems_insert.sql
SOURCE EOLItems_delete.sql
SOURCE EOLItems_update.sql
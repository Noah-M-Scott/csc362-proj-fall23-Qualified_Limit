USE upward;

CREATE TABLE BaseEOLItems (
    catalogId               INT unsigned NOT NULL UNIQUE,
    dateDiscontinued        DATE NOT NULL,
    PRIMARY KEY             (catalogId, dateDiscontinued),
    FOREIGN KEY             (catalogId) REFERENCES
                                catalog(catalogId),       
    deleted                 BOOLEAN DEFAULT FALSE
);


CREATE VIEW eolitems AS
SELECT catalogId,      
dateDiscontinued
  FROM BaseEOLItems
 WHERE deleted = FALSE;

SOURCE EOLItems_insert.sql
SOURCE EOLItems_delete.sql
SOURCE EOLItems_update.sql
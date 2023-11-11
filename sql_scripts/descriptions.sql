USE upward;

/*
Problem: Our doc says that catalogId and text should form a CPK. This is unwieldy, and, in fact, 
impossible due to MariaDB limiting a key to 3072 bytes.
*/

CREATE TABLE BaseDescriptions (
    catalogId               INT unsigned NOT NULL UNIQUE,
    text                    VARCHAR(5000),
    FOREIGN KEY             (catalogId) REFERENCES
                                catalog(catalogId),
    PRIMARY KEY             (catalogId),
    deleted                 BOOLEAN DEFAULT FALSE
);

CREATE VIEW descriptions AS
SELECT catalogId,
       text
  FROM BaseDescriptions
 WHERE deleted = FALSE;

SOURCE Descriptions_insert.sql
SOURCE Descriptions_delete.sql
SOURCE Descriptions_update.sql
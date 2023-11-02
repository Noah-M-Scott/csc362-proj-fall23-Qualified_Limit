USE upward;

/*
Problem: Our doc says that catalogId and text should form a CPK. This is unwieldy, and, in fact, 
impossible due to MariaDB limiting a key to 3072 bytes.
*/

CREATE TABLE descriptions (
    catalogId               INT unsigned NOT NULL UNIQUE,
    text                    VARCHAR(5000),
    FOREIGN KEY             (catalogId) REFERENCES
                                catalog(catalogId),
    PRIMARY KEY             (catalogId)
)
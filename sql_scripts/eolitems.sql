USE upward;

CREATE TABLE eolitems (
    catalogId               INT unsigned NOT NULL UNIQUE,
    dateDiscontinued        DATE NOT NULL,
    PRIMARY KEY             (catalogId, dateDiscontinued),
    FOREIGN KEY             (catalogId) REFERENCES
                                catalog(catalogId)       
);
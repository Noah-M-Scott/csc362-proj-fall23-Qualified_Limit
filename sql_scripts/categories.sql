USE upward;

CREATE TABLE BaseCategories (
    categoryId              INT unsigned NOT NULL UNIQUE,
    categorName             VARCHAR(32) NOT NULL,
    deleted                 BOOLEAN DEFAULT FALSE
);

CREATE VIEW descriptions AS
SELECT categoryId,
       categoryName
  FROM BaseCategories
USE upward;

CREATE TABLE BaseCategories (
    categoryId              INT unsigned NOT NULL AUTO_INCREMENT UNIQUE,
    categoryName            VARCHAR(32) NOT NULL,
    deleted                 BOOLEAN DEFAULT FALSE
);

CREATE VIEW categories AS
SELECT categoryId,
       categoryName
  FROM BaseCategories;

SOURCE Categories_insert.sql
SOURCE Categories_delete.sql
SOURCE Categories_update.sql
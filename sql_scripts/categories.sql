USE upward;

CREATE TABLE BaseCategories (
    catagory_categoryId              INT unsigned NOT NULL AUTO_INCREMENT UNIQUE,
    catagory_categoryName            VARCHAR(32) NOT NULL,
    deleted                 BOOLEAN DEFAULT FALSE
);

 -- view for deny delete
CREATE VIEW Categories AS
SELECT catagory_categoryId,
       catagory_categoryName
  FROM BaseCategories;

SOURCE Categories_insert.sql
SOURCE Categories_delete.sql
SOURCE Categories_update.sql
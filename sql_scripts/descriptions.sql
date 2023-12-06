USE upward;


CREATE TABLE BaseDescriptions (
    description_Id               INT unsigned NOT NULL UNIQUE,
    description_text             VARCHAR(4096),
    PRIMARY KEY                  (description_Id),
    deleted                      BOOLEAN DEFAULT FALSE
);

 -- view for deny delete
CREATE VIEW Descriptions AS
SELECT description_Id,
       description_text
  FROM BaseDescriptions
 WHERE deleted = FALSE;

SOURCE Descriptions_insert.sql
SOURCE Descriptions_delete.sql
SOURCE Descriptions_update.sql
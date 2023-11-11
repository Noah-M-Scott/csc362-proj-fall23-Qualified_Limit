USE upward;

CREATE TABLE  accounts (
    accountId               INT NOT NULL AUTO_INCREMENT UNIQUE,
    accountEmail            VARCHAR(80) NOT NULL UNIQUE,
    accountPhone            CHAR(10),
    userName                VARCHAR(30) NOT NULL,
    userPassWord            VARCHAR(30) NOT NULL,
    PRIMARY KEY             (accountId)
);

SOURCE accounts_insert.sql
SOURCE accounts_delete.sql
SOURCE accounts_update.sql
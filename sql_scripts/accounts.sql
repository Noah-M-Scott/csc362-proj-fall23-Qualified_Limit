USE upward;

CREATE TABLE  Accounts (
    account_accountId               INT NOT NULL AUTO_INCREMENT UNIQUE,
    account_accountEmail            VARCHAR(128) NOT NULL UNIQUE,
    account_phone                   CHAR(10),
    account_userName                VARCHAR(32) NOT NULL,
    account_userPassWord            VARCHAR(32) NOT NULL,
    PRIMARY KEY                     (account_accountId)
);

SOURCE accounts_insert.sql
SOURCE accounts_delete.sql
SOURCE accounts_update.sql
USE upward;

CREATE TABLE accounts (
    accountId               INT(9) NOT NULL AUTO_INCREMENT UNIQUE,
    accountEmail            VARCHAR(80) NOT NULL UNIQUE,
    accountPhone            INT(12),
    userName                VARCHAR(30) NOT NULL,
    PRIMARY KEY             (accountId)
);

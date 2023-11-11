USE upward;

CREATE TABLE accounts (
    accountId               INT(9) NOT NULL AUTO_INCREMENT UNIQUE,
    accountEmail            VARCHAR(80) NOT NULL UNIQUE,
    accountPhone            CHAR(10),
    userName                VARCHAR(30) NOT NULL,
    userPassWord            VARCHAR(30) NOT NULL,
    PRIMARY KEY             (accountId)
);

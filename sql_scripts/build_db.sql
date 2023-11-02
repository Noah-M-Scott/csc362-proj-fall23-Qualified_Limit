DROP DATABASE IF EXISTS upward;
CREATE DATABASE upward;
USE upward;



SOURCE catalog.sql;
SOURCE discounts.sql;
SOURCE descriptions.sql;
SOURCE accounts.sql;
SOURCE eolitems.sql;

/*
    The following scripts cannot be fully tested yet, as they reference tables which I will not be creating.

    SOURCE returns.sql;
    SOURCE warranties.sql;
*/

SHOW TABLES;




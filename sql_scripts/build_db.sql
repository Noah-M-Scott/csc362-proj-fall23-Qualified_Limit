DROP DATABASE IF EXISTS upward;
CREATE DATABASE upward;
USE upward;

SET FOREIGN_KEY_CHECKS=0;
SOURCE catalog.sql;
SOURCE descriptions.sql;
SOURCE discounts.sql;
SOURCE accounts.sql;
SOURCE categories.sql;
SOURCE eolitems.sql;
SOURCE Transactions.sql;
SOURCE WarrantyClaims.sql;
SOURCE ShippingData.sql;
SOURCE Exchanges.sql;
SOURCE FinancialData.sql;
SOURCE returns.sql;
SOURCE warranties.sql;


CALL categoryInsertion('Rope');
CALL categoryInsertion('Shoes');
CALL categoryInsertion('Cables');


SET FOREIGN_KEY_CHECKS=1;

SHOW TABLES;




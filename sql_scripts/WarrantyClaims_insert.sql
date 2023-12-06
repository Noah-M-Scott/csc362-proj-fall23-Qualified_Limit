DELIMITER //

CREATE PROCEDURE warrantyClaimInsert(
       warranty_warrantyIdIN INT, 
       warrantyClaim_claimIN VARCHAR(1024)
    )
BEGIN

SET FOREIGN_KEY_CHECKS=0;

INSERT INTO BaseWarrantyClaims (
       warranty_warrantyId,
       warrantyClaim_claim
       )
VALUES (
       warranty_warrantyIdIN, 
       warrantyClaim_claimIN
       );

SET FOREIGN_KEY_CHECKS=1;

END;
//

DELIMITER ;
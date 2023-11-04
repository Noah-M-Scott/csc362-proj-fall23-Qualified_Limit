DELIMITER //

CREATE PROCEDURE warrantyClaimsInsert(
       warranty_warrantyIdIN INT, 
       warrantyClaim_claimIN VARCHAR(1024)
    )
BEGIN

INSERT INTO BaseWarrantyClaims (
       warranty_warrantyId,
       warrantyClaim_claim
       )
VALUES (
       warranty_warrantyIdIN, 
       warrantyClaim_claimIN
       );

END;
//

DELIMITER ;
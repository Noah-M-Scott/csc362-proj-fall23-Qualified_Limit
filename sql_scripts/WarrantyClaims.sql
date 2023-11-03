CREATE TABLE BaseWarrantyClaims (
    warranty_warrantyId INT unsigned,
    warrantyClaim_claim VARCHAR(1024),

    FOREIGN KEY (warranty_warrantyId) REFERENCES warranties(warrantyId),
    PRIMARY KEY (warranty_warrantyId),
    deleted BOOLEAN DEFAULT FALSE
);

CREATE VIEW WarrantyClaims AS
SELECT warranty_warrantyId, warrantyClaim_claim
  FROM BaseWarrantyClaims
 WHERE deleted = FALSE;
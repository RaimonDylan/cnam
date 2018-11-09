
# Exercice TRIGGER

## Exercice 1

### Créer table
```SQL
CREATE TABLE NbPlacesParType
(
type INTEGER NOT NULL,
nbEmpl VARCHAR(50) NOT NULL,
PRIMARY KEY(type)
);
```

### Alimenter la table
```SQL
INSERT INTO NbPlacesParType ( type, nbEmpl )
SELECT  type, count(*) as nbEmpl
FROM    emplacement
GROUP BY type
```

### TRIGGER
```SQL
CREATE TRIGGER updateNbEmpl
AFTER INSERT
ON EMPLACEMENT
FOR EACH ROW
EXECUTE PROCEDURE updateNbEmpl()
```
```SQL
CREATE OR REPLACE FUNCTION updateNbEmpl()
RETURNS TRIGGER
AS $$
BEGIN
UPDATE NbPlacesParType SET nbEmpl = nbEmpl + 1 FROM NbPlacesParType WHERE type = new.TypeEmpl
END;
$$ LANGUAGE PLPGSQL;

```

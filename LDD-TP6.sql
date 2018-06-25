 DROP TABLE BONLOCATION CASCADE CONSTRAINTS;
DROP TABLE PREFERE CASCADE CONSTRAINTS;
DROP TABLE AGENCE CASCADE CONSTRAINTS;
DROP TABLE VEHICULE CASCADE CONSTRAINTS;
DROP TABLE CLASSE CASCADE CONSTRAINTS;
DROP TABLE CLIENT CASCADE CONSTRAINTS;
DROP TABLE EMPLOYE CASCADE CONSTRAINTS;



-------------------------
-- Création des tables
-------------------------

CREATE TABLE AGENCE
   (
    CodeAgence CHAR(5)  NOT NULL,
    VilleAgence VARCHAR2(50),   
    CONSTRAINT PK_AGENCE PRIMARY KEY (CodeAgence)  
   ) ;
   
CREATE TABLE BONLOCATION
   (
    NumBonLocation NUMBER(10)  NOT NULL,
    NumClient NUMBER(10)  NOT NULL,
    NumImmat VARCHAR2(50)  NOT NULL,
    DateDebut DATE  NULL,
    DateFin DATE  NULL,
    Km NUMBER(10)  NULL,   
    CONSTRAINT PK_BONDELOCATION PRIMARY KEY (NumBonLocation)  
   ) ;

CREATE TABLE VEHICULE
   (
    NumImmat VARCHAR2(20)  NOT NULL,
    CodeAgence CHAR(5)  NULL,
    CodeClasse VARCHAR(10)  NOT NULL,
    KmVehicule NUMBER(10)  NULL,   
    CONSTRAINT PK_VEHICULE PRIMARY KEY (NumImmat)  
   ) ;

CREATE TABLE CLIENT
   (
    NumClient NUMBER(10)  NOT NULL,
    NomClient VARCHAR2(50)  NOT NULL,
    VilleClient VARCHAR2(50)  NULL,   
    CONSTRAINT PK_CLIENT PRIMARY KEY (NumClient)  
   ) ;

CREATE TABLE CLASSE
   (
    CodeClasse VARCHAR(10)  NOT NULL,
    NomClasse VARCHAR2(50)  NULL,
    PRIX_KM NUMBER(10,2)  NULL,   
    CONSTRAINT PK_CLASSE PRIMARY KEY (CodeClasse)  
   ) ;

CREATE TABLE PREFERE
   (
    NumClient NUMBER(32)  NOT NULL,
    CodeClasse VARCHAR(10)  NOT NULL,
    NOTE NUMBER(10)  NULL,   
    CONSTRAINT PK_PREFERE PRIMARY KEY (NumClient, CodeClasse)  
   ) ;
   
CREATE TABLE EMPLOYE
   (
    NumEmploye NUMBER(4)  NOT NULL,
    NomEmploye VARCHAR2(20)  NOT NULL,
    PrenomEmploye VARCHAR2(20)  NOT NULL,
    Salaire NUMBER(6),
    Fonction VARCHAR2(20),
    CodeAgence CHAR(5),
    CONSTRAINT PK_EMPLOYE PRIMARY KEY (NumEmploye)  
   ) ;

-------------------------
-- Ajout des contraintes
-------------------------

ALTER TABLE VEHICULE ADD (
     CONSTRAINT FK_VEHICULE_VILLE  FOREIGN KEY (CodeAgence)  REFERENCES Agence (CodeAgence) ,
	   CONSTRAINT FK_VEHICULE_CLASSE FOREIGN KEY (CodeClasse)  REFERENCES CLASSE (CodeClasse)
	 )   ;

ALTER TABLE BONLOCATION ADD (
     CONSTRAINT FK_BONLOCATION_CLIENT   FOREIGN KEY (NumClient)  REFERENCES CLIENT (NumClient),
	 CONSTRAINT FK_BONLOCATION_VEHICULE FOREIGN KEY (NumImmat)   REFERENCES VEHICULE (NumImmat)
	 )   ;
	 
ALTER TABLE PREFERE ADD (
     CONSTRAINT FK_PREFERE_CLIENT FOREIGN KEY (NumClient)  REFERENCES CLIENT (NumClient),
	 CONSTRAINT FK_PREFERE_CLASSE FOREIGN KEY (CodeClasse) REFERENCES CLASSE (CodeClasse)
	 )   ;
     
ALTER TABLE EMPLOYE ADD (
     CONSTRAINT CK_EMPLOYE_SALAIRE CHECK (SALAIRE > 0) ) ;

ALTER TABLE EMPLOYE ADD (
     CONSTRAINT FK_EMPLOYE_AGENCE FOREIGN KEY (CodeAgence) REFERENCES AGENCE(CodeAgence)
     ) ;
                 
-------------------------
-- Insertion des données
-------------------------               
               
insert into agence values ('AG01','DIJON');
insert into agence values ('AG02','PARIS');
insert into agence values ('AG03','LYON');
insert into agence values ('AG04','BORDEAUX');
insert into agence values ('AG05','NANTES');
insert into agence values ('AG06','MARSEILLE');

insert into classe values ('CL_001','CITADINE',5.00);
insert into classe values ('CL_002','BERLINE',7.00);
insert into classe values ('CL_003','BERLINE DE LUXE',10.00);
insert into classe values ('CL_004','SPORTIVE',8.00);
insert into classe values ('CL_005','UTILITAIRE LEGER',2.00);
insert into classe values ('CL_006','UTILITAIRE LOURD',3.00);

insert into vehicule values ('1626 VS 21','AG01','CL_001',20000);
insert into vehicule values ('3245 WWF 21','AG01','CL_002',40000);
insert into vehicule values ('3278 KL 75','AG02','CL_006',120000);
insert into vehicule values ('4356 RU 75','AG02','CL_003',60500);
insert into vehicule values ('4578 RT 21','AG01','CL_006',100000);
insert into vehicule values ('5675 ZT 75','AG04','CL_001',34000);
insert into vehicule values ('6799 VF 69','AG03','CL_002',23000);
insert into vehicule values ('7865 RT 75','AG02','CL_003',50000);
insert into vehicule values ('8776 WZ 13','AG06','CL_006',23000);
insert into vehicule values ('8967 WS 69','AG03','CL_003',12000);
insert into vehicule values ('9023 RS 69','AG03','CL_004',34000);
insert into vehicule values ('0987 VD 62','AG04','CL_004',60000);
insert into vehicule values ('1243 WD 75','AG01','CL_005',75000);

insert into client values (1,'BERNARD','DIJON');
insert into client values (2,'DUPOND','DIJON');
insert into client values (3,'BAILLEKAR','LYON');
insert into client values (4,'MARTIN','LYON');
insert into client values (5,'SCOTT','MARSEILLE');
insert into client values (6,'SMITH','PARIS');
insert into client values (7,'JAMES','PARIS');
insert into client values (8,'DUPOND','PARIS');
insert into client values (9,'HARDY','LILLE');
insert into client values (10,'DUPOND','LILLE');
insert into client values (11,'DURANT','LILLE');

insert into bonlocation values (1,1,'0987 VD 62',TO_DATE('11/03/2002','DD/MM/YYYY'),TO_DATE('15/05/2002','DD/MM/YYYY'),800);
insert into bonlocation values (2,2,'0987 VD 62',TO_DATE('16/03/2002','DD/MM/YYYY'),TO_DATE('17/05/2002','DD/MM/YYYY'),150);
insert into bonlocation values (3,2,'1243 WD 75',TO_DATE('13/09/2002','DD/MM/YYYY'),TO_DATE('15/09/2002','DD/MM/YYYY'),340);
insert into bonlocation values (4,3,'1243 WD 75',TO_DATE('16/09/2002','DD/MM/YYYY'),null,null);
insert into bonlocation values (5,4,'1243 WD 75',TO_DATE('13/09/2002','DD/MM/YYYY'),null,null);
insert into bonlocation values (12,5,'1243 WD 75',TO_DATE('18/09/2002','DD/MM/YYYY'),TO_DATE('20/09/2002','DD/MM/YYYY'),400);
insert into bonlocation values (10,4,'1626 VS 21',TO_DATE('01/04/2002','DD/MM/YYYY'),TO_DATE('04/04/2002','DD/MM/YYYY'),500);
insert into bonlocation values (6,7,'3245 WWF 21',TO_DATE('12/07/2002','DD/MM/YYYY'),TO_DATE('15/07/2002','DD/MM/YYYY'),450);
insert into bonlocation values (7,8,'3245 WWF 21',TO_DATE('16/02/2002','DD/MM/YYYY'),TO_DATE('25/02/2002','DD/MM/YYYY'),1600);
insert into bonlocation values (8,1,'5675 ZT 75',TO_DATE('12/12/2001','DD/MM/YYYY'),TO_DATE('14/12/2001','DD/MM/YYYY'),234);
insert into bonlocation values (9,2,'5675 ZT 75',TO_DATE('15/12/2001','DD/MM/YYYY'),TO_DATE('24/12/2001','DD/MM/YYYY'),2000);
insert into bonlocation values (11,5,'7865 RT 75',TO_DATE('01/05/2002','DD/MM/YYYY'),TO_DATE('02/05/2002','DD/MM/YYYY'),350);

insert into prefere values (1,'CL_001',1);
insert into prefere values (2,'CL_001',2);
insert into prefere values (3,'CL_001',1);
insert into prefere values (4,'CL_001',5);
insert into prefere values (5,'CL_001',4);
insert into prefere values (1,'CL_002',2);
insert into prefere values (2,'CL_002',10);
insert into prefere values (3,'CL_002',10);
insert into prefere values (4,'CL_002',4);
insert into prefere values (5,'CL_002',3);
insert into prefere values (1,'CL_003',10);
insert into prefere values (2,'CL_003',1);
insert into prefere values (3,'CL_003',5);
insert into prefere values (4,'CL_003',3);
insert into prefere values (5,'CL_003',1);
insert into prefere values (1,'CL_004',5);
insert into prefere values (2,'CL_004',2);
insert into prefere values (3,'CL_004',3);
insert into prefere values (4,'CL_004',2);
insert into prefere values (5,'CL_004',10);
insert into prefere values (1,'CL_005',6);
insert into prefere values (2,'CL_005',3);
insert into prefere values (3,'CL_005',2);
insert into prefere values (4,'CL_005',1);
insert into prefere values (5,'CL_005',9);
insert into prefere values (1,'CL_006',3);
insert into prefere values (2,'CL_006',4);
insert into prefere values (3,'CL_006',4);
insert into prefere values (4,'CL_006',10);
insert into prefere values (5,'CL_006',8);


insert into employe values(123, 'NEMARD', 'Jean', 2100, 'Agent accueil', 'AG02');
insert into employe values(234, 'AROIDE', 'Paul', 2100, 'Agent accueil', 'AG01');
insert into employe values(345, 'HAUDUVILLAGE', 'Lidye', 2100, 'Agent accueil', 'AG02');
insert into employe values(456, 'BIDJOBAT', 'Joe', 2150, 'Mécanicien', 'AG01');
insert into employe values(567, 'PLOUE DE BRIERES', 'Roger',2000, 'Informaticien', 'AG04');
insert into employe values(678, 'MEURDESOIF', 'Jean', 1900, 'Qualiticien', 'AG05');
insert into employe values(789, 'RENAUT', 'Megane', 1820, 'Secrétaire', 'AG06');
insert into employe values(890, 'DIOT', 'Kelly', 3300, 'Sous-chef', 'AG05');
insert into employe values(901, 'PROVISTE', 'Alain', 5000, 'Chef', 'AG01');
insert into employe values(100, 'COURCI', 'Sarah', 1360, 'Agent accueil', 'AG02');


/*Partie 1*/
/*1*/
CREATE OR REPLACE FUNCTION getSalaire
  (p_nomEmp IN Employe.nomEmploye%TYPE)
  RETURN Employe.Salaire%TYPE
IS
  l_salaire Employe.Salaire%TYPE;
BEGIN
  SELECT Employe.salaire
  INTO l_salaire
  FROM Employe
  WHERE UPPER(Employe.nomEmploye) = UPPER(p_nomEmp);
  RETURN l_salaire;
END;
/

SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE(getSalaire('NEMARD'));
END;
/

/*2*/
CREATE OR REPLACE FUNCTION changeSalaire
  (p_fonction IN Employe.fonction%TYPE, p_pourcentage IN NUMBER)
  RETURN NUMBER
IS
  l_nbEmployeAugmente NUMBER;
BEGIN
  UPDATE Employe
  SET Employe.salaire = Employe.salaire + (Employe.Salaire*(p_pourcentage/100))
  WHERE Employe.fonction = p_fonction;
  
  SELECT COUNT(*)
  INTO l_nbEmployeAugmente
  FROM Employe
  WHERE Employe.fonction = p_fonction;
  
  RETURN l_nbEmployeAugmente;
END;
/

SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE(changeSalaire('Informaticien', 10));
  DBMS_OUTPUT.PUT_LINE(getSalaire('PLOUE DE BRIERES'));
END;
/

/*3*/
CREATE OR REPLACE FUNCTION transfertVehicule
  (p_agenceEmettrice IN Agence.codeAgence%TYPE, p_agenceReceptrice IN Agence.codeAgence%TYPE)
  RETURN NUMBER
IS
  l_nbVehicule NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO l_nbVehicule
  FROM Vehicule
  WHERE Vehicule.codeAgence = p_agenceEmettrice;
  
  UPDATE Vehicule
  SET Vehicule.codeAgence = p_agenceReceptrice
  WHERE Vehicule.codeAgence = p_agenceEmettrice;
  
  DELETE
  FROM Agence
  WHERE Agence.codeAgence = p_agenceEmettrice;
  
  RETURN l_nbVehicule;
END;
/

SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE(transfertVehicule('AG03', 'AG01'));
END;
/

/*4*/
CREATE OR REPLACE FUNCTION transfertVehicule
  (p_agenceEmettrice IN Agence.codeAgence%TYPE, p_agenceReceptrice IN Agence.codeAgence%TYPE)
  RETURN NUMBER
IS
  l_nbVehicule NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO l_nbVehicule
  FROM Vehicule
  WHERE Vehicule.codeAgence = p_agenceEmettrice;
  
  UPDATE Vehicule
  SET Vehicule.codeAgence = p_agenceReceptrice
  WHERE Vehicule.codeAgence = p_agenceEmettrice;
  
  DELETE
  FROM Agence
  WHERE Agence.codeAgence = p_agenceEmettrice;
  
  RETURN l_nbVehicule;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -02292 THEN
      DBMS_OUTPUT.PUT_LINE('On essaye de supprimer une agence qui possède des employés.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Erreur Oracle ' || SQLERRM || '(' || SQLCODE || ')');
    END IF;
    DBMS_OUTPUT.PUT_LINE('On retourne donc :');
    RETURN -1;
END;
/

SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE(transfertVehicule('AG02', 'AG01'));
END;
/

SELECT *
FROM Vehicule; /*Les vehicules de l'agence de Paris ont été supprimé.*/
/

SELECT *
FROM Agence; /*L'agence de Paris a été supprimé.*/
/

SELECT *
FROM Employe; /*Les employes de l'angence de Paris n'ont pas été supprimé.*/
/

/*5*/
CREATE OR REPLACE FUNCTION transfertVehicule
  (p_agenceEmettrice IN Agence.codeAgence%TYPE, p_agenceReceptrice IN Agence.codeAgence%TYPE)
  RETURN NUMBER
IS
  l_nbVehicule NUMBER;
  e_fk_employe_agence EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_fk_employe_agence, -02292); 
BEGIN
  SELECT COUNT(*)
  INTO l_nbVehicule
  FROM Vehicule
  WHERE Vehicule.codeAgence = p_agenceEmettrice;
  
  UPDATE Vehicule
  SET Vehicule.codeAgence = p_agenceReceptrice
  WHERE Vehicule.codeAgence = p_agenceEmettrice;
  
  DELETE
  FROM Agence
  WHERE Agence.codeAgence = p_agenceEmettrice;
  
  RETURN l_nbVehicule;
EXCEPTION
  WHEN e_fk_employe_agence THEN
    DBMS_OUTPUT.PUT_LINE('On essaye de supprimer une agence qui possède des employés.');
    DBMS_OUTPUT.PUT_LINE('On retourne donc :');
    RETURN -1;
END;
/

SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE(transfertVehicule('AG02', 'AG01'));
END;
/


/*Partie2*/
/*1*/
DECLARE
  CURSOR c_user_tables IS (SELECT object_name, object_type
                            FROM user_objects WHERE object_type = 'TABLE');
BEGIN
  FOR l_user_tables IN c_user_tables LOOP
    EXECUTE IMMEDIATE 'DROP ' || l_user_tables.object_type || ' ' || l_user_tables.object_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;
/

SELECT object_name, object_type
FROM user_objects WHERE object_type = 'TABLE';
/

/*2*/
CREATE OR REPLACE PROCEDURE supprimerTable
IS
  CURSOR c_user_tables IS (SELECT object_name, object_type
                            FROM user_objects WHERE object_type = 'TABLE');
BEGIN
  FOR l_user_tables IN c_user_tables LOOP
    EXECUTE IMMEDIATE 'DROP ' || l_user_tables.object_type || ' ' || l_user_tables.object_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;
/

EXECUTE supprimerTable();



/*Partie3*/
/*1*/
CREATE OR REPLACE PACKAGE package_TP6 IS
/*1*/
  FUNCTION getSalaire
    (p_nomEmp IN Employe.nomEmploye%TYPE)
  RETURN Employe.Salaire%TYPE;
/*2*/
  FUNCTION changeSalaire
    (p_fonction IN Employe.fonction%TYPE, p_pourcentage IN NUMBER)
  RETURN NUMBER;
/*3*/
  FUNCTION transfertVehicule
    (p_agenceEmettrice IN Agence.codeAgence%TYPE, p_agenceReceptrice IN Agence.codeAgence%TYPE)
  RETURN NUMBER;
/*4*/
  PROCEDURE supprimerTable;
END package_TP6;
/


CREATE OR REPLACE PACKAGE BODY package_TP6 IS
/*1*/
  FUNCTION getSalaire
    (p_nomEmp IN Employe.nomEmploye%TYPE)
    RETURN Employe.Salaire%TYPE
  IS
    l_salaire Employe.Salaire%TYPE;
  BEGIN
    SELECT Employe.salaire
    INTO l_salaire
    FROM Employe
    WHERE UPPER(Employe.nomEmploye) = UPPER(p_nomEmp);
    RETURN l_salaire;
  END; 
/*2*/
  FUNCTION changeSalaire
    (p_fonction IN Employe.fonction%TYPE, p_pourcentage IN NUMBER)
    RETURN NUMBER
  IS
    l_nbEmployeAugmente NUMBER;
  BEGIN
    UPDATE Employe
    SET Employe.salaire = Employe.salaire + (Employe.Salaire*(p_pourcentage/100))
    WHERE Employe.fonction = p_fonction;
    
    SELECT COUNT(*)
    INTO l_nbEmployeAugmente
    FROM Employe
    WHERE Employe.fonction = p_fonction;
    
    RETURN l_nbEmployeAugmente;
  END;
/*3*/
  FUNCTION transfertVehicule
    (p_agenceEmettrice IN Agence.codeAgence%TYPE, p_agenceReceptrice IN Agence.codeAgence%TYPE)
    RETURN NUMBER
  IS
    l_nbVehicule NUMBER;
    e_fk_employe_agence EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_fk_employe_agence, -02292); 
  BEGIN
    SELECT COUNT(*)
    INTO l_nbVehicule
    FROM Vehicule
    WHERE Vehicule.codeAgence = p_agenceEmettrice;
    
    UPDATE Vehicule
    SET Vehicule.codeAgence = p_agenceReceptrice
    WHERE Vehicule.codeAgence = p_agenceEmettrice;
    
    DELETE
    FROM Agence
    WHERE Agence.codeAgence = p_agenceEmettrice;
    
    RETURN l_nbVehicule;
  EXCEPTION
    WHEN e_fk_employe_agence THEN
      DBMS_OUTPUT.PUT_LINE('On essaye de supprimer une agence qui possède des employés.');
      DBMS_OUTPUT.PUT_LINE('On retourne donc :');
      RETURN -1;
  END;
/*4*/
  PROCEDURE supprimerTable
  IS
    CURSOR c_user_tables IS (SELECT object_name, object_type
                              FROM user_objects WHERE object_type = 'TABLE');
  BEGIN
    FOR l_user_tables IN c_user_tables LOOP
      EXECUTE IMMEDIATE 'DROP ' || l_user_tables.object_type || ' ' || l_user_tables.object_name || ' CASCADE CONSTRAINTS';
    END LOOP;
  END;
END package_TP6;
/

/*2*/
EXECUTE package_TP6.supprimerTable();
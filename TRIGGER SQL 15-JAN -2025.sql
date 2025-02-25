-- TRIGGERS IN MYSQL
-- IN MYSQL TRIGGER IS A DAtabase object that is automatically-- 
-- executed or fired in response to certain events or action likr(Update,After,Before,etc)

-- Triggers are used to enforce business rules that maintain data integrity and automate task within database.


CREATE DATABASE SBIBANK;
USE SBIBANK;
CREATE TABLE MAIN_TABLE(
CUS_ID INT AUTO_INCREMENT PRIMARY KEY,
CUS_NAME VARCHAR(50),
CUS_ACC_NO BIGINT UNIQUE,
CUS_MOB_NO BIGINT UNIQUE,
CUS_BALANCE BIGINT,
CUS_CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CUS_UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 

CREATE TABLE BACKUP_TABLE(
CUS_ID INT ,
CUS_NAME VARCHAR(50),
CUS_ACC_NO BIGINT UNIQUE,
CUS_MOB_NO BIGINT UNIQUE,
CUS_BALANCE BIGINT,
CUS_CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CUS_UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CUS_DELETED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP); 

-- CREATING TRIGGER 
DELIMITER //
CREATE TRIGGER BEFORE_MAIN_TABLE_DELETE
BEFORE DELETE ON MAIN_TABLE
FOR EACH ROW
     BEGIN
       INSERT INTO BACKUP_TABLE(CUS_ID,CUS_NAME,CUS_ACC_NO,
           CUS_MOB_NO,CUS_BALANCE,CUS_CREATED_AT,CUS_UPDATED_AT)
           VALUES(OLD.CUS_ID,
           OLD.CUS_NAME,
           OLD.CUS_ACC_NO,
           OLD.CUS_MOB_NO,
           OLD.CUS_BALANCE,
           OLD.CUS_CREATED_AT,
           OLD.CUS_UPDATED_AT);
		    END;
			//
        DELIMITER ;
INSERT INTO MAIN_TABLE(CUS_NAME,CUS_ACC_NO,CUS_MOB_NO,CUS_BALANCE)
VALUES('DEV',8512348,7978787878,90000);

UPDATE MAIN_TABLE SET CUS_BALANCE=40000 WHERE CUS_NAME='DEV';
SELECT * FROM MAIN_TABLE;
           
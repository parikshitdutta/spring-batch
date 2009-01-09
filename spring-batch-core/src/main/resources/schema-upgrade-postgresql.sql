-- Autogenerated: do not edit this file

-- Upgrades an existing 1.0 schema to version 1.1.

CREATE TABLE BATCH_STEP_EXECUTION_CONTEXT  (
	STEP_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
	SHORT_CONTEXT VARCHAR(2500) NOT NULL,
	SERIALIZED_CONTEXT TEXT , 
	constraint STEP_EXEC_CTX_FK foreign key (STEP_EXECUTION_ID)
	references BATCH_STEP_EXECUTION(STEP_EXECUTION_ID)
) ;

CREATE TABLE BATCH_JOB_EXECUTION_CONTEXT  (
	JOB_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
	SHORT_CONTEXT VARCHAR(2500) NOT NULL,
	SERIALIZED_CONTEXT TEXT , 
	constraint JOB_EXEC_CTX_FK foreign key (JOB_EXECUTION_ID)
	references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
) ;

INSERT INTO BATCH_EXECUTION_CONTEXT (EXECUTION_ID, DISCRIMINATOR, TYPE_CD, KEY_NAME, STRING_VAL, DATE_VAL, LONG_VAL, DOUBLE_VAL, OBJECT_VAL)
SELECT STEP_EXECUTION_ID, 'S', TYPE_CD, KEY_NAME, STRING_VAL, DATE_VAL, LONG_VAL, DOUBLE_VAL, OBJECT_VAL FROM BATCH_STEP_EXECUTION_CONTEXT;
DROP TABLE BATCH_STEP_EXECUTION_CONTEXT;
ALTER TABLE BATCH_JOB_EXECUTION ADD CREATE_TIME TIMESTAMP;
UPDATE BATCH_JOB_EXECUTION SET CREATE_TIME = START_TIME;
ALTER TABLE BATCH_JOB_EXECUTION ALTER COLUMN CREATE_TIME SET NOT NULL;
ALTER TABLE BATCH_STEP_EXECUTION ADD READ_SKIP_COUNT BIGINT;
ALTER TABLE BATCH_STEP_EXECUTION ADD WRITE_SKIP_COUNT BIGINT;
ALTER TABLE BATCH_STEP_EXECUTION ADD ROLLBACK_COUNT BIGINT;  
ALTER TABLE BATCH_STEP_EXECUTION DROP COLUMN CONTINUABLE;  
ALTER TABLE BATCH_JOB_EXECUTION DROP COLUMN CONTINUABLE;  

BEGIN TRANSACTION

CREATE TABLE DEPARTMENT_HOSP(
	DEPARTMENT_ID VARCHAR(10) PRIMARY KEY,
	DEPARTMENT_NAME VARCHAR(20) NOT NULL
	)

CREATE TABLE ADMISSION (
	PATIENT_ID BIGINT,
	SSN VARCHAR(10),
	PATIENT_NAME CHAR(30) NOT NULL,
	PATIENT_ADDRESS VARCHAR(50),
	DOB DATE NOT NULL,
	EMAIL VARCHAR(30),
	PHONE_NUMBER VARCHAR(10),
	INSURANCE_NUMBER VARCHAR(10),
	PRIMARY KEY(PATIENT_ID)
)

CREATE TABLE PATIENT_ENCOUNTER(
	ENCOUNTER_ID BIGINT,
	DOCTOR_ID BIGINT,
	PATIENT_ID BIGINT,
	PATIENT_TYPE VARCHAR(10)  NOT NULL CHECK(PATIENT_TYPE IN('OUTDOOR','INDOOR')),
	DEPARTMENT_ID VARCHAR(10),
	ENCOUNTER_DATE DATE,
	PRIMARY KEY(ENCOUNTER_ID, DOCTOR_ID),
	FOREIGN KEY(PATIENT_ID) REFERENCES ADMISSION,
	FOREIGN KEY(DEPARTMENT_ID) REFERENCES DEPARTMENT_HOSP
) 


CREATE TABLE ROOM (
	ROOM_NUMBER VARCHAR(10),
	ROOM_TYPE VARCHAR(7) CHECK(ROOM_TYPE IN('GENERAL','PRIVATE')),
	ROOM_STATUS CHAR(1) CHECK(ROOM_STATUS IN('Y','N','y','n')),
	PRIMARY KEY(ROOM_NUMBER)
)

--ALTER TABLE ROOM ADD ROOM_STATUS CHAR(1) 

CREATE TABLE OUTDOOR_PATIENT (
	ENCOUNTER_ID BIGINT,
	DOCTOR_ID BIGINT,
	PRESCRIPTION VARCHAR(25),
	PRIMARY KEY(ENCOUNTER_ID, DOCTOR_ID),
	FOREIGN KEY(ENCOUNTER_ID, DOCTOR_ID) REFERENCES PATIENT_ENCOUNTER
)

CREATE TABLE INDOOR_PATIENT(
	ENCOUNTER_ID BIGINT,
	DOCTOR_ID BIGINT,
	ADMISSION_DATE DATE NOT NULL,
	RELEASE_DATE DATE,
	TREATMENT_DETAILS VARCHAR(75),
	ROOM_NUMBER VARCHAR(10) NOT NULL,
	PRIMARY KEY(ENCOUNTER_ID,DOCTOR_ID),
	FOREIGN KEY(ENCOUNTER_ID, DOCTOR_ID) REFERENCES PATIENT_ENCOUNTER,
	FOREIGN KEY(ROOM_NUMBER) REFERENCES ROOM
);

CREATE TABLE STAFF(
	STAFF_ID BIGINT,
	STAFF_NAME VARCHAR(30) NOT NULL,
	DESIGNATION VARCHAR(25) NOT NULL,
	STAFF_ADDRESS VARCHAR(50),
	QUALIFICATION VARCHAR(25),
	CELL_NO VARCHAR(10),
	EMAIL VARCHAR(30)
	PRIMARY KEY(STAFF_ID)
)

CREATE TABLE DOCTOR(
	DOCTOR_ID BIGINT,
	DOCTOR_NAME VARCHAR(25),
	DOCTOR_TYPE VARCHAR(25) NOT NULL CHECK(DOCTOR_TYPE IN ('HOSPITAL-RESIDENT','CALL-ON')),
	STAFF_ID BIGINT,
	ENCOUNTER_ID BIGINT,
	DEPARTMENT_ID VARCHAR(10),
	PRIMARY KEY(DOCTOR_ID,ENCOUNTER_ID),
	FOREIGN KEY(DEPARTMENT_ID) REFERENCES DEPARTMENT_HOSP,
	FOREIGN KEY(STAFF_ID) REFERENCES STAFF
	)

--ALTER TABLE DOCTOR ADD DOCTOR_NAME VARCHAR(25)

CREATE TABLE BILLING(
	BILLING_ID BIGINT PRIMARY KEY,
	ENCOUNTER_ID BIGINT,
	DOCTOR_ID BIGINT,
	BILL_AMT MONEY,
	BILL_STATUS VARCHAR(10) CHECK(BILL_STATUS IN ('OPEN','CLOSED','HOLD')),
	FOREIGN KEY(ENCOUNTER_ID,DOCTOR_ID) REFERENCES PATIENT_ENCOUNTER
)

COMMIT TRANSACTION

-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2022-08-20 22:43:37 AEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE availableappointment (
    availableappointmentid VARCHAR2(100) NOT NULL,
    doctorid               VARCHAR2(100) NOT NULL,
    starttime              DATE,
    endtime                DATE,
    "Date"                 DATE
);

ALTER TABLE availableappointment ADD CONSTRAINT availableappointment_pk PRIMARY KEY ( availableappointmentid );

CREATE TABLE bookedappointment (
    appointmentid VARCHAR2(100) NOT NULL,
    patientid     VARCHAR2(100) NOT NULL,
    doctorid      VARCHAR2(100) NOT NULL,
    starttime     DATE,
    endtime       DATE,
    "Date"        DATE
);

ALTER TABLE bookedappointment ADD CONSTRAINT bookedappointment_pk PRIMARY KEY ( appointmentid );

CREATE TABLE chatlog (
    chatid         VARCHAR2(100) NOT NULL,
    patientid      VARCHAR2(100) NOT NULL,
    doctorid       VARCHAR2(100) NOT NULL,
    "Date"         DATE,
    messagehistory CLOB
);

ALTER TABLE chatlog ADD CONSTRAINT chatlog_pk PRIMARY KEY ( chatid );

CREATE TABLE doctor (
    doctorid     VARCHAR2(100) NOT NULL,
    email        VARCHAR2(320),
    firstname    VARCHAR2(30),
    middlename   VARCHAR2(30),
    lastname     VARCHAR2(30),
    password     VARCHAR2(100),
    mobilenumber VARCHAR2(20)
);

ALTER TABLE doctor ADD CONSTRAINT doctor_pk PRIMARY KEY ( doctorid );

CREATE TABLE patient (
    patientid         VARCHAR2(100) NOT NULL,
    email             VARCHAR2(320),
    firstname         VARCHAR2(30),
    middlename        VARCHAR2(30),
    lastname          VARCHAR2(30),
    dob               DATE,
    password          VARCHAR2(100),
    mobilenumber      VARCHAR2(20),
    healthinformation CLOB,
    medicalhistory    CLOB
);

ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( patientid );

CREATE TABLE patientmedicine (
    prescriptionid           VARCHAR2(50) NOT NULL,
    patientid                VARCHAR2(100) NOT NULL,
    prescriptiondetails      CLOB,
    prescriptioninstructions CLOB
);

ALTER TABLE patientmedicine ADD CONSTRAINT patientmedicine_pk PRIMARY KEY ( prescriptionid );

CREATE TABLE patientsymptom (
    patientid          VARCHAR2(100) NOT NULL,
    symptomnumber      VARCHAR2(3) NOT NULL,
    symptomdescription CLOB
);

ALTER TABLE patientsymptom ADD CONSTRAINT patientsymptom_pk PRIMARY KEY ( patientid,
                                                                          symptomnumber );

ALTER TABLE availableappointment
    ADD CONSTRAINT availableappointment_doctor_fk FOREIGN KEY ( doctorid )
        REFERENCES doctor ( doctorid );

ALTER TABLE bookedappointment
    ADD CONSTRAINT bookedappointment_doctor_fk FOREIGN KEY ( doctorid )
        REFERENCES doctor ( doctorid );

ALTER TABLE bookedappointment
    ADD CONSTRAINT bookedappointment_patient_fk FOREIGN KEY ( patientid )
        REFERENCES patient ( patientid );

ALTER TABLE chatlog
    ADD CONSTRAINT chatlog_doctor_fk FOREIGN KEY ( doctorid )
        REFERENCES doctor ( doctorid );

ALTER TABLE chatlog
    ADD CONSTRAINT chatlog_patient_fk FOREIGN KEY ( patientid )
        REFERENCES patient ( patientid );

ALTER TABLE patientmedicine
    ADD CONSTRAINT patientmedicine_patient_fk FOREIGN KEY ( patientid )
        REFERENCES patient ( patientid );

ALTER TABLE patientsymptom
    ADD CONSTRAINT patientsymptom_patient_fk FOREIGN KEY ( patientid )
        REFERENCES patient ( patientid );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             0
-- ALTER TABLE                             14
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
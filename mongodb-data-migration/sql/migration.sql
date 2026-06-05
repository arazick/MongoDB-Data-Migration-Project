--Name: Asma Razick
--GNumber: G01310157
--Section: CS 450-001

SET LINESIZE 1000;
SET PAGESIZE 0;
SET TRIMSPOOL ON;
SET FEEDBACK OFF;
SET ECHO OFF;
SET DEFINE OFF;
--Schema: Linking/Referencing

-- WORKSHOPS MIGRATION
SELECT 'db.workshops.insertOne({' ||
'WorkshopID: ' || WorkshopID || ', ' ||
'Title: "' || Title || '", ' ||
'Category: "' || Category || '", ' ||
'EventDate: "' || TO_CHAR(EventDate, 'YYYY-MM-DD') || '", ' ||
'Location: "' || Location || '", ' ||
'Capacity: ' || Capacity ||
'});'
FROM Workshops;

-- REGISTRATIONS MIGRATION
SELECT 'db.registrations.insertOne({' ||
'WorkshopID: ' || WorkshopID || ', ' ||
'StudentID: "' || StudentID || '", ' ||
'RegisteredOn: "' || TO_CHAR(RegisteredOn, 'YYYY-MM-DD') || '"' ||
'});'
FROM Registrations;

-- USE SPOOL MIGRATION.JS AND THEN DO SPOOL OFF

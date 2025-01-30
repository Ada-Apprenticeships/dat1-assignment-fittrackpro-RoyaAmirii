-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column
--.read data/sample_data.sql
-- Enable foreign key support
PRAGMA foreign_keys = ON;
-- Create your tables here
-- Example:
-- CREATE TABLE table_name (
--     column1 datatype,
--     column2 datatype,
--     ...
-- );


-- TODO: Create the following tables:
-- 1. locations
DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT, --auto increment means you dont have to apply a value to location id, the database will do it itself, incrementing by 1
    name VARCHAR(255) NOT NULL,              
    address VARCHAR(255) NOT NULL,              
    phone_number VARCHAR(15),                   
    email VARCHAR(255),                          
    opening_hours VARCHAR(255)                    
);


-- 2. members
DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    date_of_birth DATE,                 --no VARCHAR because its an integer
    join_date DATE NOT NULL,            --no VARCHAR because its an integer
    emergency_contact_name VARCHAR(255),
    emergency_contact_phone VARCHAR(15)
);

-- 3. staff
DROP TABLE IF EXISTS staff;

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    position VARCHAR(255) CHECK(position IN ('Trainer', 'Manager', 'Receptionist')) NOT NULL,
    hire_date DATE NOT NULL,
    location_id INTEGER
);


-- 4. equipment


-- 5. classes
-- 6. class_schedule
-- 7. memberships
-- 8. attendance
-- 9. class_attendance
-- 10. payments
-- 11. personal_training_sessions
-- 12. member_health_metrics
-- 13. equipment_maintenance_log

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal
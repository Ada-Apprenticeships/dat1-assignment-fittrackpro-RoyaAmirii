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
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,  --auto increment means you dont have to apply a value to location id, the database will do it itself, incrementing by 1
    name VARCHAR(255) NOT NULL,                     --VARCHAR(255) limits the word count to 255 words, 255 is the default number put into varchar    
    address VARCHAR(255) NOT NULL,              
    phone_number INTEGER 
    email VARCHAR(255),                          
    opening_hours VARCHAR(255)                    
);


-- 2. members
DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,    --PRIMARY KEY ensures rows dont have identical data
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number INTEGER,
    date_of_birth DATE,                 --no VARCHAR because its an integer
    join_date DATE NOT NULL,            --no VARCHAR because its an integer
    emergency_contact_name VARCHAR(255),
    emergency_contact_phone INTEGER
);

-- 3. staff
DROP TABLE IF EXISTS staff;

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number INTEGER,
    position VARCHAR(255) CHECK(position IN ('Trainer', 'Manager', 'Receptionist')) NOT NULL,
    hire_date DATE NOT NULL,
    location_id INTEGER
);


-- 4. equipment
DROP TABLE IF EXISTS equipment;

CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    type TEXT CHECK(type IN ('Cardio', 'Strength')) NOT NULL,
    purchase_date DATE NOT NULL,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    location_id INTEGER
);

-- 5. classes
DROP TABLE IF EXISTS classes;

CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    capacity INTEGER,
    duration INTEGER,
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) --FOREIGN KEY is used to link each class to a location
);

-- 6. class_schedule
DROP TABLE IF EXISTS class_schedule;

CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER,
    staff_id INTEGER,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id), --FOREIGN KEY is used to link each class schedule to a class and a staff member.
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- 7. memberships
DROP TABLE IF EXISTS memberships;

CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER,
    type TEXT CHECK(type IN ('Standard', 'Premium', 'VIP')) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status TEXT CHECK(status IN ('Active', 'Inactive')) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 8. attendance
DROP TABLE IF EXISTS attendance;

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER,
    location_id INTEGER,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- 9. class_attendance
DROP TABLE IF EXISTS class_attendance;

CREATE TABLE class_attendance (
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    schedule_id INTEGER,
    member_id INTEGER,
    attendance_status TEXT CHECK(attendance_status IN ('Registered', 'Attended', 'Unattended')) NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 10. payments
-- 11. personal_training_sessions
-- 12. member_health_metrics
-- 13. equipment_maintenance_log

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal
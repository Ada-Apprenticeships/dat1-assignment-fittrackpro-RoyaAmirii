-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;
-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role
SELECT staff_id, first_name, last_name, position --used position instead of role because thats what I wrote in my staff table in the schema file
FROM staff                                   
ORDER BY position; -- Sorts results by roles/positions alphabetically

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days
SELECT s.staff_id, s.first_name || ' ' || s.last_name AS trainer_name, -- combines first and last name
       COUNT(pt.session_id) AS session_count  -- counts the number of training sessions per trainer
FROM staff s
JOIN personal_training_sessions pt ON s.staff_id  -- links trainers with their sessions
WHERE s.position = 'Trainer'  ---- only filters staff members with the role 'Trainer'
AND pt.session_date BETWEEN DATE('now') AND DATE('now', '+30 days') 
GROUP BY s.staff_id, trainer_name  -- counts sessions per trainer
HAVING session_count > 0  -- ensures only trainers with at least one session are included
ORDER BY session_count DESC; -- orders trainers by session count from highest first
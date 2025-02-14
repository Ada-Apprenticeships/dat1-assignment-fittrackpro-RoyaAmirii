-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;
-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit
INSERT INTO attendance (member_id, location_id, check_in_time) 
VALUES (7, 1, DATETIME('now')); 

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history
SELECT DATE(check_in_time) AS visit_date,  -- this only gets us the date from check-in time
       check_in_time,  -- selects check-in timestamp
       check_out_time  
FROM attendance  
WHERE member_id = 5  
ORDER BY check_in_time DESC;  --DESC to get most recent time first 

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits
SELECT strftime('%w', check_in_time) AS day_of_week,  -- strftime is a date formatting function and %w gives the the weekday number e.g. 0 = Sunday, 6 = Saturday, from check-in time
       COUNT(*) AS visit_count  
FROM attendance  
GROUP BY day_of_week  
ORDER BY visit_count DESC  --shows the busiest day first
LIMIT 1;  


-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location
SELECT l.name AS location_name,  
       COUNT(a.attendance_id) * 1.0 / COUNT(DISTINCT DATE(a.check_in_time)) AS avg_daily_attendance  -- Counts total visits and divides by distinct check-in dates to get daily average, and I multiplied by 1 to get decimal division not integer as the average may be a decimal
FROM attendance a  
JOIN locations l ON a.location_id = l.location_id  -- Joins 'attendance' with 'locations' based on location_id
GROUP BY l.name;  
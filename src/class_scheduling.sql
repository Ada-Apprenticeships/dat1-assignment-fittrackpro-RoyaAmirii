-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;
-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors
SELECT c.class_id, c.name AS class_name, s.first_name || ' ' || s.last_name AS instructor_name --s.first_name || ' ' || s.last_name used to concatenate the instructor's full name.
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN staff s ON cs.staff_id = s.staff_id;
-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date
SELECT c.class_id, c.name, cs.start_time, cs.end_time, 
       (c.capacity - COUNT(ca.member_id)) AS available_spots --Calculates available spots by subtracting the number of registered members from the class capacity.
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
LEFT JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id --LEFT JOIN used so even classes with no registered members are displayed
WHERE DATE(cs.start_time) = '2025-02-01' --Filters for classes scheduled on '2025-02-01'
GROUP BY c.class_id, c.name, cs.start_time, cs.end_time, c.capacity; 
-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
SELECT cs.schedule_id, 11, 'Registered'
FROM class_schedule cs
WHERE cs.class_id = 3 AND DATE(cs.start_time) = '2025-02-01'
LIMIT 1;
-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration
DELETE FROM class_attendance
WHERE schedule_id = 7 AND member_id = 2;
-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes
SELECT c.class_id, c.name AS class_name, COUNT(ca.member_id) AS registration_count --Counts the number of registrations per class.
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
GROUP BY c.class_id, c.name
ORDER BY registration_count DESC 
LIMIT 3; --to get top 3 most popular
-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member
SELECT (COUNT(*) * 1.0 / (SELECT COUNT(*) FROM members)) AS avg_classes_per_member --Counts total class registrations and divides by total members, I also used * 1.0 to ensure decimal division (which is more accurate) and not integer division.
FROM class_attendance;
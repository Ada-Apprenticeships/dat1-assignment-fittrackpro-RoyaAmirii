-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;
-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships
SELECT m.member_id, m.first_name, m.last_name, mb.type AS membership_type, mb.start_date, mb.end_date
FROM members m
JOIN memberships mb ON m.member_id = mb.member_id --Joins memberships with 'members' table to include member details
WHERE mb.status = 'Active'; --filters only active memberships

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type
SELECT mb.type AS membership_type, 
       AVG(JULIANDAY(a.check_out_time) - JULIANDAY(a.check_in_time)) * 24 * 60 AS avg_visit_duration_minutes -- used JULIANDAY() to get the difference in days, then it converts days to hours, then hours to minutes
FROM attendance a
JOIN memberships mb ON a.member_id = mb.member_id
WHERE a.check_out_time IS NOT NULL
GROUP BY mb.type;
-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year
SELECT m.member_id, m.first_name, m.last_name, m.email, mb.end_date
FROM members m
JOIN memberships mb ON m.member_id = mb.member_id
WHERE mb.end_date BETWEEN DATE('now') AND DATE('now', '+1 year'); --Used the DATE() function to get the current date and DATE('now', '+1 year') to get the date exactly one year from now
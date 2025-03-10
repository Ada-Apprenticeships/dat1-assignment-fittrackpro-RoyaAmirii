-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;
-- Equipment Management Queries

-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance
SELECT equipment_id, name, next_maintenance_date
FROM equipment
WHERE next_maintenance_date BETWEEN DATE('now') AND DATE('now', '+30 days'); --filters equipment that needs maintenance within the next 30 days
-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock
SELECT type AS equipment_type, COUNT(*) AS count --counts how many items exist for each type of equipment.
FROM equipment
GROUP BY type;
-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)
SELECT type AS equipment_type, AVG(JULIANDAY('now') - JULIANDAY(purchase_date)) AS avg_age_days --AVG finds the average age for each type of equipment and JULIANDAY('now') - JULIANDAY(purchase_date) calculates the age of each piece of equipment in days.
FROM equipment
GROUP BY type;
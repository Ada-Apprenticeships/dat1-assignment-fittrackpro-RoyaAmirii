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

-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)
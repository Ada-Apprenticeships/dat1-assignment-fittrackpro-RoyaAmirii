-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;
-- Payment Management Queries

-- 1. Record a payment for a membership
-- TODO: Write a query to record a payment for a membership
INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (11, 50.00, CURRENT_TIMESTAMP, 'Credit Card', 'Monthly membership fee'); -- I used 'CURRENT_TIMESTAMP' to ensure the payment date is recorded at the exact date and time of execution.

-- 2. Calculate total revenue from membership fees for each month of the last year
-- TODO: Write a query to calculate total revenue from membership fees for each month of the current year

-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases
-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;
-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer
SELECT pt.session_id,  
       m.first_name || ' ' || m.last_name AS member_name, -- adds first and last name of the member together
       pt.session_date,  
       pt.start_time,  
       pt.end_time  
FROM personal_training_sessions pt  
JOIN staff s ON pt.staff_id = s.staff_id  -- links the sessions to the correct trainer using staff_id
JOIN members m ON pt.member_id = m.member_id  -- links the session to the member taking part in it
WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin'  -- shows only sessions for Ivy Irwin
ORDER BY pt.session_date, pt.start_time;  

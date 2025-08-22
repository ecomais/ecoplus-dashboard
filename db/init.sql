-- 1) Create the schema
CREATE SCHEMA IF NOT EXISTS dashboard;

-- -- 2) Ensure new sessions on the database use the dashboard schema first
-- ALTER DATABASE ecoplus 
--   SET search_path = dashboard, public;

-- -- 3) If you want your PostgreSQL role to default to dashboard
-- ALTER ROLE admin 
--   SET search_path = dashboard, public;

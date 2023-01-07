\c
-- ----------------------------------------------------------------------------------------
-- create admin user to own all the objects
-- This user is used by CI/CD build pipeline to create objects
-- ----------------------------------------------------------------------------------------
CREATE ROLE crm_adm_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'crm_adm_user_001';

alter role crm_adm_user set search_path = crm_data, public;

-- ----------------------------------------------------------------------------------------
-- create read/write user for application to manipulate data
-- ----------------------------------------------------------------------------------------
CREATE ROLE crm_rw_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'crm_rw_user_001';

alter role crm_rw_user set search_path = crm_data, public;

-- ----------------------------------------------------------------------------------------
-- read only user for read only use case
-- ----------------------------------------------------------------------------------------
CREATE ROLE crm_ro_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'crm_ro_user_001';

alter role crm_ro_user set search_path = crm_data, public;

-- ----------------------------------------------------------------------------------------
-- create DB
-- ----------------------------------------------------------------------------------------
CREATE DATABASE crm_database
WITH
    OWNER = crm_adm_user
    CONNECTION LIMIT = -1;

-- Enforce security: Remove all on db from public (should do this for all database instead of relying on pg_hba.conf)
revoke all on database crm_database from public;

-- ----------------------------------------------------------------------------------------
-- create schema
-- ----------------------------------------------------------------------------------------
\c crm_database

-- Enforce security:Remove write access on public schema
revoke create on schema public from public;

create schema crm_data authorization crm_adm_user;
alter schema public owner to crm_adm_user;

-- ----------------------------------------------------------------------------------------
-- set up read only user
-- ----------------------------------------------------------------------------------------
grant connect on database crm_database to crm_ro_user;

grant usage on schema public to crm_ro_user;
grant usage on schema crm_data to crm_ro_user;

-- tables(current)
grant select on all tables in schema public to crm_ro_user;
grant select on all tables in schema crm_data to crm_ro_user;
-- tables(future)
alter default privileges for user crm_adm_user in schema public grant select on tables to crm_ro_user;
alter default privileges for user crm_adm_user in schema crm_data grant select on tables to crm_ro_user;



-- ----------------------------------------------------------------------------------------
-- set up read write user
-- ----------------------------------------------------------------------------------------
grant connect on database crm_database to crm_rw_user;
grant temporary on database crm_database to crm_rw_user;


grant usage on schema public to crm_rw_user;
grant usage on schema crm_data to crm_rw_user;

-- tables(current)
grant select, insert, update, delete on all tables in schema public to crm_rw_user;
grant select, insert, update, delete on all tables in schema crm_data to crm_rw_user;
-- tables(future)
alter default privileges for user crm_adm_user in schema public grant select, insert, update, delete on tables to crm_rw_user;
alter default privileges for user crm_adm_user in schema crm_data grant select, insert, update, delete on tables to crm_rw_user;

-- functions(current)
grant execute on all functions in schema public to crm_rw_user;
grant execute on all functions in schema crm_data to crm_rw_user;
-- functions(future)
alter default privileges for user crm_adm_user in schema public grant execute on functions to crm_rw_user;
alter default privileges for user crm_adm_user in schema crm_data grant execute on functions to crm_rw_user;

-- sequences(current)
grant usage on all sequences in schema public to crm_rw_user;
grant usage on all sequences in schema crm_data to crm_rw_user;
-- sequences(future)
alter default privileges for user crm_adm_user in schema public grant usage on sequences to crm_rw_user;
alter default privileges for user crm_adm_user in schema crm_data grant usage on sequences to crm_rw_user;


--
-- Don't we find all these are just remove a security concern by building a soft wall.
-- Shall we just use crm_adm_user to run the application?
-- What is difference between dropping a table and delete all records out of a table? or even just delete 20,000 records.
-- 



/*

rollback

\c crm_database

drop owned by crm_adm_user;
reassign owned by crm_adm_user to postgres;
drop user crm_adm_user;


drop owned by crm_rw_user;
reassign owned by crm_rw_user to postgres;
drop user crm_rw_user;


drop owned by crm_ro_user;
reassign owned by crm_ro_user to postgres;
drop user crm_ro_user;

\c postgres

drop database crm_database;

*/
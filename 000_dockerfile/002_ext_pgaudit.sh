#!/bin/sh

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<- 'EOSQL' > /tmp/002_ext_pgaudit.log
CREATE EXTENSION IF NOT EXISTS pgaudit;
-- just a demo to audit write and ddl for postgres user
alter role postgres set pgaudit.log='write, ddl';
select rolname,rolconfig from pg_roles where rolname in ('postgres');
EOSQL

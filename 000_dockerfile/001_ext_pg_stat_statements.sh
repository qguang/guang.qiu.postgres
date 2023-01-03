#!/bin/sh

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<- 'EOSQL' > /tmp/001_ext_pg_stat_statements.log
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
EOSQL

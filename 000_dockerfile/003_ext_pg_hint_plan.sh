#!/bin/sh

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<- 'EOSQL' > /tmp/003_ext_pg_hint_plan.log
CREATE EXTENSION IF NOT EXISTS pg_hint_plan;
EOSQL

#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

do
\$\$
begin
  if not exists (select * from pg_user where usename = '$GF_DATABASE_USER') then 
    CREATE USER grafana WITH PASSWORD '$GF_DATABASE_PASSWORD';
  end if;
end
\$\$
;

CREATE SCHEMA IF NOT EXISTS grafana_schema;

ALTER ROLE grafana SET search_path = grafana_schema;


GRANT ALL PRIVILEGES ON SCHEMA grafana_schema TO grafana;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA grafana_schema TO grafana;

EOSQL

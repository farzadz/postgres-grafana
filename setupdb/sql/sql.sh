#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
DROP TABLE IF EXISTS "locations";
CREATE TABLE "locations"(
    device_id    TEXT,
    location     TEXT,
    environment  TEXT
);

DROP TABLE IF EXISTS "conditions";
CREATE TABLE "conditions"(
    time         TIMESTAMP WITH TIME ZONE NOT NULL,
    device_id    TEXT,
    temperature  NUMERIC,
    humidity     NUMERIC
);

EOSQL


psql --username "$POSTGRES_USER" -d postgres -c "\COPY locations FROM /docker-entrypoint-initdb.d/weather_small_locations.csv CSV"
psql --username "$POSTGRES_USER" -d postgres -c "\COPY conditions FROM /docker-entrypoint-initdb.d/weather_small_conditions.csv CSV"


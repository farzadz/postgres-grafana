#!/bin/bash
set -e



flyway -configFiles=/flyway/conf/flyway.config -locations=filesystem:/flyway/sql -connectRetries=60 migrate



psql -v ON_ERROR_STOP=1 --host postgres --username postgres --dbname postgres -c "\COPY locations FROM /flyway/data/weather_small_locations.csv CSV"
psql -v ON_ERROR_STOP=1 --host postgres --username postgres --dbname postgres -c "\COPY conditions FROM /flyway/data/weather_small_conditions.csv CSV"



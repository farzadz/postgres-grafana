#!/bin/bash
set -e



flyway -configFiles=/flyway/conf/flyway.config -locations=filesystem:/flyway/sql -connectRetries=60 migrate


locations_cnt=$(psql -h postgres -U postgres -c  "SELECT COUNT(*) FROM locations" | head -n 3 | tail -n 1 | tr -d "[:blank:]")
echo "Found $locations_cnt rows in locations"
if [[ $locations_cnt -eq 0 ]]; then
    psql -v ON_ERROR_STOP=1 --host postgres --username postgres --dbname postgres -c "\COPY locations FROM /flyway/data/weather_small_locations.csv CSV"
    else
    echo 'Locations contains data, skipping...'
fi

conditions_cnt=$(psql -h postgres -U postgres -c  "SELECT COUNT(*) FROM conditions" | head -n 3 | tail -n 1 | tr -d "[:blank:]")
echo "Found $conditions_cnt rows in conditions"
if [[ $conditions_cnt -eq 0 ]]; then
    psql -v ON_ERROR_STOP=1 --host postgres --username postgres --dbname postgres -c "\COPY conditions FROM /flyway/data/weather_small_conditions.csv CSV"
    else
    echo 'Locations contains data, skipping...'
fi




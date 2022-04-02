#!/bin/bash
set -e

flyway -configFiles=/flyway/conf/flyway.config -locations=filesystem:/flyway/sql -connectRetries=60 migrate

insert_if_not_empty() {
    table=$1
    data_file=$2
    cnt=$(psql -h "$PGHOST" -U "$PGUSER" -c "SELECT COUNT(*) FROM $table" | head -n 3 | tail -n 1 | tr -d "[:blank:]")
    echo "Found $cnt rows in $table"
    if [[ $cnt -eq 0 ]]; then
        psql -v ON_ERROR_STOP=1 --host $PGHOST --username $PGUSER --dbname $POSTGRES_DB -c "\COPY $table FROM $data_file CSV"
    else
        echo "$table contains data, skipping..."
    fi
}

insert_if_not_empty locations /flyway/data/weather_small_locations.csv
insert_if_not_empty conditions /flyway/data/weather_small_conditions.csv


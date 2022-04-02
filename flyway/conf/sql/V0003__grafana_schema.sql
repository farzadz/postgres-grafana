DO
$$
BEGIN
  IF NOT EXISTS (SELECT * FROM pg_user WHERE usename = '${grafana_user}') THEN 
    CREATE USER grafana WITH PASSWORD '${grafana_password}';
  END IF;
END
$$
;

CREATE SCHEMA IF NOT EXISTS grafana_schema;

ALTER ROLE grafana SET search_path = grafana_schema;


GRANT ALL PRIVILEGES ON SCHEMA grafana_schema TO grafana;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA grafana_schema TO grafana;
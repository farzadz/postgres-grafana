do
$$
begin
  if not exists (select * from pg_user where usename = 'grafana') then 
    CREATE USER grafana WITH PASSWORD 'admin';
  end if;
end
$$
;

CREATE SCHEMA IF NOT EXISTS grafana_schema;

ALTER ROLE grafana SET search_path = grafana_schema;


GRANT ALL PRIVILEGES ON SCHEMA grafana_schema TO grafana;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA grafana_schema TO grafana;
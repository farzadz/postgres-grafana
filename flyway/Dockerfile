
FROM flyway/flyway:8.5.4

USER root

RUN apt-get update && apt-get -y install wget ca-certificates gnupg lsb-release 

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update && apt-get -y install postgresql-client

USER flyway
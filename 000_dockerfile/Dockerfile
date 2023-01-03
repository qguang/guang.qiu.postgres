FROM postgres:14-bullseye

LABEL maintainer="Guang Qiu PostgreSQL lab - qguang2011@gmail.com"

# install extra packages
RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends vim procps alien wget

# install python for python demo
RUN apt-get install -y --no-install-recommends python3.9 python3-distutils python3-pip python3-apt
RUN pip3 install --upgrade pip

# pgaudit
RUN apt-get install -y --no-install-recommends postgresql-$PG_MAJOR-pgaudit


RUN rm -rf /var/lib/apt/lists/*


# use our own configuration
COPY postgresql.conf /etc/postgresql/postgresql.conf

# run customized script at time initializing database.
RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./000_house_keeping.sh /docker-entrypoint-initdb.d/
COPY ./001_ext_pg_stat_statements.sh /docker-entrypoint-initdb.d/
COPY ./002_ext_pgaudit.sh /docker-entrypoint-initdb.d/
COPY ./100_setup_crm_database.sql /docker-entrypoint-initdb.d/


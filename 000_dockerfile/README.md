# Set up Docker

Set up docker by extending official **[Postgres](https://hub.docker.com/_/postgres)** docker image. Reasons for extending the image are:

1. Install PostgreSQL extensions.
2. Use our own database configuration.
3. Install extra packages, i.e. vim.


## Docker build image

```

# Note: We might need to unset http_proxy and https_proxy
# unset http_proxy
# unset https_proxy

cd $GIT_REPO/guang.qiu.postgres/000_dockerfile
docker build -f Dockerfile . -t local/postgres-14

```


## Docker start it up

```

export LOCAL_PORT_NUMBER=25432

docker run -d \
    --name=local-postgres-14 \
    --hostname=local-postgres-14 \
    -e POSTGRES_PASSWORD=postgres_001 \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_DB=postgres \
    -e POSTGRES_INITDB_ARGS="--data-checksums -E UTF8" \
    -p ${LOCAL_PORT_NUMBER}:5432 \
    local/postgres-14 \
    -c 'config_file=/etc/postgresql/postgresql.conf'

# log into database inside docker to verify.
docker exec -it local-postgres-14 bash
psql -U postgres

# log into database from local laptop by using psql which can be installed by brew.
export LOCAL_PORT_NUMBER=25432
psql "postgresql://postgres:postgres_001@127.0.0.1:${LOCAL_PORT_NUMBER}/postgres"

# to remove docker container
docker rm -f local-postgres-14

```

## Use Docker build to setup a database structure

In addition to set up docker image, we use 100_setup_crm_database.sql to set up an lab environment. The file is copied to docker-entrypoint-initdb.d by docker build process. It will be executed as part database initialization process. Please note that it is not necessary to rely on docker build process to run such script. It is used in this way just to show how the docker build process works.

The SQL script creates the following database objects:
1. crm_database database
2. crm_data schema
3. 3 users
    - crm_adm_user
    - crm_rw_user
    - crm_ro_user

In addition to those database objects, it also sets up permssions for these 3 users. It is worth mentioning that crm_adm_user is the owner of crm_database and allows 2 other users to manipulate database objects with different levels of permissions. However, one can even run application with just just crm_adm_user under so-called 1 user mode. It can remove some administration chores/confusions by loosening security control and segragation of roles and responsibilities.

```

|------------|-----------------------------------------------------------------------------------------------------|
|            |                                           |                   Roles/Users                           |
|  Cluster   |-------------------------------------------|----------------|----------------|----------------|------|
|            |           PostgreSQL instance(s)          |   crm_adm_user |   crm_rw_user  |   crm_ro_user  |      |
|------------|-------------------------------------------|----------------|----------------|----------------|------|
| Database(s)|              crm_database                 |    Owner       |    Connect     |    Connect     |   P  |
|------------|-------------------------------------------|----------------|----------------|----------------|   r  |
|            |              public                       |    Owner       |     Usage      |     Usage      |   i  |
|  Schema(s) |-------------------------------------------|----------------|----------------|----------------|   v  |
|            |              crm_data                     |    Owner       |     Usage      |     Usage      |   s  |
|------------|-------------------------------------------|----------------|----------------|----------------|      |
| Object(s)  |        client, client_contact ...         |    Owner       |     R/W        |      Read      |      |
|------------|------------------------------------------------------------|----------------|----------------|------|


Cluster -< Databases -< Schemas -< Objects
Cluster -< Roles/Users
Cluster -< Instances

Note: The original concept of PostgreSQL cluster is composed of multiple databases.

psql "postgresql://postgres:postgres_001@127.0.0.1:25432/postgres"
psql "postgresql://crm_adm_user:crm_adm_user_001@127.0.0.1:25432/crm_database"
psql "postgresql://crm_ro_user:crm_ro_user_001@127.0.0.1:25432/crm_database"
psql "postgresql://crm_rw_user:crm_rw_user_001@127.0.0.1:25432/crm_database"

```

## PostgreSQL extension

The Dockerfile has steps to install necessary files used by PostgreSQL extension. For example we use apt-get to install pgaudit.

Shell scripts are called as part database initialization process to create extensions.
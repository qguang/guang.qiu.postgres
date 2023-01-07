# Use liquibase

**Liquibase** is used to maintain the database objects, this section explains basic information about Liquibase usage and the layout of our SQL files.

Please note that *000_dockerfile/100_setup_crm_database.sql* is executed by Docker build process.


## Liquibase

Liquibase open source software helps development teams rapidly manage database schema changes at scale. (https://www.liquibase.org/)

To my mind that if you find there are 2 things you have to spend lots of time on, Liquibase could be you best friend:
- Has the script been applied or not?
- Manually order scripts all the time.

You can install liquibase here: https://www.liquibase.com/download

Liquibase PostgreSQL tutorial: https://docs.liquibase.com/start/install/tutorials/postgresql.html


## Command line

The instruction below can be used to maintain database schema changes for this lab environment.

Deploy, Rollback

```

export PGDATABASE=crm_database
export SCHEMA_NAME=crm_data
export PGUSER=crm_adm_user
export PGPASSWORD='crm_adm_user_001'
export PGHOST=127.0.0.1
export PGPORT=25432


cd ${GIT_REPO}/guang.qiu.postgres/postgres/${PGDATABASE}/${SCHEMA_NAME}


# Update/Deploy
liquibase --url="jdbc:postgresql://$PGHOST:$PGPORT/$PGDATABASE" --changeLogFile=changelog-master.yaml --username=$PGUSER  --password=$PGPASSWORD \
--liquibase-schema-name=${SCHEMA_NAME} \
--log-file=liquibase_update_$(date +%Y-%m-%dT%H-%M-%S).log \
--log-level=FINE \
update \
-Dp.schema_name=${SCHEMA_NAME}


# Rollback
liquibase --url="jdbc:postgresql://$PGHOST:$PGPORT/$PGDATABASE" --changeLogFile=changelog-master.yaml --username=$PGUSER  --password=$PGPASSWORD \
--liquibase-schema-name=${SCHEMA_NAME} \
--log-file=liquibase_rollback_$(date +%Y-%m-%dT%H-%M-%S).log \
--log-level=FINE \
rollbackCount 1000 \
-Dp.schema_name=${SCHEMA_NAME}


```



## SQL file layout

All the SQL scripts are kept under postgres folder. 

The directory naming convention is as below. The database object owner is not reflected in the directory layout. 

```

postgres/${database_name}/${schema_name}/${script_type}/

```

For example

```

    postgres
        └── crm_database
                ├── crm_data
                │   ├── changelog-master.yaml
                │   ├── liquibase.properties
                │   ├── ddl
                │   ├── functions
                │   ├── refdata
                │   ├── triggers
                │   ├── types
                │   └── views
                └── public
                    ├── changelog-master.yaml
                    ├── liquibase.properties
                    ├── ddl
                    ├── functions
                    ├── refdata
                    ├── triggers
                    ├── types
                    └── views


```



# guang.qiu.postgres

Set up simple Docker container lab for learning PostgreSQL.

## Key things

1. Hard-coded PostgreSQL version 14 in many places, i.e. readme, Dockerfile etc.
2. All users' password has convention of ${username}_001. For example, the password of user *postgres* is *postgres_001*.

## How to set it up

- 000_dockerfile/README.md for instruction to start up Docker container
- 001_liquibase/README.md for instruction to maintain database schema objects.

## Repo layout
```bash
    .
    ├── 000_Dockerfile
    │   ├── Dockerfile
    │   └── README.md
    ├── 001_liquibase
    │   └── README.md
    ├── 002_partition
    │   └── README.md
    ├── Lab_cron
    │   └── README.md
    ├── postgres
    │   └── README.md
    └── README.md
```


## Key files


| Path                                   | Description                                                                  |
| -------------------------------------- | ---------------------------------------------------------------------------- |
| /usr/lib/postgresql/14/bin/            | binary command location   |
| /etc/postgresql/postgresql.conf        | configuration file        |
| /usr/share/postgresql/14/extension     | extension location        |
| /var/lib/postgresql/data               | data location             |
| /var/lib/postgresql/data/log           | log location              |



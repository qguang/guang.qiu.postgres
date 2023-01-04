# guang.qiu.postgres

Set up simple lab for learning postgres.

## Key things

1. Hard-coded PostgreSQL version 14 in many places, i.e. readme, Dockerfile etc.
2. All users' password has convention of ${username}_001. For example, if password of user *postgres* is *postgres_001*.



## Repo layout
```bash
    .
    ├── 000_Dockerfile
    │   ├── Dockerfile
    │   └── README.md
    ├── Lab_001
    │   └── README.md
    ├── Lab_002
    │   └── README.md
    ├── Lab_003
    │   └── README.md
    ├── liquibase_changelog_master.yaml
    └── README.md
```


## Key location/command

### location


| location                               | Description                                                                  |
| -------------------------------------- | ---------------------------------------------------------------------------- |
| /usr/lib/postgresql/14/bin/            | binary command location   |
| /etc/postgresql/postgresql.conf        | configuration file        |
| /usr/share/postgresql/14/extension     | extension location        |
| /var/lib/postgresql/data               | data location             |
| /var/lib/postgresql/data/log           | log location              |



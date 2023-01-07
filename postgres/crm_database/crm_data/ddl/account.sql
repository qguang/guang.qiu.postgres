--liquibase formatted sql

--changeset SYSTEM:account.create stripComments:false splitStatements:true runOnChange:false runAlways:false

create table account
(
    account_number varchar(20) not null,
    account_type varchar(20) not null,
    closing_balance numeric(25,2),
    constraint account_pk primary key (account_number)
);

--rollback drop table account cascade;

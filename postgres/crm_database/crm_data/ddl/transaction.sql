--liquibase formatted sql

--changeset SYSTEM:transaction.create stripComments:false splitStatements:true runOnChange:false runAlways:false

create table transaction
(
    account_number varchar(20) not null,
    transaction_datetime timestamp not null,
    amount numeric(25,2),
    transaction_desc varchar(100),
    constraint transaction_pk primary key (account_number, transaction_datetime),
    constraint transaction_fk1 foreign key (account_number) references account(account_number)
);


--rollback drop table transaction cascade;

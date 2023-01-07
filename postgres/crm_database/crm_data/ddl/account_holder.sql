--liquibase formatted sql

--changeset SYSTEM:account_holder.create stripComments:false splitStatements:true runOnChange:false runAlways:false

create table account_holder
(
    customer_id varchar(20) not null,
    account_number varchar(20) not null,
    account_role varchar(50) not null,
    constraint account_holder_pk primary key (customer_id, account_number, account_role),
    constraint account_holder_fk1 foreign key (customer_id) references customer(customer_id),
    constraint account_holder_fk2 foreign key (account_number) references account(account_number)
);

--rollback drop table account_holder cascade;

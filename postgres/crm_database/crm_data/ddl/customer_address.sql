--liquibase formatted sql

--changeset SYSTEM:customer_address.create stripComments:false splitStatements:true runOnChange:false runAlways:false

create table customer_address
(
    customer_id varchar(20) not null,
    address_type varchar(10) not null,
    address varchar(100) not null,
    constraint customer_address_pk primary key (customer_id, address_type),
    constraint customer_address_fk1 foreign key (customer_id) references customer(customer_id)
);

--rollback drop table customer_address cascade;

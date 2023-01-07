--liquibase formatted sql

--changeset SYSTEM:customer.create stripComments:false splitStatements:true runOnChange:false runAlways:false

create table customer
(
    customer_id varchar(20) not null,
    first_name  varchar(100) not null,
    last_name   varchar(100) not null,
    gender      varchar(5)   not null,
    dob         date not null,
    constraint customer_pk primary key (customer_id),
    constraint customer_ck1 CHECK (gender in ('M', 'F'))
);

--rollback drop table customer cascade;




--changeset SYSTEM:customer.add_column_qualification stripComments:false splitStatements:true runOnChange:false runAlways:false

alter table customer add column qualification varchar(50) not null default 'Unkown';

--rollback alter table customer drop column qualification;




--changeset SYSTEM:customer.create_index_customer_ix1 stripComments:false splitStatements:true runOnChange:false runAlways:false

create index customer_ix1 on customer(first_name);

--rollback drop index customer_ix1;

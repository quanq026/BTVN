create database salesdb;

create schema sales;

create table sales.customers(
	customer_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(100) not null unique,
	phone varchar(15)
);

create table sales.products(
	product_id serial primary key,
	product_name varchar(100) not null,
	price numeric(10,2) not null,
	stock_quantity int not null
);

create table sales.orders(
	order_id serial primary key,
	customer_id int references sales.customers(customer_id),
	order_date date not null
);

create table sales.orderitems(
	order_item_id serial primary key,
	order_id int references sales.orders(order_id),
	product_id int references sales.products(product_id),
	quantity int check(quantity >= 1)
);

select datname from pg_database;

select schema_name from information_schema.schemata;

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'sales' and table_name = 'customers';

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'sales' and table_name = 'products';

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'sales' and table_name = 'orders';

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'sales' and table_name = 'orderitems';
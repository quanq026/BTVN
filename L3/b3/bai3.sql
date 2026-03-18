create schema shop;

create table shop.customers(
	customer_id serial primary key,
	full_name varchar(100) not null,
	email varchar(100) not null unique,
	phone varchar(15) default '',
	address varchar(200)
);

create table shop.products(
	product_id serial primary key,
	product_name varchar(100) not null unique,
	price numeric(12,2) check(price >= 0),
	category varchar(100)
);

create table shop.orders(
	order_id serial primary key,
	order_date date default current_date,
	total_amount numeric(15,2) check(total_amount >= 0),
	customer_id int references shop.customers(customer_id)
);

create table shop.order_details(
	order_id int not null references shop.orders(order_id),
	product_id int not null references shop.products(product_id),
	quantity int check(quantity > 0),
	unit_price numeric(12,2) check(unit_price >= 0),
	primary key(order_id, product_id)
);
create database EcommerceDB;

create schema shop;

create table shop.Users(
	user_id serial primary key,
	username varchar(50) not null unique,
	email varchar(100) not null unique,
	password varchar(100) not null,
	role varchar(20) check(role in ('Customer', 'Admin'))
);

create table shop.Categories(
	category_id serial primary key,
	category_name varchar(100) not null unique
);

create table shop.Products(
	product_id serial primary key,
	product_name varchar(100) not null,
	price numeric(10,2) check(price > 0),
	stock int check(stock >= 0),
	category_id int references shop.Categories(category_id)
);

create table shop.Orders(
	order_id serial primary key,
	user_id int references shop.Users(user_id),
	order_date date not null,
	status varchar(20) check(status in ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

create table shop.OrderDetails(
	order_detail_id serial primary key,
	order_id int references shop.Orders(order_id),
	product_id int references shop.Products(product_id),
	quantity int check(quantity > 0),
	price_each numeric(10,2) check(price_each > 0)
);

create table shop.Payments(
	payment_id serial primary key,
	order_id int references shop.Orders(order_id),
	amount numeric(10,2) check(amount >= 0),
	payment_date date not null,
	method varchar(30) check(method in ('Credit Card', 'Momo', 'Bank Transfer', 'Cash'))
);

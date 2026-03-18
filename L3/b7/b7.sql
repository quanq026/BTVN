create schema sales;

create table sales.Products(
	product_id serial primary key,
	product_name varchar(100) not null,
	price numeric(12,2),
	stock_quantity int
);

create table sales.Orders(
	order_id serial primary key,
	order_date date default current_date,
	member_id int references library.Members(member_id)
);

create table sales.OrderDetails(
	order_detail_id serial primary key,
	order_id int references sales.Orders(order_id),
	product_id int references sales.Products(product_id),
	quantity int
);

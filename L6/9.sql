create table Product (
	id serial primary key,
	name varchar(100),
	category varchar(50),
	price numeric(10,2)
);

create table OrderDetail (
	id serial primary key,
	order_id int,
	product_id int references Product(id),
	quantity int
);

insert into Product (name, category, price) values
('Laptop Dell XPS', 'Electronics', 25000000),
('iPhone 15 Pro', 'Electronics', 32000000),
('Bàn học gỗ', 'Furniture', 3200000),
('Ghế xoay', 'Furniture', 2800000),
('Tai nghe Sony', 'Electronics', 8500000);

insert into OrderDetail (order_id, product_id, quantity) values
(1, 1, 2),
(1, 3, 1),
(2, 2, 1),
(3, 1, 1),
(3, 5, 3),
(4, 4, 2);

select p.name as product_name, sum(p.price * od.quantity) as total_sales
from Product p
join OrderDetail od on p.id = od.product_id
group by p.name;

select p.category, avg(p.price * od.quantity) as avg_revenue
from Product p
join OrderDetail od on p.id = od.product_id
group by p.category;

select p.category, avg(p.price * od.quantity) as avg_revenue
from Product p
join OrderDetail od on p.id = od.product_id
group by p.category
having avg(p.price * od.quantity) > 20000000;

select p.name as product_name, sum(p.price * od.quantity) as total_sales
from Product p
join OrderDetail od on p.id = od.product_id
group by p.name
having sum(p.price * od.quantity) > (
	select avg(total) from (
		select sum(p2.price * od2.quantity) as total
		from Product p2
		join OrderDetail od2 on p2.id = od2.product_id
		group by p2.id
	) t
);

select p.name as product_name, sum(od.quantity) as total_quantity
from Product p
left join OrderDetail od on p.id = od.product_id
group by p.name;

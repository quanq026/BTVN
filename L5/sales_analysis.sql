create table products (
	product_id serial primary key,
	product_name varchar(100),
	category varchar(50)
);

create table orders (
	order_id int primary key,
	product_id int references products(product_id),
	quantity int,
	total_price decimal(12,0)
);

insert into products (product_id, product_name, category) values
(1, 'Laptop Dell', 'Electronics'),
(2, 'IPhone 15', 'Electronics'),
(3, 'Bàn học gỗ', 'Furniture'),
(4, 'Ghế xoay', 'Furniture');

insert into orders (order_id, product_id, quantity, total_price) values
(101, 1, 2, 2200),
(102, 2, 3, 3300),
(103, 3, 5, 2500),
(104, 4, 4, 1600),
(105, 1, 1, 1100);

select
	p.category,
	sum(o.total_price) as total_sales,
	sum(o.quantity) as total_quantity
from orders o
join products p on o.product_id = p.product_id
group by p.category
having sum(o.total_price) > 2000
order by total_sales desc;

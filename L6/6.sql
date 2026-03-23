create table Orders (
	id serial primary key,
	customer_id int,
	order_date date,
	total_amount numeric(10,2)
);

insert into Orders (customer_id, order_date, total_amount) values
(1, '2023-03-15', 12000000),
(2, '2023-07-22', 8500000),
(3, '2023-11-05', 15000000),
(4, '2024-01-10', 22000000),
(1, '2024-04-18', 18000000),
(2, '2024-08-30', 9500000),
(3, '2024-12-01', 25000000),
(5, '2023-06-14', 6000000);

select
	sum(total_amount) as total_revenue,
	count(id) as total_orders,
	avg(total_amount) as average_order_value
from Orders;

select
	extract(year from order_date) as year,
	sum(total_amount) as total_revenue
from Orders
group by extract(year from order_date);

select
	extract(year from order_date) as year,
	sum(total_amount) as total_revenue
from Orders
group by extract(year from order_date)
having sum(total_amount) > 50000000;

select * from Orders order by total_amount desc limit 5;

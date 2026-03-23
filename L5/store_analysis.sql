create table customers (
	customer_id serial primary key,
	customer_name varchar(100),
	city varchar(50)
);

create table orders (
	order_id serial primary key,
	customer_id int references customers(customer_id),
	order_date date,
	total_amount numeric(10,2)
);

create table order_items (
	item_id serial primary key,
	order_id int references orders(order_id),
	product_name varchar(100),
	quantity int,
	price numeric(10,2)
);

-- 1. ALIAS
select
	c.customer_name,
	o.order_date,
	o.total_amount
from orders o
join customers c on o.customer_id = c.customer_id;

-- 2. Aggregate Functions
select
	sum(total_amount) as total_revenue,
	avg(total_amount) as avg_order,
	max(total_amount) as max_order,
	min(total_amount) as min_order,
	count(order_id) as order_count
from orders;

-- 3. GROUP BY / HAVING
select c.city, sum(o.total_amount) as total_revenue
from customers c
join orders o on c.customer_id = o.customer_id
group by c.city
having sum(o.total_amount) > 10000;

-- 4. JOIN 3 bảng
select
	c.customer_name,
	o.order_date,
	oi.product_name,
	oi.quantity,
	oi.price
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id;

-- 5. Subquery
select customer_name
from customers
where customer_id = (
	select customer_id from orders
	group by customer_id
	order by sum(total_amount) desc
	limit 1
);

-- 6. UNION
select city from customers
union
select c.city from orders o join customers c on o.customer_id = c.customer_id;

-- 6. INTERSECT
select city from customers
intersect
select c.city from orders o join customers c on o.customer_id = c.customer_id;

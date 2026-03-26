create table customer (
	customer_id serial primary key,
	full_name varchar(100),
	region varchar(50)
);

create table orders (
	order_id serial primary key,
	customer_id int references customer(customer_id),
	total_amount decimal(10,2),
	order_date date,
	status varchar(20)
);

create table product (
	product_id serial primary key,
	name varchar(100),
	price decimal(10,2),
	category varchar(50)
);

create table order_detail (
	order_id int references orders(order_id),
	product_id int references product(product_id),
	quantity int
);

insert into customer (full_name, region) values
('Nguyễn Văn An', 'Hà Nội'),
('Trần Thị Bích', 'Hồ Chí Minh'),
('Lê Văn Cường', 'Hà Nội'),
('Phạm Thị Dung', 'Đà Nẵng'),
('Bùi Hữu Phát', 'Hồ Chí Minh');

insert into orders (customer_id, total_amount, order_date, status) values
(1, 5000000, '2024-10-01', 'Completed'),
(1, 3000000, '2024-11-15', 'Completed'),
(2, 12000000, '2024-10-20', 'Completed'),
(3, 8000000, '2024-11-05', 'Pending'),
(4, 2000000, '2024-12-01', 'Completed'),
(5, 15000000, '2024-12-10', 'Completed');

-- 1. View tổng hợp doanh thu theo khu vực
create view v_revenue_by_region as
select c.region, sum(o.total_amount) as total_revenue
from customer c
join orders o on c.customer_id = o.customer_id
group by c.region;

select * from v_revenue_by_region
order by total_revenue desc
limit 3;

-- 2. Materialized View doanh thu theo tháng
create materialized view mv_monthly_sales as
select
	date_trunc('month', order_date) as month,
	sum(total_amount) as monthly_revenue
from orders
group by date_trunc('month', order_date);

select * from mv_monthly_sales order by month;

-- View chi tiết đơn hàng có thể cập nhật được
create view v_order_status as
select order_id, customer_id, order_date, status
from orders
where status = 'Pending'
with check option;

update orders set status = 'Completed' where order_id = 4;

-- 3. Nested View: khu vực có doanh thu lớn hơn trung bình toàn quốc
create view v_revenue_above_avg as
select region, total_revenue
from v_revenue_by_region
where total_revenue > (
	select avg(total_revenue) from v_revenue_by_region
);

select * from v_revenue_above_avg;

-- Refresh Materialized View khi dữ liệu thay đổi
refresh materialized view mv_monthly_sales;
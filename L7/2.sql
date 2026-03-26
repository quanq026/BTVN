create table customer (
	customer_id serial primary key,
	full_name varchar(100),
	email varchar(100),
	phone varchar(15)
);

create table orders (
	order_id serial primary key,
	customer_id int references customer(customer_id),
	total_amount decimal(10,2),
	order_date date
);

insert into customer (full_name, email, phone) values
('Nguyễn Văn An', 'an@gmail.com', '0901234567'),
('Trần Thị Bích', 'bich@gmail.com', '0912345678'),
('Lê Văn Cường', 'cuong@gmail.com', '0923456789');

insert into orders (customer_id, total_amount, order_date) values
(1, 850000, '2024-10-05'),
(1, 2200000, '2024-11-12'),
(2, 1500000, '2024-11-20'),
(3, 500000, '2024-12-01'),
(2, 3000000, '2024-12-15');

-- 1. Tạo view ẩn email và phone
create view v_order_summary as
select c.full_name, o.total_amount, o.order_date
from orders o
join customer c on o.customer_id = c.customer_id;

-- 2. Xem dữ liệu từ view
select * from v_order_summary;

-- 3. View lọc đơn hàng >= 1 triệu
create view v_high_orders as
select * from orders where total_amount >= 1000000;

select * from v_high_orders;

update orders set total_amount = 2500000 where order_id = 2;

-- 4. View thống kê doanh thu theo tháng
create view v_monthly_sales as
select
	extract(year from order_date) as year,
	extract(month from order_date) as month,
	sum(total_amount) as total_revenue
from orders
group by extract(year from order_date), extract(month from order_date)
order by year, month;

select * from v_monthly_sales;

-- 5. Xóa view
drop view v_order_summary;
drop view v_high_orders;
drop view v_monthly_sales;

/*
	DROP VIEW xóa view thông thường — chỉ xóa định nghĩa truy vấn, không ảnh hưởng đến dữ liệu gốc trong bảng.

	DROP MATERIALIZED VIEW xóa view vật chất hóa — xóa cả bản sao dữ liệu đã được lưu trữ trên đĩa.
*/

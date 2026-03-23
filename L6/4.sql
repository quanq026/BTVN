create table OrderInfo (
	id serial primary key,
	customer_id int,
	order_date date,
	total numeric(10,2),
	status varchar(20)
);

insert into OrderInfo (customer_id, order_date, total, status) values
(1, '2024-10-05', 750000, 'Completed'),
(2, '2024-10-18', 1200000, 'Pending'),
(3, '2024-09-22', 450000, 'Completed'),
(4, '2024-10-30', 3000000, 'Shipping'),
(5, '2024-11-02', 980000, 'Cancelled');

select * from OrderInfo where total > 500000;

select * from OrderInfo where order_date between '2024-10-01' and '2024-10-31';

select * from OrderInfo where status != 'Completed';

select * from OrderInfo order by order_date desc limit 2;

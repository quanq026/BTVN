create table Customer (
	id serial primary key,
	name varchar(100)
);

create table Orders (
	id serial primary key,
	customer_id int references Customer(id),
	order_date date,
	total_amount numeric(10,2)
);

insert into Customer (name) values
('Nguyễn Văn An'),
('Trần Thị Bích'),
('Lê Văn Cường'),
('Phạm Thị Dung'),
('Bùi Hữu Phát');

insert into Orders (customer_id, order_date, total_amount) values
(1, '2024-01-10', 12000000),
(1, '2024-03-22', 8000000),
(2, '2024-02-15', 25000000),
(3, '2024-04-05', 5000000),
(3, '2024-06-18', 7000000),
(3, '2024-09-30', 9000000);

select c.name, sum(o.total_amount) as total_spent
from Customer c
join Orders o on c.id = o.customer_id
group by c.name
order by total_spent desc;

select c.name, sum(o.total_amount) as total_spent
from Customer c
join Orders o on c.id = o.customer_id
group by c.name
having sum(o.total_amount) = (
	select max(total) from (
		select sum(total_amount) as total from Orders group by customer_id
	) t
);

select c.name
from Customer c
left join Orders o on c.id = o.customer_id
where o.id is null;

select c.name, sum(o.total_amount) as total_spent
from Customer c
join Orders o on c.id = o.customer_id
group by c.name
having sum(o.total_amount) > (
	select avg(total) from (
		select sum(total_amount) as total from Orders group by customer_id
	) t
);

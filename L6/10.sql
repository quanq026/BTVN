create table OldCustomers (
	id serial primary key,
	name varchar(100),
	city varchar(50)
);

create table NewCustomers (
	id serial primary key,
	name varchar(100),
	city varchar(50)
);

insert into OldCustomers (name, city) values
('Nguyễn Văn An', 'Hà Nội'),
('Trần Thị Bích', 'Đà Nẵng'),
('Lê Văn Cường', 'Hà Nội'),
('Phạm Thị Dung', 'Hồ Chí Minh');

insert into NewCustomers (name, city) values
('Trần Thị Bích', 'Đà Nẵng'),
('Bùi Hữu Phát', 'Hà Nội'),
('Võ Thị Giang', 'Hồ Chí Minh'),
('Đặng Văn Hùng', 'Hà Nội');

select name, city from OldCustomers
union
select name, city from NewCustomers;

select name, city from OldCustomers
intersect
select name, city from NewCustomers;

select city, count(*) as total_customers from (
	select name, city from OldCustomers
	union all
	select name, city from NewCustomers
) t
group by city;

select city from (
	select city, count(*) as total from (
		select name, city from OldCustomers
		union all
		select name, city from NewCustomers
	) t
	group by city
) t2
where total = (
	select max(total) from (
		select city, count(*) as total from (
			select name, city from OldCustomers
			union all
			select name, city from NewCustomers
		) t3
		group by city
	) t4
);

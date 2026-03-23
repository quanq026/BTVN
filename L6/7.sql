create table Department (
	id serial primary key,
	name varchar(50)
);

create table Employee (
	id serial primary key,
	full_name varchar(100),
	department_id int references Department(id),
	salary numeric(10,2)
);

insert into Department (name) values
('IT'),
('HR'),
('Finance'),
('Marketing');

insert into Employee (full_name, department_id, salary) values
('Nguyễn Văn An', 1, 18000000),
('Trần Thị Bích', 2, 9000000),
('Lê Quốc Cường', 1, 15000000),
('Phạm Minh Dũng', 3, 12000000),
('Bùi Thị Lan', 2, 8500000),
('Đặng Hữu Tài', 1, 20000000),
('Võ Thị Giang', 3, 11000000);

select e.full_name, d.name as department_name
from Employee e
inner join Department d on e.department_id = d.id;

select d.name as department_name, avg(e.salary) as avg_salary
from Employee e
inner join Department d on e.department_id = d.id
group by d.name;

select d.name as department_name, avg(e.salary) as avg_salary
from Employee e
inner join Department d on e.department_id = d.id
group by d.name
having avg(e.salary) > 10000000;

select d.name as department_name
from Department d
left join Employee e on d.id = e.department_id
where e.id is null;

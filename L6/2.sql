create table Employee (
	id serial primary key,
	full_name varchar(100),
	department varchar(50),
	salary numeric(10,2),
	hire_date date
);

insert into Employee (full_name, department, salary, hire_date) values
('Nguyễn Văn An', 'IT', 15000000, '2023-03-15'),
('Trần Thị Lan', 'HR', 8000000, '2022-07-01'),
('Lê Quốc Bảo', 'IT', 18000000, '2023-09-10'),
('Phạm Minh An', 'Finance', 5500000, '2021-11-20'),
('Đặng Hữu Tài', 'IT', 12000000, '2023-06-05'),
('Bùi Thị Mai', 'HR', 9000000, '2024-01-15');

update Employee set salary = salary * 1.1 where department = 'IT';

delete from Employee where salary < 6000000;

select * from Employee where full_name ilike '%An%';

select * from Employee where hire_date between '2023-01-01' and '2023-12-31';

create table employees (
	id serial primary key,
	full_name varchar(100),
	department varchar(50),
	position varchar(50),
	salary decimal(12,0),
	bonus decimal(12,0),
	join_year int
);

insert into employees (full_name, department, position, salary, bonus, join_year) values
('Nguyễn Văn Huy', 'IT', 'Developer', 18000000, 1000000, 2021),
('Trần Thị Mai', 'HR', 'Recruiter', 12000000, null, 2020),
('Lê Quốc Trung', 'IT', 'Tester', 15000000, 800000, 2023),
('Nguyễn Văn Huy', 'IT', 'Developer', 18000000, 1000000, 2021),
('Phạm Ngọc Hân', 'Finance', 'Accountant', 14000000, null, 2019),
('Bùi Thị Lan', 'HR', 'HR Manager', 20000000, 3000000, 2018),
('Đặng Hữu Tài', 'IT', 'Developer', 17000000, null, 2022);

-- 1a. Xóa các bản ghi trùng nhau hoàn toàn về tên, phòng ban và vị trí
delete from employees where id not in (
	select min(id) from employees group by full_name, department, position
);

-- 2a. Tăng 10% lương cho nhân viên phòng IT có lương dưới 18,000,000
update employees set salary = salary * 1.1
where department = 'IT' and salary < 18000000;

-- 2b. Với nhân viên có bonus IS NULL, đặt bonus = 500000
update employees set bonus = 500000 where bonus is null;

-- 3a. Nhân viên phòng IT hoặc HR, gia nhập sau 2020, tổng thu nhập > 15,000,000
select *, (salary + bonus) as total_income
from employees
where department in ('IT', 'HR')
	and join_year > 2020
	and (salary + bonus) > 15000000;

-- 3b. Chỉ lấy 3 nhân viên đầu tiên sau khi sắp xếp giảm dần theo tổng thu nhập
select *, (salary + bonus) as total_income
from employees
order by (salary + bonus) desc
limit 3;

-- 4. Tìm nhân viên có tên bắt đầu bằng "Nguyễn" hoặc kết thúc bằng "Hân"
select * from employees
where full_name ilike 'Nguyễn%' or full_name ilike '%Hân';

-- 5. Liệt kê các phòng ban duy nhất có ít nhất một nhân viên có bonus IS NOT NULL
select distinct department from employees where bonus is not null;

-- 6. Hiển thị nhân viên gia nhập trong khoảng từ 2019 đến 2022
select * from employees where join_year between 2019 and 2022;

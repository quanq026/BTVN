create table employees (
	emp_id serial primary key,
	emp_name varchar(100),
	job_level int,
	salary numeric
);

insert into employees (emp_name, job_level, salary) values
('Nguyễn Văn An', 1, 10000000),
('Trần Thị Bích', 2, 15000000),
('Lê Văn Cường', 3, 20000000),
('Phạm Thị Dung', 1, 12000000),
('Bùi Hữu Phát', 2, 18000000);

create or replace procedure adjust_salary(p_emp_id int, out p_new_salary numeric)
language plpgsql
as $$
declare
	v_level int;
begin
	select job_level into v_level
	from employees
	where emp_id = p_emp_id;

	if v_level = 1 then
		update employees set salary = salary * 1.05 where emp_id = p_emp_id;
	elsif v_level = 2 then
		update employees set salary = salary * 1.10 where emp_id = p_emp_id;
	elsif v_level = 3 then
		update employees set salary = salary * 1.15 where emp_id = p_emp_id;
	else
		raise exception 'Không tìm thấy nhân viên hoặc job_level không hợp lệ';
	end if;

	select salary into p_new_salary
	from employees
	where emp_id = p_emp_id;
end;
$$;

call adjust_salary(3, null);

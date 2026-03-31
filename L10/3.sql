create table employees (
	id serial primary key,
	name varchar(100),
	position varchar(50),
	salary numeric
);

create table employees_log (
	log_id serial primary key,
	employee_id int,
	operation varchar(10),
	old_data text,
	new_data text,
	change_time timestamp default current_timestamp
);

create or replace function log_employee_changes()
returns trigger
language plpgsql
as $$
begin
	if tg_op = 'INSERT' then
		insert into employees_log (employee_id, operation, old_data, new_data)
		values (
			new.id,
			'INSERT',
			null,
			'name: ' || new.name || ', position: ' || new.position || ', salary: ' || new.salary
		);
		return new;

	elsif tg_op = 'UPDATE' then
		insert into employees_log (employee_id, operation, old_data, new_data)
		values (
			new.id,
			'UPDATE',
			'name: ' || old.name || ', position: ' || old.position || ', salary: ' || old.salary,
			'name: ' || new.name || ', position: ' || new.position || ', salary: ' || new.salary
		);
		return new;

	elsif tg_op = 'DELETE' then
		insert into employees_log (employee_id, operation, old_data, new_data)
		values (
			old.id,
			'DELETE',
			'name: ' || old.name || ', position: ' || old.position || ', salary: ' || old.salary,
			null
		);
		return old;
	end if;
end;
$$;

create trigger trg_employee_log
after insert or update or delete on employees
for each row
execute function log_employee_changes();

insert into employees (name, position, salary) values
('Nguyễn Văn An', 'Developer', 18000000),
('Trần Thị Bích', 'Tester', 15000000),
('Lê Văn Cường', 'HR Manager', 20000000);

update employees set salary = 20000000 where id = 1;

update employees set position = 'Senior Developer' where id = 1;

delete from employees where id = 3;

select * from employees_log order by change_time;
create table customers (
	id serial primary key,
	name varchar(100),
	credit_limit numeric
);

create table orders (
	id serial primary key,
	customer_id int references customers(id),
	order_amount numeric
);

insert into customers (name, credit_limit) values
('Nguyễn Văn An', 50000000),
('Trần Thị Bích', 20000000),
('Lê Văn Cường', 30000000);

create or replace function check_credit_limit()
returns trigger
language plpgsql
as $$
declare
	v_limit numeric;
	v_total numeric;
begin
	select credit_limit into v_limit
	from customers
	where id = new.customer_id;

	select coalesce(sum(order_amount), 0) into v_total
	from orders
	where customer_id = new.customer_id;

	if v_total + new.order_amount > v_limit then
		raise exception 'Vượt hạn mức tín dụng. Hạn mức: %, Đã dùng: %, Đơn mới: %',
			v_limit, v_total, new.order_amount;
	end if;

	return new;
end;
$$;

create trigger trg_check_credit
before insert on orders
for each row
execute function check_credit_limit();

insert into orders (customer_id, order_amount) values (1, 20000000);
insert into orders (customer_id, order_amount) values (1, 25000000);

insert into orders (customer_id, order_amount) values (2, 15000000);
insert into orders (customer_id, order_amount) values (2, 10000000);
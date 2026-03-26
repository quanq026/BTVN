create table inventory (
	product_id serial primary key,
	product_name varchar(100),
	quantity int
);

insert into inventory (product_name, quantity) values
('Laptop Dell', 10),
('iPhone 15', 3),
('Chuột Logitech', 0);

create or replace procedure check_stock(p_id int, p_qty int)
language plpgsql
as $$
declare
	current_qty int;
begin
	select quantity into current_qty
	from inventory
	where product_id = p_id;

	if current_qty < p_qty then
		raise exception 'Không đủ hàng trong kho';
	else
		raise notice 'Còn đủ hàng. Tồn kho hiện tại: %', current_qty;
	end if;
end;
$$;

call check_stock(1, 5);

call check_stock(3, 1);

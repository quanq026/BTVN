create table order_detail (
	id serial primary key,
	order_id int,
	product_name varchar(100),
	quantity int,
	unit_price numeric
);

insert into order_detail (order_id, product_name, quantity, unit_price) values
(1, 'Laptop Dell', 1, 25000000),
(1, 'Chuột Logitech', 2, 500000),
(2, 'iPhone 15', 1, 32000000),
(2, 'Ốp lưng', 3, 150000),
(3, 'Bàn phím Razer', 1, 2200000);

create or replace procedure calculate_order_total(
	order_id_input int,
	out total numeric
)
language plpgsql
as $$
begin
	select sum(quantity * unit_price)
	into total
	from order_detail
	where order_id = order_id_input;
end;
$$;

call calculate_order_total(1, null);
call calculate_order_total(2, null);

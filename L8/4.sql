create table products (
	id serial primary key,
	name varchar(100),
	price numeric,
	discount_percent int
);

insert into products (name, price, discount_percent) values
('Laptop Dell', 25000000, 10),
('iPhone 15', 32000000, 60),
('Tai nghe Sony', 8500000, 30);

create or replace procedure calculate_discount(p_id int, out p_final_price numeric)
language plpgsql
as $$
declare
	v_price numeric;
	v_discount int;
begin
	select price, discount_percent into v_price, v_discount
	from products
	where id = p_id;

	if v_discount > 50 then
		v_discount := 50;
	end if;

	p_final_price := v_price - (v_price * v_discount / 100);

	update products set price = p_final_price where id = p_id;
end;
$$;

call calculate_discount(2, null);

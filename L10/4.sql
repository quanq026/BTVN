create table products (
	id serial primary key,
	name varchar(100),
	stock int
);

create table orders (
	id serial primary key,
	product_id int references products(id),
	quantity int
);

insert into products (name, stock) values
('Laptop Dell', 20),
('iPhone 15', 15),
('Tai nghe Sony', 30);

create or replace function update_stock()
returns trigger
language plpgsql
as $$
begin
	if tg_op = 'INSERT' then
		update products set stock = stock - new.quantity where id = new.product_id;
		if (select stock from products where id = new.product_id) < 0 then
			raise exception 'Không đủ hàng trong kho';
		end if;
		return new;

	elsif tg_op = 'UPDATE' then
		update products set stock = stock + old.quantity - new.quantity where id = new.product_id;
		if (select stock from products where id = new.product_id) < 0 then
			raise exception 'Không đủ hàng trong kho';
		end if;
		return new;

	elsif tg_op = 'DELETE' then
		update products set stock = stock + old.quantity where id = old.product_id;
		return old;
	end if;
end;
$$;

create trigger trg_update_stock
after insert or update or delete on orders
for each row
execute function update_stock();

insert into orders (product_id, quantity) values (1, 5);
insert into orders (product_id, quantity) values (2, 3);

update orders set quantity = 8 where id = 1;

delete from orders where id = 2;

select * from products;
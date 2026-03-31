create table products (
	id serial primary key,
	name varchar(100),
	price numeric,
	last_modified timestamp default current_timestamp
);

insert into products (name, price) values
('Laptop Dell', 25000000),
('iPhone 15', 32000000),
('Tai nghe Sony', 8500000);

create or replace function update_last_modified()
returns trigger
language plpgsql
as $$
begin
	new.last_modified := current_timestamp;
	return new;
end;
$$;

create trigger trg_update_last_modified
before update on products
for each row
execute function update_last_modified();

update products set price = 27000000 where id = 1;

update products set price = 30000000 where id = 2;

select * from products;
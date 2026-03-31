create table products (
	product_id serial primary key,
	product_name varchar(100),
	stock int,
	price numeric(10,2)
);

create table orders (
	order_id serial primary key,
	customer_name varchar(100),
	total_amount numeric(10,2),
	created_at timestamp default now()
);

create table order_items (
	order_item_id serial primary key,
	order_id int references orders(order_id),
	product_id int references products(product_id),
	quantity int,
	subtotal numeric(10,2)
);

insert into products (product_name, stock, price) values
('Laptop Dell', 10, 25000000),
('iPhone 15', 5, 32000000);

-- 1. Transaction đặt hàng thành công
begin;

do $$
declare
	v_order_id int;
	v_total numeric := 0;
begin
	if (select stock from products where product_id = 1) < 2 then
		raise exception 'Sản phẩm 1 không đủ hàng';
	end if;
	if (select stock from products where product_id = 2) < 1 then
		raise exception 'Sản phẩm 2 không đủ hàng';
	end if;

	insert into orders (customer_name, total_amount) values ('Nguyen Van A', 0)
	returning order_id into v_order_id;

	update products set stock = stock - 2 where product_id = 1;
	update products set stock = stock - 1 where product_id = 2;

	insert into order_items (order_id, product_id, quantity, subtotal) values
	(v_order_id, 1, 2, 2 * (select price from products where product_id = 1)),
	(v_order_id, 2, 1, 1 * (select price from products where product_id = 2));

	select sum(subtotal) into v_total from order_items where order_id = v_order_id;

	update orders set total_amount = v_total where order_id = v_order_id;
end;
$$;

commit;

select * from products;
select * from orders;
select * from order_items;

-- 2. Mô phỏng lỗi: giảm stock sản phẩm 2 về 0
update products set stock = 0 where product_id = 2;

begin;

do $$
declare
	v_order_id int;
begin
	if (select stock from products where product_id = 1) < 2 then
		raise exception 'Sản phẩm 1 không đủ hàng';
	end if;
	if (select stock from products where product_id = 2) < 1 then
		raise exception 'Sản phẩm 2 không đủ hàng';
	end if;

	insert into orders (customer_name, total_amount) values ('Tran Thi B', 0)
	returning order_id into v_order_id;

	update products set stock = stock - 2 where product_id = 1;
	update products set stock = stock - 1 where product_id = 2;
end;
$$;

rollback;

select * from products;
create table Product (
	id serial primary key,
	name varchar(100),
	category varchar(50),
	price numeric(10,2),
	stock int
);

insert into Product (name, category, price, stock) values
('Laptop Dell XPS 13', 'Điện tử', 25000000, 12),
('iPhone 15 Pro', 'Điện tử', 32000000, 8),
('Tủ lạnh Samsung', 'Điện gia dụng', 9500000, 5),
('Bàn học gỗ', 'Nội thất', 3200000, 20),
('Tai nghe Sony WH-1000XM5', 'Điện tử', 8500000, 15);

select * from Product;

select * from Product order by price desc limit 3;

select * from Product where category = 'Điện tử' and price < 10000000;

select * from Product order by stock asc;

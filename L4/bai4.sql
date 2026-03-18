create table products (
	id serial primary key,
	name varchar(100),
	category varchar(50),
	price decimal(12,0),
	stock int,
	manufacturer varchar(50)
);

insert into products (name, category, price, stock, manufacturer) values
('Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
('Chuột Logitech M90', 'Phụ kiện', 150000, 50, 'Logitech'),
('Bàn phím cơ Razer', 'Phụ kiện', 2200000, 0, 'Razer'),
('Macbook Air M2', 'Laptop', 32000000, 7, 'Apple'),
('iPhone 14 Pro Max', 'Điện thoại', 35000000, 15, 'Apple'),
('Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
('Tai nghe AirPods 3', 'Phụ kiện', 4500000, null, 'Apple');

-- 1. Thêm sản phẩm mới
insert into products (name, category, price, stock, manufacturer) values
('Chuột không dây Logitech M170', 'Phụ kiện', 300000, 20, 'Logitech');

-- 2. Tăng giá tất cả sản phẩm của Apple thêm 10%
update products set price = price * 1.1 where manufacturer = 'Apple';

-- 3. Xóa sản phẩm có stock = 0
delete from products where stock = 0;

-- 4. Hiển thị sản phẩm có price between 1000000 and 30000000
select * from products where price between 1000000 and 30000000;

-- 5. Hiển thị sản phẩm có stock IS NULL
select * from products where stock is null;

-- 6. Liệt kê danh sách hãng sản xuất duy nhất
select distinct manufacturer from products;

-- 7. Hiển thị toàn bộ sản phẩm, sắp xếp giảm dần theo giá, sau đó tăng dần theo tên
select * from products order by price desc, name asc;

-- 8. Tìm sản phẩm có tên chứa từ "laptop" (không phân biệt hoa thường)
select * from products where name ilike '%laptop%';

-- 9. Chỉ hiển thị 2 sản phẩm đầu tiên sau khi sắp xếp
select * from products order by price desc, name asc limit 2;

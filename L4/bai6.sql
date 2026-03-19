create table books (
	id serial primary key,
	title varchar(200),
	author varchar(100),
	category varchar(50),
	publish_year int,
	price decimal(10,0),
	stock int
);

insert into books (title, author, category, publish_year, price, stock) values
('Lập trình C cơ bản', 'Nguyễn Văn Nam', 'CNTT', 2018, 95000, 20),
('Học SQL qua ví dụ', 'Trần Thị Hạnh', 'CSDL', 2020, 125000, 12),
('Lập trình C cơ bản', 'Nguyễn Văn Nam', 'CNTT', 2018, 95000, 20),
('Phân tích dữ liệu với Python', 'Lê Quốc Bảo', 'CNTT', 2022, 180000, null),
('Quản trị cơ sở dữ liệu', 'Nguyễn Thị Minh', 'CSDL', 2021, 150000, 5),
('Học máy cho người mới bắt đầu', 'Nguyễn Văn Nam', 'AI', 2023, 220000, 8),
('Khoa học dữ liệu cơ bản', 'Nguyễn Văn Nam', 'AI', 2023, 220000, null);

-- 1. Xóa các bản ghi trùng lặp hoàn toàn về title, author và publish_year
delete from books where id not in (
	select min(id) from books group by title, author, publish_year
);

-- 2. Tăng giá 10% cho sách xuất bản từ năm 2021 trở đi và có price < 200000
update books set price = price * 1.1
where publish_year >= 2021 and price < 200000;

-- 3. Với những sách có stock IS NULL, cập nhật stock = 0
update books set stock = 0 where stock is null;

-- 4. Liệt kê sách thuộc chủ đề CNTT hoặc AI có giá trong khoảng 100000 - 250000
-- sắp xếp giảm dần theo price, rồi tăng dần theo title
select * from books
where category in ('CNTT', 'AI')
	and price between 100000 and 250000
order by price desc, title asc;

-- 5. Tìm các sách có tiêu đề chứa từ "học"
select * from books where title ilike '%học%';

-- 6. Liệt kê các thể loại duy nhất có ít nhất một cuốn sách xuất bản sau năm 2020
select distinct category from books where publish_year > 2020;

-- 7. Chỉ hiển thị 2 kết quả đầu tiên, bỏ qua 1 kết quả đầu tiên
select * from books order by id limit 2 offset 1;

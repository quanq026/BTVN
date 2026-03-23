create table Course (
	id serial primary key,
	title varchar(100),
	instructor varchar(50),
	price numeric(10,2),
	duration int
);

insert into Course (title, instructor, price, duration) values
('Lập trình Python cơ bản', 'Nguyễn Văn A', 800000, 40),
('Học SQL từ đầu', 'Trần Thị B', 650000, 25),
('Demo HTML CSS', 'Lê Văn C', 500000, 20),
('Machine Learning nâng cao', 'Phạm Thị D', 1800000, 60),
('React JS thực chiến', 'Đặng Văn E', 1200000, 45),
('Phân tích dữ liệu với Excel', 'Bùi Thị F', 450000, 18);

update Course set price = price * 1.15 where duration > 30;

delete from Course where title ilike '%Demo%';

select * from Course where title ilike '%SQL%';

select * from Course
where price between 500000 and 2000000
order by price desc
limit 3;

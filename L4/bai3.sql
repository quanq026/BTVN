create table students (
	id serial primary key,
	full_name varchar(100),
	gender varchar(10),
	birth_year int,
	major varchar(50),
	gpa decimal(3,1)
);

insert into students (full_name, gender, birth_year, major, gpa) values
('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
('Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
('Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
('Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
('Lưu Đức Tài', '2004', 2004, 'Cơ khí', null),
('Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

-- 1. Thêm sinh viên mới
insert into students (full_name, gender, birth_year, major, gpa) values
('Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

-- 2. Cập nhật GPA của Lê Quốc Cường thành 3.4
update students set gpa = 3.4 where full_name = 'Lê Quốc Cường';

-- 3. Xóa sinh viên có GPA IS NULL
delete from students where gpa is null;

-- 4. Hiển thị sinh viên ngành CNTT có GPA >= 3.0, chỉ lấy 3 kết quả đầu tiên
select * from students where major = 'CNTT' and gpa >= 3.0 limit 3;

-- 5. Liệt kê danh sách ngành học duy nhất
select distinct major from students;

-- 6. Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên
select * from students where major = 'CNTT' order by gpa desc, full_name asc;

-- 7. Tìm sinh viên có tên bắt đầu bằng "Nguyễn"
select * from students where full_name ilike 'Nguyễn%';

-- 8. Hiển thị sinh viên có năm sinh từ 2001 đến 2003
select * from students where birth_year between 2001 and 2003;

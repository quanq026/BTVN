create table Customer (
	id serial primary key,
	name varchar(100),
	email varchar(100),
	phone varchar(20),
	points int
);

insert into Customer (name, email, phone, points) values
('Nguyễn Văn An', 'an@gmail.com', '0901234567', 850),
('Trần Thị Bích', 'bich@gmail.com', '0912345678', 1200),
('Lê Quốc Cường', 'cuong@gmail.com', '0923456789', 500),
('Phạm Minh Dũng', 'dung@gmail.com', '0934567890', 1500),
('Nguyễn Thị Em', null, '0945678901', 300),
('Bùi Hữu Phát', 'phat@gmail.com', '0956789012', 1800),
('Võ Thị Giang', 'giang@gmail.com', '0967890123', 950);

select distinct name from Customer;

select * from Customer where email is null;

select * from Customer order by points desc limit 3 offset 1;

select * from Customer order by name desc;

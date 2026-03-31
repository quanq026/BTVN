create table flights (
	flight_id serial primary key,
	flight_name varchar(100),
	available_seats int
);

create table bookings (
	booking_id serial primary key,
	flight_id int references flights(flight_id),
	customer_name varchar(100)
);

insert into flights (flight_name, available_seats) values
('VN123', 3),
('VN456', 2);

-- 1. Transaction đặt vé thành công
begin;

update flights set available_seats = available_seats - 1
where flight_name = 'VN123';

insert into bookings (flight_id, customer_name)
values (1, 'Nguyen Van A');

commit;

select * from flights;
select * from bookings;

-- 2. Mô phỏng lỗi và Rollback
begin;

update flights set available_seats = available_seats - 1
where flight_name = 'VN123';

insert into bookings (flight_id, customer_name)
values (999, 'Tran Thi B');

rollback;

select * from flights;
select * from bookings;
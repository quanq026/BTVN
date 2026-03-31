create table accounts (
	account_id serial primary key,
	owner_name varchar(100),
	balance numeric(10,2)
);

insert into accounts (owner_name, balance) values
('A', 500.00),
('B', 300.00);

-- 1. Giao dịch chuyển tiền hợp lệ
begin;

update accounts set balance = balance - 100.00 where owner_name = 'A';
update accounts set balance = balance + 100.00 where owner_name = 'B';

commit;

select * from accounts;

-- 2. Mô phỏng lỗi và Rollback
begin;

update accounts set balance = balance - 100.00 where owner_name = 'A';
update accounts set balance = balance + 100.00 where account_id = 999;

rollback;

select * from accounts;
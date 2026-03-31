create table accounts (
	account_id serial primary key,
	customer_name varchar(100),
	balance numeric(12,2)
);

create table transactions (
	trans_id serial primary key,
	account_id int references accounts(account_id),
	amount numeric(12,2),
	trans_type varchar(20),
	created_at timestamp default now()
);

insert into accounts (customer_name, balance) values
('Nguyen Van A', 5000000),
('Tran Thi B', 1000000);

-- 1. Transaction rút tiền thành công
begin;

do $$
declare
	v_balance numeric;
	v_amount numeric := 500000;
	v_account_id int := 1;
begin
	select balance into v_balance from accounts where account_id = v_account_id;

	if v_balance < v_amount then
		raise exception 'Số dư không đủ. Số dư hiện tại: %', v_balance;
	end if;

	update accounts set balance = balance - v_amount where account_id = v_account_id;

	insert into transactions (account_id, amount, trans_type)
	values (v_account_id, v_amount, 'WITHDRAW');
end;
$$;

commit;

select * from accounts;
select * from transactions;

-- 2. Mô phỏng lỗi: nhập sai account_id trong transactions
begin;

do $$
declare
	v_amount numeric := 200000;
	v_account_id int := 2;
begin
	update accounts set balance = balance - v_amount where account_id = v_account_id;

	insert into transactions (account_id, amount, trans_type)
	values (999, v_amount, 'WITHDRAW');
end;
$$;

rollback;

select * from accounts;
select * from transactions;

-- 3. Rút tiền nhiều lần, kiểm tra tính toàn vẹn
begin;

do $$
declare
	v_amount numeric := 300000;
	v_account_id int := 1;
	v_balance numeric;
begin
	select balance into v_balance from accounts where account_id = v_account_id;

	if v_balance < v_amount then
		raise exception 'Số dư không đủ';
	end if;

	update accounts set balance = balance - v_amount where account_id = v_account_id;

	insert into transactions (account_id, amount, trans_type)
	values (v_account_id, v_amount, 'WITHDRAW');
end;
$$;

commit;

select a.customer_name, a.balance,
	coalesce(sum(t.amount), 0) as total_withdrawn
from accounts a
left join transactions t on a.account_id = t.account_id
where t.trans_type = 'WITHDRAW'
group by a.customer_name, a.balance;
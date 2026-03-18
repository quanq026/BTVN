create schema library;

create table library.books(
	isbn varchar(20) not null primary key,
	title varchar(255) not null unique,
	author varchar(255) not null,
	published_year int check(published_year > 1900),
	genre varchar(100)
);

create table library.readers(
	reader_id char(10) not null primary key,
	full_name varchar(100) not null,
	birth_date date,
	address varchar(200),
	phone varchar(15) default ''
);

create table library.borrow_records(
	record_id char(10) not null primary key,
	borrow_date date default current_date,
	due_date date not null check(due_date > borrow_date),
	status varchar(20) default 'Borrowing',
	reader_id char(10) references library.readers(reader_id),
	isbn varchar(20) references library.books(isbn)
);
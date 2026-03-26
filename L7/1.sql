create table book (
	book_id serial primary key,
	title varchar(255),
	author varchar(100),
	genre varchar(50),
	price decimal(10,2),
	description text,
	created_at timestamp default current_timestamp
);

explain analyze select * from book where author ilike '%Rowling%';
explain analyze select * from book where genre = 'Fantasy';

create index idx_book_author_trgm on book using gin(author gin_trgm_ops);
create index idx_book_genre on book using btree(genre);

explain analyze select * from book where author ilike '%Rowling%';
explain analyze select * from book where genre = 'Fantasy';

create index idx_book_title_gin on book using gin(
	to_tsvector('english', title || ' ' || coalesce(description, ''))
);

cluster book using idx_book_genre;

/*
	1. Loại chỉ mục hiệu quả nhất cho từng loại truy vấn:
	- B-tree: tối ưu cho =, <, >, BETWEEN, ORDER BY. Dùng cho genre.
	- GIN pg_trgm: tối ưu cho ILIKE '%...%'. Dùng cho author, title.
	- GIN to_tsvector: tối ưu cho full-text search. Dùng cho title và description.
	- Hash: chỉ hỗ trợ so sánh =, không hỗ trợ range hoặc ORDER BY.

	2. Hash index không được khuyến khích vì:
	- Chỉ hỗ trợ toán tử =.
	- B-tree làm được mọi thứ Hash làm được.
*/

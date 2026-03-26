create table post (
	post_id serial primary key,
	user_id int not null,
	content text,
	tags text[],
	created_at timestamp default current_timestamp,
	is_public boolean default true
);

create table post_like (
	user_id int not null,
	post_id int not null,
	liked_at timestamp default current_timestamp,
	primary key (user_id, post_id)
);

explain analyze
select * from post
where is_public = true and content ilike '%du lịch%';

create index idx_post_content_lower on post using gin(lower(content) gin_trgm_ops);

explain analyze
select * from post
where is_public = true and content ilike '%du lịch%';

explain analyze
select * from post where tags @> array['travel'];

create index idx_post_tags on post using gin(tags);

explain analyze
select * from post where tags @> array['travel'];

create index idx_post_recent_public on post(created_at desc)
where is_public = true;

explain analyze
select * from post
where is_public = true and created_at >= now() - interval '7 days';

create index idx_post_user_created on post(user_id, created_at desc);

explain analyze
select * from post
where user_id in (1, 2, 3)
order by created_at desc;

/*
- Expression + GIN trgm ở cột lower(content) dùng để Tối ưu ILIKE
- GIN ở cột Tags dùng để tối ưu mảng tìm kiếm
- Partial ở cột is_public dùng để tối ưu tìm kiếm theo điều kiện
- B-tree ở cột user_id và created_at dùng để tối ưu tìm kiếm theo điều kiện và sắp xếp
*/
select p.product_name, sum(o.total_price) as total_revenue
from orders o
join products p on o.product_id = p.product_id
group by p.product_name
having sum(o.total_price) = (
	select max(total) from (
		select sum(total_price) as total from orders group by product_id
	) t
);

select p.category, sum(o.total_price) as total_revenue
from orders o
join products p on o.product_id = p.product_id
group by p.category;

select p.category
from orders o
join products p on o.product_id = p.product_id
group by p.category
having sum(o.total_price) = (
	select max(total) from (
		select sum(total_price) as total from orders group by product_id
	) t
)
intersect
select p.category
from orders o
join products p on o.product_id = p.product_id
group by p.category
having sum(o.total_price) > 3000;

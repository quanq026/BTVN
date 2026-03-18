alter table library.Books add genre varchar(100);

alter table library.Books rename column available to is_available;

alter table library.Members drop column email;

drop table sales.OrderDetails;

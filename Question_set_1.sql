USE music_store_data_analysis;
show tables;

-- QUESTION SET1- EASY
-- who is the senior most employee based on the job title?
select * from employee
order by levels desc
limit 1;

-- which countries have the most invoices?
select * from invoice;
select distinct(billing_country) , count(billing_postal_code) as no_of_invoices from invoice 
group by billing_country
having no_of_invoices=
(select max(no_of_invoices) from
(select distinct(billing_country) , count(billing_postal_code) as no_of_invoices from invoice 
group by billing_country
order by no_of_invoices desc) as b );

-- alternatively
select count(*) as c,billing_country from invoice
group by billing_country
order by c desc;

-- what are the top three values of total invoice?
select * from invoice
order by total desc
limit 3;

/* which city has the best customers? we would like to throw a promotional music festival in the city we made the most money
Write a query that returns one city that has the highest sum of invoice totals. Return both the city name and sum of all invoice totals.*/
select billing_country ,sum(total) as total from invoice
group by billing_country
having total=
(select max(total) from
(select billing_country as country_name,sum(total) as total from invoice
group by country_name
order by total desc) as b);

/* who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query
that returns the best customer */
-- required solution
select c.customer_id, c.first_name,c.last_name,sum(inv.total) as total from customer c
join invoice inv on c.customer_id=inv.customer_id
group by c.customer_id, c.first_name,c.last_name
order by total desc
limit 1;


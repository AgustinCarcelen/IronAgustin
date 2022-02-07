use sakila;

-- 1.  How many copies of the film Hunchback Impossible exist in the inventory system?
select f.title, count(i.inventory_id)
from inventory i
join film f using(film_id)
where i.film_id = (select film_id from film where title = 'Hunchback Impossible')
;


-- 2. List all films whose length is longer than the average of all the films.
select title, avg(length) from film
where length > (select avg(length) from film)
group by title
;


-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
select f.title, concat(a.first_name, ' ',a.last_name)
from actor a
join film_actor fa using(actor_id)
join film f using(film_id)
where film_id = (select film_id from film where title = 'Alone Trip')
;


-- 4. Sales have been lagging among young families, and you wish to target all family movies 
-- for a promotion. Identify all movies categorized as family films.
select f.title, name
from film f
join film_category fc using(film_id)
join category using(category_id)
where category_id = (select category_id from category where name = 'Family')
;


-- 5. Get name and email from customers from Canada using subqueries. 
-- Do the same with joins. Note that to create a join, you will have to identify the correct tables 
-- with their primary keys and foreign keys, that will help you get the relevant information.
select concat(c.first_name, ' ',c.last_name) as name, c.email, co.country
from customer c
join address a using(address_id)
join city ci using(city_id)
join country co using(country_id)
where co.country_id = (select country_id from country where country = 'Canada')
;


-- 6. Which are films starred by the most prolific actor? 
-- Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then 
-- use that actor_id to find the different films that he/she starred.
select f.title, concat(a.first_name, ' ',a.last_name) as name_actor
from actor a
join film_actor fa using(actor_id)
join film f using(film_id)
where actor_id = (select actor_id from film_actor group by actor_id order by count(film_id) desc limit 1)
;


-- 7. Films rented by most profitable customer. 
-- You can use the customer table and payment table 
-- to find the most profitable customer ie the customer that has made the largest sum of payments
select title 
from film 
join inventory using(film_id)
join rental using(inventory_id)
join customer using(customer_id)
where customer_id = (select customer_id from payment group by customer_id order by sum(amount) desc limit 1)
;


-- 8. Get the client_id and the total_amount_spent of those clients who spent 
-- more than the average of the total_amount spent by each client.
select customer_id, sum(amount) 
from payment
group by customer_id
having sum(amount) > (select avg(amount) from payment)
order by sum(amount) desc
;


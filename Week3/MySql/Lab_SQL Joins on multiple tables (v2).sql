use sakila;

-- 1. Write a query to display for each store its store ID, city and country.
select s.store_id, ci.city, co.country 
from store s
join address a using(address_id)
join city ci using(city_id)
join country co using(country_id)
;


-- 2. Write a query to display how much benefit amount, in dollars, each store brought in.
select s.store_id, sum(p.amount) as total 
from store s
join staff t using(store_id)
join payment p using(staff_id)
group by s.store_id
;


-- 3. What is the average running time of films by category?
select c.name, avg(f.length) 
from film f
join film_category fc using(film_id)
join category c using(category_id)
group by c.name
;


-- 4. Which film categories are longest on average?
select c.name, avg(f.length) 
from film f
join film_category fc using(film_id)
join category c using(category_id)
group by c.name
order by avg(f.length) desc
;

-- 5. Display the most frequently rented movies in descending order.
select f.title, count(rental_id)
from rental r
join inventory i using(inventory_id)
join film f using(film_id)
group by f.title
order by count(rental_id) desc
;

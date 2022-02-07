use sakila;
#1. Using the rental table, find out how many rentals were processed by each employee.
select staff_id, count(rental_id) as Total_rentals
from rental
group by staff_id;


#2. Using the film table, find out how many films were released.
select count(film_id) as Total_films_released 
from film where release_year <= '2006';


#3. Using the film table, find out how many films there are of each rating. 
#Sort the results in descending order of the number of films.
select rating, count(film_id) AS Films_byrate 
from film
group by rating
order by Films_byrate desc;


#4. Which kind of movies (rating) have a mean duration of more than two hours?
select rating, avg(length) AS Films_avg
from film
group by rating
having Films_avg > '120';

-- 3.04 Activity 2
-- -- From the following columns, determine if they can be Primary key PK or not.
-- -- Product_id - yes
-- -- Phone number - yes
-- -- First name - no



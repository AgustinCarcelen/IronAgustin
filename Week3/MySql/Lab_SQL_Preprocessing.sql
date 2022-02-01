#1. Select all the actors with the first name "Scarlett".
USE sakila;
select * from actor where first_name = 'SCARLETT';

#2. How many films (movies) are available for rent and how many films have been rented?
select count(distinct(inventory.inventory_id)) as total_films, count(distinct(rental.rental_id)) as Rented_films from inventory, rental;

#3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select max(length) as Max_duration, min(length) as Min_duration from film;

#4. What's the average movie duration expressed in format (hours, minutes)?
select concat(floor(avg(length)/60),'h:',floor(avg(length)%60), 'min')  as Average_movie_duration from film;

#5. How many distinct (different) actors' last names are there?
select count(distinct(last_name)) as Diferent_actors_last_name from actor;

#6. Since how many days has the company been operating (check DATEDIFF() function)?
select datediff(now() , min(rental_date)) as Days_operating from rental;

#7. Show rental info with additional columns month and weekday. Get 20 results.
select *, 
date_format(convert(rent.rental_date,Date), '%W') as Weekday,
date_format(convert(rent.rental_date,Date), '%m') as Month from rental as rent limit 20;

#8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select *, 
date_format(convert(rent.rental_date,Date), '%W') as Wkday,
case
when date_format(convert(rent.rental_date,Date), '%W') = 'Saturday' then 'Weekend'
when date_format(convert(rent.rental_date,Date), '%W') = 'Sunday' then 'Weekend'
else 'Workday'
END
as Day_type
from rental as rent;

#9. How many rentals were in the last month of activity?
select count(rental_id) as Rentals_last_month from rental WHERE (rental_date >= '2006-01-14 00:00:00') AND (rental_date <= '2006-02-14 15:16:003');



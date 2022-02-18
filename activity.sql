update film set title='UPDATED TITLE 1' where film_id=1;
update film set title='UPDATED TITLE 2' where film_id=2;
select title from film where film_id=1 OR film_id=2;


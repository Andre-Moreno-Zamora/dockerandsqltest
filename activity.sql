/*
    STEPS FOR RUNNING THIS DOCKER AND MYSQL TEST

    Prerequisites:
     - Docker installed on your machine

    1. Clone the whole project from the GitHub repository (https://github.com/Andre-Moreno-Zamora/dockerandsqltest.git)
        into your machine.

    2. Open CMD and use "cd" command to go the directory of your application

    3. Use the following command:

        docker-compose -f docker-compose.yaml up -d

    4. Use the "docker ps" command to display the current running containers.
        You should have the container in that list with the name "mysqlactivity-mysqldb-1",
        Please copy that container's ID for next instructions.

    5. Import the sakila-db database schema using this docker command, 
        please replace <container-id> with your current running mysqlactivity-mysqldb-1 container id:
            
            docker exec -i <container-id> mysql -uroot -pPassW0rd sakila < app/sakila-schema.sql

    6. Populate the sakila-db database using this docker command,
        please replace <container-id> with your current running mysqlactivity-mysqldb-1 container id:

            docker exec -i <container-id> mysql -uroot -pPassW0rd sakila < app/sakila-data.sql
    
    7. Execute and enter the container's interactive terminal by using the following command
        please replace <container-id> with your current running mysqlactivity-mysqldb-1 container id:

            docker exec -it <container-id> mysql -p

    8. Enter the password for accessing mysql (the password is: PassW0rd )

    9. Please run the following SQL statements
*/

/* 
    Activities:

    1. Inside sakila db modify 2 film records values
*/
update film set title='UPDATED TITLE 1' where film_id=1;
update film set title='UPDATED TITLE 2' where film_id=2;
select title from film where film_id=1 OR film_id=2;

/*
    2. List of movies by actor
*/
select CONCAT(a.first_name, ' ', a.last_name) as Actor, f.title as Film from film f inner join film_actor b ON f.film_id = b.film_id inner join actor a on b.actor_id = a.actor_id order by a.first_name;

/*
    3. Count number of movies per actor
*/
select count(b.actor_id) as num_films, CONCAT(a.first_name, ' ', a.last_name) as Actor from actor a inner join film_actor b on a.actor_id = b.actor_id inner join film f on b.film_id = f.film_id group
by b.actor_id order by num_films desc;

/*
    6. Count movie languages
*/
select count(f.language_id) as num_languages_on_films, l.name as Language from film f right join language l on f.language_id = l.language_id group by l.language_id order by num_languages_on_films desc
;

/*
    7. Calculate average cost for replacement of a film
*/
select AVG(replacement_cost) as average_replacement_cost from film;


/*
    8. Do a store procedure to update the film
*/
DELIMITER // ;
create procedure sp_updatefilm ( IN id smallint, IN film_name varchar(128) )
BEGIN
    update film
    set
    title = film_name WHERE film_id = id;
END //

Delimiter ; //
CALL sp_updatefilm(4, 'UPDATED FILM THROUGH PROCEDURE');
SELECT * FROM film WHERE film_id=4;
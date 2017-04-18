-- 1.List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr = 1962;

-- 2. Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4. What id number does the actor 'Glenn Close' have?
SELECT id as Glen_Close_id
FROM actor
WHERE name = 'Glenn Close';

-- 5. What is the id of the film 'Casablanca'
SELECT id AS casablanca_id
FROM movie
WHERE title = 'Casablanca';

-- 6. Obtain the cast list for 'Casablanca'.
SELECT name
FROM actor
JOIN casting
  ON id=actorid
WHERE movieid = 11768;

-- 7. Obtain the cast list for the film 'Alien'
SELECT name
FROM actor
JOIN casting
  ON id=actorid
WHERE movieid = (SELECT id FROM movie WHERE title = 'Alien');

-- 8. List the films in which 'Harrison Ford' has appeared
SELECT title
FROM movie
JOIN casting
  ON casting.movieid = movie.id
  JOIN actor
    ON actor.id = actorid
WHERE actor.name = 'Harrison Ford';

--  9. List the films where 'Harrison Ford' has appeared - but not in the starring role.
SELECT title
FROM movie
JOIN casting
  ON casting.movieid = movie.id
  JOIN actor
    ON actor.id = actorid
WHERE casting.ord <> 1
  AND actor.name = 'Harrison Ford';

-- 10.List the films together with the leading star for all 1962 films.
SELECT  movie.title
      , actor.name
FROM movie
JOIN casting
  ON casting.movieid = movie.id
  JOIN actor
    ON actor.id = casting.actorid
WHERE yr = 1962
  AND ord = 1

-- 11. Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr, COUNT(title) AS num_movies
FROM movie
JOIN casting
  ON movie.id = casting.movieid
  JOIN actor
    ON casting.actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title) > 2;

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT DISTINCT m.title, a.name as lead_actor
FROM (SELECT movie.*
      FROM movie
      JOIN casting
      ON casting.movieid = movie.id
      JOIN actor
      ON actor.id = casting.actorid
      WHERE actor.name = 'Julie Andrews') AS m
JOIN (SELECT actor.*, casting.movieid AS movieid
      FROM actor
      JOIN casting
      ON casting.actorid = actor.id
      WHERE casting.ord = 1) as a
ON m.id = a.movieid
ORDER BY m.title;

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT actor.name
FROM movie
JOIN casting
  ON casting.movieid = movie.id
  JOIN actor
    ON actor.id = casting.actorid
WHERE ord = 1
GROUP BY actor.name
HAVING COUNT(movie.title) >= 30;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT  title
      , num_actors
FROM movie
JOIN (SELECT movieid, COUNT(actorid) as num_actors
      FROM casting
      GROUP BY movieid) AS n
  ON n.movieid =  movie.id
WHERE yr = 1978
ORDER BY  num_actors DESC
        , title;

-- 15. List all the people who have worked with 'Art Garfunkel'
SELECT DISTINCT name
FROM casting
JOIN actor
ON actor.id=casting.actorid
WHERE casting.movieid IN (SELECT movieid
      FROM casting
      JOIN actor
      ON actor.id = casting.actorid
      WHERE name = 'Art Garfunkel')
AND name <> 'Art Garfunkel';

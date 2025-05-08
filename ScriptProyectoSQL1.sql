 --1.Crea el esquema de la BBDD.
 --2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.

SELECT f.title , f.rating 
FROM film AS f 
WHERE "rating" = 'R'; 

 --3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40

SELECT a.first_name , a.last_name 
FROM actor AS a 
WHERE a.actor_id BETWEEN 30 AND 40;


 --4. Obtén las películas cuyo idioma coincide con el idioma original.

SELECT f.film_id , f.original_language_id , f.language_id 
FROM film AS f 
INNER JOIN "language" AS l 
ON f.original_language_id = f.language_id ; 

 --5. Ordena las películas por duración de forma ascendente.

SELECT film_id , f.title , f.length 
FROM film AS f 
ORDER BY f.length ASC; 

 --6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.

SELECT a.first_name , a.last_name 
FROM actor AS a 
WHERE a.last_name ILIKE '%Allen%';


 --7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.
 
SELECT COUNT (f.rating ), f.rating 
FROM film AS f 
GROUP BY f.rating; 


 --8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.
 
SELECT  f.title , f.rating , f.length
FROM film AS f 
WHERE f.rating = 'PG-13' OR f.length > 180;


 --9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
 
SELECT VARIANCE (f.replacement_cost) AS "Variabilidad" 
FROM film AS f ;


--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT MIN (f.length ) AS "Duración_mínima", MAX (f.length) AS "Duración_máxima"
FROM film AS f ;


--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
 
SELECT r.rental_id, r.rental_date AS "Fecha_alquiler", p.amount AS "Costo"
FROM rental r
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY r.rental_date DESC
OFFSET 2
LIMIT 1;

--12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.
 
SELECT f.title AS "Película", f.rating AS "Clasificación"
FROM film AS f 
WHERE f.rating <>'NC-17' AND f.rating <>'G'; 


--13. Encuentra el promedio de duración de las películas para cada 
clasificación de la tabla film y muestra la clasificación junto con el 
promedio de duración.

SELECT ROUND(AVG (f.length ),2) AS "Promedio_duración", f.rating AS "Clasificación"
FROM film AS f 
GROUP BY "Clasificación";


--14.  Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT f.title AS "Titulo" , f.length AS "Duración" 
FROM film AS f 
WHERE f.length > 180;

--15.  ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM (p.amount ) AS "Total_generado"
FROM payment AS p ;


 --16. Muestra los 10 clientes con mayor valor de id.

SELECT c.customer_id
FROM customer AS c 
ORDER BY customer_id DESC
LIMIT 10;


--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
 
SELECT a.first_name AS "Nombre" , a.last_name AS "Apellido", f.title AS "Título_película" 
FROM actor AS a 
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id 
INNER JOIN film AS f 
ON fa.film_id = f.film_id 
WHERE f.title ILIKE 'Egg Igby';


--18. Selecciona todos los nombres de las películas únicos.
 
SELECT DISTINCT(f.title) 
FROM film AS f ;


--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
 
SELECT f.title AS "Título_película", f.length AS "Duración", c."name"  AS "Categoria"
FROM film AS f 
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON fc.category_id = c.category_id 
WHERE c."name" ILIKE 'comedy' AND f.length > 180;


--20.  Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
 
SELECT  c."name" AS "Categoría", AVG ( f.length ) AS "Promedio_duración"
FROM film AS f 
INNER JOIN film_category AS fc 
ON fc.film_id = f.film_id 
INNER JOIN category AS c 
ON c.category_id = fc.category_id
GROUP BY c."name" 
HAVING AVG (f.length) > 110;



--21. ¿Cuál es la media de duración del alquiler de las películas?
 

SELECT AVG (f.rental_duration ) AS "Promedio_duración_alquiler"
FROM film AS f ;


--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT CONCAT (first_name, ' ', a.last_name ) AS "Nombre_y_apellido"
FROM actor AS a;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
 
SELECT DATE (r.rental_date) AS "Día_alquiler", COUNT (r.rental_id ) AS "Cantidad_alquileres"
FROM rental AS r 
GROUP BY "Día_alquiler" 
ORDER BY "Cantidad_alquileres" DESC;


--24. Encuentra las películas con una duración superior al promedio.
 
SELECT f.title AS "Película" , f.length AS "Duración"
FROM film AS f 
WHERE f.length > (
       SELECT AVG (length) AS "Promedio_duración"
       FROM film AS f 
);
    


--25. Averigua el número de alquileres registrados por mes.

SELECT COUNT (r.rental_id) AS "Número_alquileres", TO_CHAR(r.rental_date , 'TMMonth YYYY') AS "Mes_año"
FROM rental AS r 
GROUP BY "Mes_año";


--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT AVG (p.amount) AS "Promedio_total_pagado",  
       STDDEV (p.amount ) AS "Desviación_total_pagado",
       VARIANCE (p.amount )AS "Varianza_total_pagado)"
FROM payment AS p ;



--27. ¿Qué películas se alquilan por encima del precio medio?
 
SELECT f.title AS "Película", f.rental_rate "Precio_alquiler"
FROM film AS f 
WHERE f.rental_rate >(
      SELECT AVG (f.rental_rate )
      FROM film AS f
);




--28. Muestra el id de los actores que hayan participado en más de 40 películas.
 
SELECT a.actor_id , COUNT (fa.film_id) AS "Cantidad_películas"
FROM actor AS a  
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id 
HAVING COUNT (fa.film_id) > 40; 



--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT i.film_id AS "Peícula_Id", COUNT (i.inventory_id) AS "Cantidad_inventario"
FROM inventory AS i 
GROUP BY film_id 
ORDER BY film_id;


--30. Obtener los actores y el número de películas en las que ha actuado.
 
SELECT CONCAT (a.first_name , ' ', a.last_name ) AS "Actor",
       COUNT (fa.film_id ) AS "Cantidad_películas"       
FROM film_actor AS fa 
INNER JOIN actor AS a 
ON a.actor_id = fa.actor_id
GROUP BY "Actor" ;


--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
 
SELECT fa.film_id, f.title AS "Título_película", a.actor_id , 
       CONCAT (first_name, ' ', a.last_name ) AS "Actor" 
FROM film_actor AS fa 
LEFT JOIN actor AS a 
ON a.actor_id = fa.actor_id 
LEFT JOIN film AS f 
ON f.film_id = fa.film_id;


--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

SELECT a.actor_id , 
       CONCAT (first_name, ' ', a.last_name ) AS "Actor",
       fa.film_id, f.title AS "Título_película"
FROM actor AS a 
LEFT JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id 
LEFT JOIN film AS f 
ON f.film_id = fa.film_id 



--33. Obtener todas las películas que tenemos y todos los registros de alquiler.
 
SELECT i.film_id, COUNT (r.rental_id ) AS "Registros_alquiler"
FROM rental AS r 
FULL JOIN inventory AS i 
ON i.inventory_id = r.inventory_id 
GROUP BY i.film_id 
ORDER BY film_id;



--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT p.customer_id , SUM (p.amount) AS "Monto_gastado" 
FROM payment AS p 
GROUP BY customer_id 
ORDER BY "Monto_gastado" DESC
LIMIT 5;



--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
 
SELECT a.first_name AS "Nombre", a.last_name AS "Apellido", a.actor_id  
FROM actor AS a 
WHERE a.first_name ILIKE 'Johnny';


--36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
 
SELECT a.first_name AS "Nombre", a.last_name AS "Apellido"
FROM actor AS a; 

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MIN (a.actor_id ) AS "ID_mas_bajo", MAX (a.actor_id ) AS "ID_mas_alto"
FROM actor AS a ;


--38. Cuenta cuántos actores hay en la tabla “actorˮ.

SELECT COUNT (a.actor_id) AS "Cantidad_actores"
FROM actor AS a;


 --39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT a.last_name AS "Apellido", a.first_name AS "Nombre", a.actor_id
FROM actor AS a 
ORDER BY "Apellido" ASC;


--40.  Selecciona las primeras 5 películas de la tabla “filmˮ.

SELECT f.film_id , f.title 
FROM film AS f 
LIMIT 5;


--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido? KENNETH, PENELOPE y JULIA (4 veces)
 
SELECT a.first_name AS "Nombre", COUNT (first_name) AS "Cantidad"
FROM actor AS a 
GROUP BY a.first_name 
ORDER BY "Cantidad" DESC;



--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT r.rental_id ,  c.first_name AS "Nombre_cliente", c.last_name AS "Apellido_Cliente", r.customer_id
FROM rental AS r 
INNER JOIN customer AS c 
ON c.customer_id = r.customer_id ;


--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
 
SELECT c.customer_id , 
       CONCAT (c.first_name ,' ', c.last_name ) AS "Cliente",
       r.rental_id 
FROM customer AS c 
LEFT JOIN rental AS r 
ON c.customer_id = r.customer_id; 


--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

SELECT *
FROM film AS f 
CROSS JOIN category AS c ;

/* Considero que no aporta valor, ya que devuelve tablas muy grandes y en este caso mi objetivo
no es obtener todas las combinaciones posibles, sino sumar información de una tabla a la otra.
Creo que podría ser mejor usar otro tipo de JOIN (como un FULL JOIN y así obervar coincidencias y
no coincidencias, y valores nulos, etc) para hacerlo de manera mas efectiva */



--45. Encuentra los actores que han participado en películas de la categoría 'Action'.

SELECT a.actor_id,
       CONCAT (first_name, ' ', a.last_name ) AS "Actor",
       c."name" AS "Categoría",
       f.title AS "Película"
FROM actor AS a 
FULL JOIN film_actor AS fa 
ON a.actor_id =fa.actor_id 
FULL  JOIN film AS f 
ON fa.film_id = f.film_id 
FULL JOIN film_category AS fc 
ON f.film_id = fc.film_id 
FULL JOIN category AS c 
ON fc.category_id = c.category_id 
WHERE c."name" ILIKE 'Action';


-- 46. Encuentra todos los actores que no han participado en películas.

SELECT a.actor_id,
       CONCAT (first_name, ' ', a.last_name ) AS "Actor"
FROM actor AS a 
WHERE NOT EXISTS (
            SELECT 1
            FROM film_actor AS fa  
            WHERE fa.actor_id = a.actor_id 
);


--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT CONCAT (first_name, ' ', a.last_name ) "Actor",
       COUNT (fa.film_id) AS "Cantidad_películas"
FROM actor AS a 
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id 
GROUP BY "Actor";


--48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.

CREATE VIEW actor_num_peliculas AS 
SELECT CONCAT (first_name, ' ', a.last_name ) "Actor",
       COUNT (fa.film_id) AS "Cantidad_películas"
FROM actor AS a 
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id 
GROUP BY "Actor";

SELECT *
FROM actor_num_peliculas


--49. Calcula el número total de alquileres realizados por cada cliente.
 
SELECT customer_id, 
       COUNT (r.rental_id ) AS "Cantidad_alquileres"
FROM rental AS r 
GROUP BY r.customer_id 
ORDER BY r.customer_id ;



--50. Calcula la duración total de las películas en la categoría 'Action'.
 
SELECT SUM (f.length) AS "Duración_total", c."name" AS "Categoria"
FROM film AS f 
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON fc.category_id = c.category_id 
WHERE c."name" ILIKE 'Action'
GROUP BY "Categoria" ;



--51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.

WITH cliente_rentas_temporal AS (
SELECT customer_id, COUNT(r.rental_id ) AS "Cantidad_alquileres"
FROM rental AS r 
GROUP BY customer_id 
)
SELECT customer_id, "Cantidad_alquileres"
FROM cliente_rentas_temporal;


--52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
 
WITH peliculas_alquiladas AS(
SELECT COUNT(r.rental_id) AS "Cantidad_alquileres",
       i.film_id 
FROM rental AS r 
INNER JOIN inventory AS i 
ON r.inventory_id = i.inventory_id 
GROUP BY film_id 

)
SELECT film_id, "Cantidad_alquileres" 
FROM peliculas_alquiladas
WHERE "Cantidad_alquileres" >=10 ;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

SELECT CONCAT (first_name, ' ', c.last_name ) AS "Cliente",
       f.title AS "Titulo_película", 
       r.return_date AS "Fecha_devolución"
FROM customer AS c 
INNER JOIN rental AS r 
ON c.customer_id = r.customer_id
INNER JOIN inventory AS i 
ON i.inventory_id = r.inventory_id 
INNER JOIN film AS f 
ON i.film_id = f.film_id 
WHERE r.return_date IS NULL 
    AND c.first_name ILIKE 'Tammy' AND c.last_name ILIKE 'Sanders'
ORDER BY "Titulo_película" ;

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.
 
SELECT a.first_name AS "Nombre", a.last_name AS "Apellido",
       c."name" AS "Categoría", f.title AS "Película"
FROM actor AS a 
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id 
INNER JOIN film AS f 
ON fa.film_id = f.film_id 
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON fc.category_id = c.category_id 
WHERE c."name" ILIKE 'Sci-Fi'
ORDER BY "Apellido" ;


/*55.  Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus 
Cheaperʼ se alquilara por primera vez. Ordena los resultados 
alfabéticamente por apellido.*/

SELECT DISTINCT a.first_name AS "Nombre_actor", a.last_name AS "Apellido_actor"
FROM actor a
INNER JOIN film_actor fa 
ON a.actor_id = fa.actor_id
INNER JOIN film f 
ON fa.film_id = f.film_id
INNER JOIN inventory i 
ON f.film_id = i.film_id
INNER JOIN rental r 
ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
    FROM rental r2
    INNER JOIN inventory i2 
    ON r2.inventory_id = i2.inventory_id
    INNER JOIN film f2 
    ON i2.film_id = f2.film_id
    WHERE f2.title ILIKE 'Spartacus Cheaper'
)
ORDER BY a.last_name;



/*56. Encuentra el nombre y apellido de los actores que no han actuado en 
ninguna película de la categoría ‘Musicʼ.*/

SELECT a.first_name AS "Nombre_actor", a.last_name AS "Apellido_actor",
     c."name" AS "CAtegoria"
FROM actor AS a 
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id 
INNER JOIN film AS f 
ON fa.film_id = f.film_id 
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON fc.category_id = c.category_id 
WHERE NOT EXISTS (
        SELECT 1 
        FROM category AS c2 
        WHERE c."name" ILIKE 'Music'
); 


--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
 
SELECT title, (r.return_date - r.rental_date ) AS "Días_alquiler"
FROM rental AS r 
INNER JOIN inventory AS i 
ON r.inventory_id = i.inventory_id 
INNER JOIN film AS f 
ON i.film_id = f.film_id 
WHERE r.return_date IS NOT NULL 
   AND EXTRACT(DAY FROM(r.return_date - r.rental_date))>8;



--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

SELECT f.title, c."name" AS "CAtegoría"
FROM film AS f 
INNER JOIN film_category AS fc 
ON f.film_id =fc.film_id 
INNER JOIN category AS c 
ON fc.category_id = c.category_id 
WHERE c."name" ILIKE 'Animation';



/*59. Encuentra los nombres de las películas que tienen la misma duración 
que la película con el título ‘Dancing Feverʼ. Ordena los resultados 
alfabéticamente por título de película.*/

SELECT f.title , f.length 
FROM film AS f 
WHERE length = (
   SELECT f.length 
   FROM film AS f 
   WHERE f.title ILIKE 'Dancing Fever') 
ORDER BY f.title ;



 /*60. Encuentra los nombres de los clientes que han alquilado al menos 7 
películas distintas. Ordena los resultados alfabéticamente por apellido.*/
 
SELECT c.first_name AS "Nombre_cliente", c.last_name AS "Apellido_cliente",
       COUNT(DISTINCT r.rental_id) AS "Cantidad_alquileres"
FROM rental AS r 
INNER JOIN customer AS c 
ON r.customer_id = c.customer_id 
GROUP BY c.customer_id  
HAVING COUNT(DISTINCT r.rental_id) >= 7 
ORDER BY "Apellido_cliente" ; 


/*61. Encuentra la cantidad total de películas alquiladas por categoría y 
muestra el nombre de la categoría junto con el recuento de alquileres.*/

SELECT  c."name" AS "Categoría", 
        COUNT(DISTINCT r.rental_id) AS "Cantidad_alquileres"
FROM rental AS r 
INNER JOIN inventory AS i 
ON r.inventory_id = i.inventory_id 
INNER JOIN film AS f 
ON i.film_id = f.film_id 
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON fc.category_id = c.category_id 
GROUP BY "Categoría" ; 



--62. Encuentra el número de películas por categoría estrenadas en 2006.
 
SELECT COUNT(f.release_year) AS "Cantidad_estrenos", c."name" AS "Categoría"
FROM film AS f 
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON fc.category_id = c.category_id 
WHERE f.release_year = 2006
GROUP BY "Categoría" ;


--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
 
SELECT s.store_id AS "Tienda", s.staff_id AS "Empleado_id", 
       CONCAT(s.first_name , ' ', s.last_name ) AS "Trabajador" 
FROM staff AS s 
CROSS JOIN store AS s2 ;


/*64 Encuentra la cantidad total de películas alquiladas por cada cliente y 
muestra el ID del cliente, su nombre y apellido junto con la cantidad de 
películas alquiladas.*/

SELECT c.customer_id,
       CONCAT (first_name, ' ', c.last_name ) AS "Empleado",
       COUNT(DISTINCT rental_id) AS "Cantidad_alquileres"      
FROM customer AS c 
INNER JOIN rental AS r 
ON c.customer_id = r.customer_id 
GROUP BY c.customer_id;




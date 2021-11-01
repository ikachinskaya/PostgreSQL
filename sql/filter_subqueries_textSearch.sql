-- Количество всех телефонов
SELECT sum(quantity)
FROM phones_to_orders;
------------------------------------
-- Отсортировать телефоны от дорогих к дешевым ORDER BY id ASC | DESC
SELECT *
FROM phones
ORDER BY price DESC;
------------------------------------
-- Отсортировать юзеров по росту и имени
SELECT *
FROM users
ORDER BY height DESC,
  "firstName" ASC;
------------------------------------
-- Наименьшее число телефонов среди всех брендов
SELECT sum(quantity) AS "amount",
  brand
FROM phones
GROUP BY brand
ORDER BY "amount";
------------------------------------
-- ФИЛЬТРАЦИЯ ГРУПП --
/*
 Число телефонов среди всех брендов, 
 при этом телефонов у бренда должно быть меньше 5000
 */
SELECT sum(quantity) AS "amount",
  brand
FROM phones
GROUP BY brand
HAVING sum(quantity) < 5000
ORDER BY "amount";
------------------------------------
/*
 Число телефонов среди всех брендов, 
 при этом телефонов у бренда должно быть больше 7000
 */
SELECT sum(quantity) AS "amount",
  brand
FROM phones
GROUP BY brand
HAVING sum(quantity) > 7000
ORDER BY "amount";
------------------------------------
- - Количество телефонов по каждому бренду с ценой > 5000
SELECT sum(quantity) AS "amount",
  brand
FROM phones
WHERE price > 5000
GROUP BY brand;
------------------------------------
- - Телефоны с ценой > 5000 и количеством > 8000
SELECT brand
FROM (
    SELECT sum(quantity) AS "amount",
      brand
    FROM phones
    WHERE price > 5000
    GROUP BY brand
  ) AS result
WHERE "amount" > 8000;
------------------------------------
/*
 
 Поиск  по тексту
 
 LIKE - с учетом регистра
 ILIKE - без учета регчистра
 
 * | %
 ? | _
 
 SIMILAR TO
 
 first_name ~ '[A-Z]{0,5}'
 ~*
 !~
 !~*
 */
SELECT *
FROM users
WHERE "firstName" ILIKE '%d';
------------------------------------
SELECT *
FROM users
WHERE "firstName" SIMILAR TO '[BDE]{1}.*%d';
------------------------------------
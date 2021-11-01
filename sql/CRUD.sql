/* SELECT */
SELECT *
FROM users;
-------------------
SELECT first_name,
  last_name
FROM users;
-------------------
SELECT *
FROM users
WHERE id = 2;
-------------------
SELECT *
FROM users
WHERE height > 1.50;
-------------------
SELECT *
FROM users
WHERE id % 2 = 0;
-------------------
SELECT *
FROM users
WHERE first_name IN ('Test', 'Ron', 'Jane');
--найдет несколько имен сразу
-------------------
SELECT *
FROM users
WHERE id >= 10
  AND id <= 50;
--==============================================================================
/* UPDATE*/
UPDATE users
SET first_name = 'Ne timofey'
WHERE id = 15
RETURNING *;
--вернет результат запроса
--==============================================================================
/*DELETE*/
DELETE FROM users
WHERE height < 1.5
RETURNING *;
--==========================
--Пользователи, которым меньше 30 лет
SELECT *
FROM users
WHERE age(birthday) < interval '30 years';
--WHERE age(birthday) < make_interval(30);
--WHERE age(birthday) < make_interval(30, 5, 2;
--==============================================================================
/* LIMIT, OFFSET*/
SELECT *
FROM users
LIMIT 10 OFFSET 10;
--количество пользователей на сраницу, сдвиг
--==============================================================================
/*ORDER  - СОРТИРОВКА */
SELECT *
FROM users
ORDER BY first_name DESC
LIMIT 10 OFFSET 10;
--DESC - от большего к меньшему
--==============================================================================
SELECT first_name || ' ' || last_name AS "Имя фамилия",
  id "Айдишник",
  id + 5,
  email AS "Электронная почта"
FROM users
WHERE age(birthday) > make_interval(30)
ORDER BY id ASC
LIMIT 10 OFFSET 20;
--==============================================================================
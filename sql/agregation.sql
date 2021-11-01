/*
 max
 min
 avg
 sum
 count
 */
-- Количество пользователей
SELECT count(*)
FROM users;
------------------------------------
-- Максимальный рост
SELECT max(height)
FROM users;
------------------------------------
-- Минимальный рост
SELECT min(height)
FROM users;
------------------------------------
-- Количество Иванов в таблице
SELECT count(*)
FROM users
WHERE "firstName" = 'John';
------------------------------------
-- Средний вес мужчин
SELECT avg(weight)
FROM users
WHERE "isMale" = true;
------------------------------------
-- Средний вес женщин
SELECT avg(weight)
FROM users
WHERE "isMale" = false;
------------------------------------
-- Средний вес с группировкой по email
SELECT avg(weight),
  email
FROM users
GROUP BY "email";
------------------------------------
-- Средний рост по именам 
SELECT avg(height),
  "firstName"
FROM users
GROUP BY "firstName",
  "lastName";
------------------------------------
-- Количество пользователей с ростом > 1.5
SELECT count (*)
FROM users
WHERE height > 1.5;
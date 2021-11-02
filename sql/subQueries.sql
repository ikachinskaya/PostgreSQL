-- Сортировка юзером по возрасту
-- найти возраст 1 юзера
SELECT EXTRACT(
    YEAR
    FROM age(birthday)
  ) AS age,
  *
FROM users
ORDER BY age DESC;
-------------------------
--формируем подзапрос
SELECT users_with_age.*
FROM (
    SELECT EXTRACT(
        YEAR
        FROM age(birthday)
      ) AS age,
      *
    FROM users
  ) AS "users_with_age"
ORDER BY users_with_age.age;
-------------------------
--Количество юзеров определенного возраста
SELECT count(age) AS "Количество",
  age
FROM (
    SELECT EXTRACT(
        YEAR
        FROM age(birthday)
      ) AS age,
      *
    FROM users
  ) AS "users_with_age"
GROUP BY age
HAVING age BETWEEN 25 AND 42
ORDER BY users_with_age.age;
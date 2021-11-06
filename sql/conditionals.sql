-- возвращать нужно одинаковый тип данных
SELECT (
    CASE
      WHEN 2 + 2 = 4 THEN 'Нормальная математика'
      WHEN 2 + 2 = 5 THEN 'Интересная математика'
    END
  );
------------------------------------------------
-- 1 вариант
SELECT id,
  "firstName",
  "lastName",
  CASE
    WHEN "isMale" THEN 'Male'
    ELSE 'Female'
  END AS "gender",
  "isMale"
FROM users;
------------------------------------------------
-- 2 вариант
SELECT id,
  "firstName",
  "lastName",
  (
    CASE
      "isMale"
      WHEN true THEN 'Male'
      WHEN false THEN 'Female'
    END
  ) AS "gender",
  "isMale"
FROM users;
------------------------------------------------
SELECT CASE
    WHEN EXTRACT (
      month
      FROM birthday
    ) BETWEEN 3 AND 5 THEN 'Весна'
    WHEN EXTRACT (
      month
      FROM birthday
    ) BETWEEN 6 AND 8 THEN 'Лето'
    WHEN EXTRACT (
      month
      FROM birthday
    ) BETWEEN 9 AND 11 THEN 'Осень'
    ELSE 'Зима'
  END AS season,
  birthday,
  id,
  email
FROM users;
------------------------------------------------
SELECT CASE
    WHEN price < 10000 THEN 'Бюджет'
    WHEN price BETWEEN 10000 AND 20000 THEN 'Средний'
    ELSE 'Флагман'
  END AS category,
  id,
  brand,
  model,
  price
FROM phones;
------------------------------------------------
SELECT id,
  brand,
  model,
  CASE
    WHEN brand ILIKE 'Iphone' THEN 'Apple'
    ELSE 'Not Apple'
  END AS "APPLE"
FROM phones;
------------------------------------------------
/*
 COALESCE возвращает первый попавшийся аргумент, отличный от NULL
 Если все аргументы =NULL, результатом будет NULL
 Тип данных должен совпадать
 */
--вернет 15
SELECT coalesce(NULL, NULL, 15);
---------------------------------
-- вернет fdgdfg
SELECT coalesce(NULL, 'fdgdfg');
---------------------------------
-- вместо NULL выведет -5000
INSERT INTO a
VALUES('TES');
SELECT x,
  coalesce(v, -5000) AS v
FROM a;
---------------------------------
/*
 NULLIF возвращает NULL, если значение 1===значение 2
 возвращает значение1, если значение 1!==значение 2
 для обратной операции COALESCE
 */
---------------------------------
-- вернет null
SELECT nullif(10, 10);
---------------------------------
-- вернет null
SELECT nullif(null, 10);
------------------------------------------------
/*
 GREATEST вернет наибольшее значение из списка
 LEAST вернет наименьшее значение из списка
 */
--вернет 999 для каждого столбца
SELECT greatest(1, 2, 4, 5, 999, 7, 2, 38)
FROM users;
---------------------------------
-- не работает
SELECT GREATEST(orders_price.full_price)
FROM (
    SELECT sum (phones.price * phones_to_orders.quantity) AS full_price
    FROM orders
      JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
      JOIN phones ON phones.id = phones_to_orders."phoneId"
    GROUP BY orders.id
  ) AS "orders_price"
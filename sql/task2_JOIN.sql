----------------------------------
--Найти самый популярный телефон
SELECT brand,
  model,
  sum(phones_to_orders.quantity) AS "Количество покупок"
FROM phones
  JOIN phones_to_orders ON phones_to_orders."phoneId" = phones.id
GROUP BY phones.brand,
  phones.model
ORDER BY "Количество покупок" DESC
LIMIT 1;
----------------------------------
-- Найти самого растратного пользователя
-- пользователи
SELECT "firstName" || ' ' || "lastName" AS fullName
FROM users
GROUP BY fullName;
----------------------------------
--самый дорогой заказ
SELECT "orderId",
  sum(phones.price * phones_to_orders.quantity) AS "Стоимость заказа"
FROM phones_to_orders
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY "orderId"
ORDER BY "Стоимость заказа" DESC
LIMIT 1;
----------------------------------
-- растратный пользователь
-- JOIN
SELECT phones_to_orders."orderId" AS "Id заказа",
  "firstName" || ' ' || "lastName" AS "Клиент",
  sum(phones.price * phones_to_orders.quantity) AS "Стоимость заказа"
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY phones_to_orders."orderId",
  "Клиент"
ORDER BY "Стоимость заказа" DESC
LIMIT 1;
----------------------------------
-- WHERE
SELECT users.id AS "Id пользователя",
  orders.id AS "Id заказа",
  users."lastName" || ' ' || users."firstName" AS "Клиент",
  sum(phones.price * phones_to_orders.quantity) AS "Стоимость заказа"
FROM users,
  phones,
  phones_to_orders,
  orders
WHERE phones_to_orders."phoneId" = phones.id
  AND phones_to_orders."orderId" = orders.id
  AND orders."userId" = users.id
GROUP BY users.id,
  orders.id,
  "Клиент"
ORDER BY "Стоимость заказа" DESC
LIMIT 1;
----------------------------------
-- извлечь пользователя и количество моделей телефонов, которые он покупал
-- количество телефонов
SELECT users.id AS "Id пользователя",
  users."lastName" || ' ' || users."firstName" AS "Клиент",
  sum (phones_to_orders.quantity) AS "Количество телефонов"
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY users.id,
  "Клиент";
----------------------------------
-- количество моделей телефонов
-- WHERE
----------------------------------
SELECT phones_to_orders."orderId",
  count (phones_to_orders."phoneId") AS "Количество моделей"
FROM phones_to_orders,
  phones,
  orders
WHERE phones_to_orders."phoneId" = phones.id
  AND phones_to_orders."orderId" = orders.id
GROUP BY phones_to_orders."orderId"
ORDER BY phones_to_orders."orderId";
----------------------------------
-- JOIN
SELECT phones_to_orders."orderId",
  count (phones_to_orders."phoneId") AS "Количество моделей"
FROM phones_to_orders
  JOIN orders ON orders.id = phones_to_orders."orderId"
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY phones_to_orders."orderId"
ORDER BY phones_to_orders."orderId";
----------------------------------
-- id пользователя, id телефона, который он покупал
SELECT users.id AS "Id пользователя",
  phones_to_orders."phoneId" AS "Id телефона"
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
GROUP BY users.id,
  phones_to_orders."phoneId"
ORDER BY users.id;
---------------------------------
SELECT users_with_phones.id AS "Id пользователя",
  count(users_with_phones."phoneId") as "Количество моделей"
FROM (
    SELECT users.id,
      phones_to_orders."phoneId"
    FROM users
      JOIN orders ON orders."userId" = users.id
      JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
    GROUP BY users.id,
      phones_to_orders."phoneId"
  ) as "users_with_phones"
GROUP BY users_with_phones.id
ORDER BY users_with_phones.id;
----------------------------------
-- все заказы со стоимостью чека выше средней стоимости заказа
--сумма каждого заказа
SELECT orders.id AS "Id заказа",
  sum(phones.price * phones_to_orders.quantity) AS full_price
FROM orders
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY orders.id
ORDER BY orders.id;
----------------------------------
-- средння стоимость заказа
SELECT avg(orders_price.full_price)
FROM (
    SELECT orders.id AS "Id заказа",
      sum(phones.price * phones_to_orders.quantity) AS full_price
    FROM orders
      JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
      JOIN phones ON phones.id = phones_to_orders."phoneId"
    GROUP BY orders.id
    ORDER BY orders.id
  ) as orders_price;
----------------------------------
-- итоговое
SELECT orders.id AS "Id заказа",
  sum(phones.price * phones_to_orders.quantity) AS "Стоимость заказа"
  FROM orders
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY orders.id
HAVING sum(phones.price * phones_to_orders.quantity) > (
    SELECT avg(orders_price.full_price)
    FROM (
        SELECT sum(phones.price * phones_to_orders.quantity) as full_price
        FROM orders
          JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
          JOIN phones ON phones.id = phones_to_orders."phoneId"
        GROUP BY orders.id
      ) as orders_price
  )
  ORDER BY orders.id;
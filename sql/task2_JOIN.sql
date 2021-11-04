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
--Найти самого растратного пользователя
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
  fullName
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
-- все заказы со стоимостью чека выше средней стоимости заказа
--сумма каждого заказа
SELECT orders.id,
  sum(phones.price * phones_to_orders.quantity)
FROM orders
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY orders.id;
----------------------------------
----------------------------------
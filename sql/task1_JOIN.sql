----------------------------------
-- Стоимость каждого совершенного заказа
SELECT phones_to_orders."orderId" AS "Id заказа",
  sum(phones_to_orders.quantity * phones.price) AS "Сумма заказа"
FROM phones_to_orders
  JOIN phones ON phones_to_orders."phoneId" = phones.id
GROUP BY phones_to_orders."orderId"
ORDER BY phones_to_orders."orderId";
----------------------------------
-- Просмотрите все телефоны конкретного заказа
SELECT phones_to_orders."orderId" AS "Id заказа",
  phones.brand AS "Телефоны"
FROM phones_to_orders
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY phones_to_orders."orderId",
  phones.brand
ORDER BY phones_to_orders."orderId";
----------------------------------
--Kоличестов телефонов которое было куплено в определенном заказе
SELECT phones_to_orders."orderId" AS "Id заказа",
  sum(phones_to_orders.quantity) AS "Количество телефонов"
FROM phones_to_orders
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY phones_to_orders."orderId"
ORDER BY phones_to_orders."orderId";
----------------------------------
-- Количество заказов для каждого пользователя
SELECT users.id AS "Id пользователя",
  count(orders."userId") AS "Количество заказов"
FROM users
  JOIN orders ON orders."userId" = users.id
GROUP BY users.id
ORDER BY users.id;
----------------------------------
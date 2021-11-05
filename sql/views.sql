-- VIEW хранит запрос, а не ответ
-- MATERIALIZED VIEW хранит запрос и результат запроса
--============================================
-- ID ПОЛЬЗОВАТЕЛЯ И КОЛИЧЕСТВО ЗАКАЗОВ
SELECT users.id,
  count(orders.id) AS orders_amount
FROM users
  JOIN orders ON orders."userId" = users.id
GROUP BY users.id
ORDER BY users.id;
----------------------------------------------
CREATE VIEW users_with_orders_amount AS
SELECT users.id,
  count(orders.id) AS orders_amount
FROM users
  JOIN orders ON orders."userId" = users.id
GROUP BY users.id
ORDER BY users.id;
----------------------------------------------
DROP VIEW users_with_orders_amount;
----------------------------------------------
SELECT *
FROM users_with_orders_amount;
----------------------------------------------
-- количество заказов > 3
SELECT *
FROM users_with_orders_amount
WHERE orders_amount > 3;
----------------------------------------------
--КАЖДЫЙ ЗАКАЗ И ЕГО СТОИМОСТЬ
SELECT users.id AS "Id пользователя",
  orders.id AS "Id заказа",
  sum(phones.price * phones_to_orders.quantity)
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY users.id,
  orders.id;
----------------------------------------------
CREATE VIEW users_with_orders_with_order_cost AS
SELECT users.id AS "Id пользователя",
  orders.id AS "Id заказа",
  sum(phones.price * phones_to_orders.quantity) AS "Стоимость заказа"
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY users.id,
  orders.id;
----------------------------------------------
DROP VIEW users_with_orders_with_order_cost;
----------------------------------------------
-- ID, EMAIL И ДАТА РОЖДЕНИЯ ПОЛЬЗОВАТЕЛЯ,КОТОРЫЙ ПОКУПАЛ > 700000
SELECT users.id,
  users.email,
  users.birthday
FROM users
  JOIN users_with_orders_with_order_cost AS owc ON users.id = owc."Id пользователя"
WHERE owc."Стоимость заказа" > 700000
GROUP BY users.id
ORDER BY users.id;
----------------------------------------------
CREATE VIEW spam_list AS
SELECT users.id,
  users.email,
  users.birthday
FROM users
  JOIN users_with_orders_with_order_cost AS owc ON users.id = owc."Id пользователя"
WHERE owc."Стоимость заказа" > 700000
GROUP BY users.id
ORDER BY users.id;
----------------------------------------------
-- ИНФОРМАЦИЯ О ПОЛЬЗОВАТЕЛЕ 
CREATE VIEW data_users AS
SELECT id,
  concat("firstName", ' ', "lastName") AS "FullName",
  EXTRACT (
    YEAR
    FROM age(birthday)
  ) AS Age,
  CASE
    "isMale"
    WHEN "isMale" THEN 'Male'
    ELSE 'Female'
  END AS "gender"
FROM users;
----------------------------------------------
--ПОЛЬЗОВАТЕЛЬ И СУММА КАЖДОЙ КОНКРЕТНОЙ КАТЕГОРИИ ТОВАРА В ЕГО ЗАКАЗЕ
SELECT orders."userId" AS "Id заказа",
  sum(phones.price * phones_to_orders.quantity) AS "Стоимость"
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY orders.id
ORDER BY orders.id;
----------------------------------------------
CREATE VIEW users_with_orders_order_with_cost AS
SELECT orders."userId" AS "Id пользователя",
  orders.id AS "Id заказа",
  sum(phones.price * phones_to_orders.quantity) AS "Стоимость"
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY orders.id
ORDER BY orders.id;
----------------------------------------------
DROP VIEW users_with_orders_order_with_cost;
----------------------------------------------
-- СТОИМОСТЬ ВСЕХ ЗАКАЗОВ КАЖДОГО ПОЛЬЗОВАТЕЛЯ
CREATE VIEW users_with_total_cost AS
SELECT owsc."Id пользователя",
  sum(owsc."Стоимость") AS "Общая стоимость"
FROM users_with_orders_order_with_cost AS owsc
GROUP BY owsc."Id пользователя"
ORDER BY owsc."Id пользователя";
----------------------------------------------
--CПАМ-ЛИСТ
CREATE OR REPLACE VIEW spam_list_new AS
SELECT users.email,
  users.birthday,
  users.id
FROM users
  JOIN users_with_total_cost AS owsc ON users.id = owsc."Id пользователя"
WHERE owsc."Общая стоимость" > 4000000
GROUP BY users.id
ORDER BY users.id;
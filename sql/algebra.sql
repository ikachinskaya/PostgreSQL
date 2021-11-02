CREATE TABLE a(x char(3), v int);
----------------------------------
CREATE TABLE b(x char(3), c text);
----------------------------------
INSERT INTO a (x, v)
VALUES ('AAA', 1),
  ('AAB', 2),
  ('AAC', 3),
  ('ABA', 4),
  ('ABB', 5),
  ('ABC', 6),
  ('CCC', 7),
  ('XYZ', 999);
----------------------------------
INSERT INTO b (x, c)
VALUES ('AAA', 'Test 1'),
  ('AAB', 'Test 2'),
  ('AAC', 'Test 3'),
  ('ABA', 'Test 4'),
  ('ABB', 'Test 5'),
  ('ABC', 'Test 6'),
  ('CCC', 'Test 7');
----------------------------------
SELECT *
FROM a;
----------------------------------
SELECT *
FROM b;
----------------------------------
-- Все уникальные значения
SELECT x
FROM a
UNION
SELECT x
FROM b;
----------------------------------
-- Все совпадающие значения
SELECT x
FROM a
INTERSECT
SELECT x
FROM b;
----------------------------------
-- Вычитание
SELECT x
FROM a
EXCEPT
SELECT x
FROM b;
----------------------------------
INSERT INTO users (
    "firstName",
    "lastName",
    email,
    "isMale",
    birthday,
    "createdAt",
    height,
    weight
  )
VALUES (
    'New',
    'User',
    'new@new.t',
    true,
    '1991-1-1',
    current_timestamp,
    1.70,
    99
  );
---------------------------------- 
-- Разница между таблицей users и orders
SELECT id
FROM users
EXCEPT
SELECT "userId"
FROM orders;
----------------------------------
SELECT *
FROM users
WHERE id = 1001;
----------------------------------
-- Пользователи, которые не делали заказ
SELECT id
FROM users
EXCEPT
SELECT "userId"
FROM orders;
----------------------------------
SELECT orders.id
FROM orders
WHERE orders."userId" = 2;
----------------------------------
--Заказ №1
SELECT orders.id "order id",
  users.*
FROM orders
  JOIN users ON users.id = orders."userId"
WHERE orders.id = 1;
----------------------------------
-- Телефоны заказа №1
SELECT phones.brand,
  phones.model
FROM phones
  JOIN phones_to_orders ON phones.id = phones_to_orders."phoneId"
  JOIN orders ON phones_to_orders."orderId" = orders.id
WHERE orders.id = 1;
----------------------------------
-- id всех заказанных телефонов 'Siemens'
SELECT orders.id,
  p.model
FROM orders
  JOIN phones_to_orders AS pto ON orders.id = pto."orderId"
  JOIN phones AS p ON p.id = pto."phoneId"
WHERE p.brand = 'Siemens';
----------------------------------
INSERT INTO phones (
    brand,
    model,
    price,
    quantity,
    "createdAt"
  )
VALUES (
    'GOOGLE',
    'Pixel 99',
    30000,
    50,
    current_timestamp
  );
----------------------------------
-- Телефоны, которые покупали
SELECT phones.brand,
  phones.model
FROM phones_to_orders
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY "phoneId",
  phones.brand,
  phones.model;
----------------------------------
--Телефоны, которые не покупали
SELECT phones.brand,
  phones.model
FROM phones_to_orders
  RIGHT JOIN phones ON phones.id = phones_to_orders."phoneId"
WHERE phones_to_orders."phoneId" IS NULL;
----------------------------------
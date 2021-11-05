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
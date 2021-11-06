/*
 Переименовать users в customers;
 
 Созадайте таблицы
 users^
 login,
 password,
 email
 
 employees:
 salary,
 department,
 position,
 name,
 hire_date
 
 * 
 */
---------------------------------------------
-- Переименовать users в customers;
ALTER TABLE users
  RENAME to customers;
---------------------------------------------
CREATE TABLE users (
  id serial PRIMARY KEY,
  "login" varchar(32),
  "password" varchar(64),
  email varchar(128)
);
------------------------
CREATE TABLE employes(
  id serial PRIMARY KEY,
  salary numeric (10, 2) NOT NULL DEFAULT 1000 CHECK(salary > 0),
  department varchar(32),
  position varchar(64),
  "name" varchar(64),
  hire_date date DEFAULT current_date
);
DROP TABLE employes;
---------------------------------------------
/*
 добавить ограничение уникальности для емейла
 удалить пароль
 создать столбец password_hash и прокинуть ему ограничения,
 связать users и employees 
 */
---------------------------------------------
ALTER TABLE users
ADD CONSTRAINT unique_users_email UNIQUE(email);
--ALTER TABLE users
--ADD UNIQUE(email);
---------------------------------------------
ALTER TABLE users DROP COLUMN "password";
---------------------------------------------
ALTER TABLE users
ADD COLUMN password_hash varchar(64) NOT NULL CHECK(password_hash != '');
---------------------------------------------
ALTER TABLE employes
ADD COLUMN user_id int REFERENCES users NOT NULL;
---------------------------------------------
INSERT INTO users ("login", "password_hash", email)
values (
    'testa343',
    '12345asfaogn;dfdsasgdfasgsd',
    'tes123t@mail.com'
  ),
  (
    'user2',
    'asfgbflu342389sFdfgfdhdsfSFg23423d',
    'user@m32423ail.mail'
  ),
  (
    'bigBoss',
    'admin12345sagdhgdfgsdfd213',
    'bigBoss234235@company.net'
  );
---------------------------------------------
INSERT INTO employes (user_id, salary, department, position)
VALUES (1, 10000, 'IT', 'coder'),
  (3, 20000, 'Sales', 'Sales manages');
---------------------------------------------
-- ПОЛУЧИТЬ ВСЕХ ЮЗЕРОВ С ИХ ЗП
SELECT users.*,
  coalesce(employes.salary, 0)
FROM users
  LEFT JOIN employes ON users.id = employes.user_id;
-- users - левая таблица
-- employes - правая
---------------------------------------------
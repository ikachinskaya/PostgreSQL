CREATE TABLE tasks(
  id serial PRIMARY KEY,
  body text,
  is_done boolean,
  created_at timestamp
);
---------------------------------------------
DROP TABLE tasks;
---------------------------------------------
INSERT INTO tasks (body, is_done, created_at)
VALUES ('task1', false, current_timestamp);
---------------------------------------------
-- СОЗДАНИЕ СТОЛБЦА
ALTER TABLE tasks
ADD COLUMN dedline date NOT NULL DEFAULT current_date CHECK(dedline >= current_date);
---------------------------------------------
-- УДАЛЕНИЕ СТОЛБЦА
ALTER TABLE tasks DROP COLUMN created_at;
---------------------------------------------
-- ДОБАВЛЕНИЕ ОГРАНИЧЕНИЯ
ALTER TABLE tasks
ADD CHECK(body != '');
------------------------
-- ДОБАВЛЕНИЕ ОГРАНИЧЕНИЯ УНИКАЛЬНОСТИ
ALTER TABLE tasks
ADD CONSTRAINT unique_task_name UNIQUE(body);
------------------------
-- невозможно добавить, т.е. есть ограничение уникальности
INSERT INTO tasks (body, is_done)
VALUES ('task1', false);
------------------------
-- ДОБАВЛЕНИЕ ОГРАНИЧЕНИЯ NOT NULL
ALTER TABLE tasks
ALTER COLUMN is_done
SET NOT NULL;
---------------------------------------------
-- невозможно добавить, т.е. есть ограничение NOT NULL
INSERT INTO tasks (body)
VALUES ('task1');
---------------------------------------------
-- УДАЛЕНИЕ ОГРАНИЧЕНИЯ
ALTER TABLE tasks DROP CONSTRAINT unique_task_name;
---------------------------------------------
-- УДАЛЕНИЕ ОГРАНИЧЕНИЯ NOT NULL
ALTER TABLE tasks
ALTER COLUMN is_done DROP NOT NULL;
---------------------------------------------
-- УДАЛЕНИЕ ПЕРВИЧНОГО КЛЮЧА
ALTER TABLE tasks DROP CONSTRAINT tasks_pkey;
---------------------------------------------
-- ДОБАВЛЕНИЕ ПЕРВИЧНОГО КЛЮЧА
ALTER TABLE tasks
ADD PRIMARY KEY(id);
---------------------------------------------
-- ИЗМЕНЕНИЕ ЗНАЧЕНИЯ ПО УМОЛЧАНИЮ
ALTER TABLE tasks
ALTER COLUMN body
SET DEFAULT 'test task';
---------------------------------------------
INSERT INTO tasks (is_done)
VALUES (true);
---------------------------------------------
-- УДАЛЕНИЕ ЗНАЧЕНИЯ ПО УМОЛЧАНИЮ
ALTER TABLE tasks
ALTER COLUMN body DROP DEFAULT;
---------------------------------------------
-- ИЗМЕНЕНИЕ ТИПА ДАННЫХ СТОЛБЦА
ALTER TABLE tasks
ALTER COLUMN body TYPE varchar(512);
---------------------------------------------
-- ПЕРЕИМЕНОВАНИЕ СТОЛБЦА 
ALTER TABLE tasks
  RENAME COLUMN body to task_text;
---------------------------------------------
-- ПЕРЕИМЕНОВАНИЕ ТАБЛИЦЫ 
ALTER TABLE tasks
  RENAME to to_do;
---------------------------------------------
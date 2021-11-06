CREATE SCHEMA tasks_schema;
---------------------------------------------
CREATE TABLE tasks_schema.users(
  id serial PRIMARY KEY,
  "login" varchar(32),
  "password" varchar(64),
  email varchar(128)
);
DROP TABLE "users";
-------------------------------------------------------------
CREATE TABLE "users"(
  id serial PRIMARY KEY,
  first_name varchar(64) NOT NULL CHECK(first_name != ''),
  last_name varchar(64) NOT NULL CHECK(last_name != ''),
  email varchar(256) NOT NULL UNIQUE,
  birthday date NOT NULL CHECK(
    birthday > '1945-1-1'
    AND birthday < current_date
  ),
  height numeric (3, 2) CHECK (
    height > 0.2
    AND height < 3
  ),
  is_male boolean,
  CONSTRAINT "CHECK_EMAIL_NOT_EMPTY" CHECK (email != '')
);
-------------------------------------------------------------
INSERT INTO users (
    first_name,
    last_name,
    email,
    birthday,
    height,
    is_male
  )
VALUES ('mail@', 'Last ', 'First', true, 1.5, '1999/1/1');
-------------------------------------------------------------
INSERT INTO users
VALUES (
    'Test',
    '',
    'tes234t@mail.com',
    '31 December 1900',
    -2.5,
    true
  );
-------------------------------------------------------------
INSERT INTO users(
    first_name,
    last_name,
    email,
    birthday,
    height,
    is_male
  )
VALUES (
    'Test',
    'Testovich',
    'test1@test.com',
    '1990.10.10',
    1.5,
    true
  ),
  (
    'Test',
    'Testovich',
    'test2@test.com',
    '2005.10.10',
    1.5,
    true
  ),
  (
    'Test',
    'Testovich',
    'test3@test.com',
    '2010.10.10',
    2.5,
    false
  );
--============================================================
DROP TABLE a;
------------------
CREATE TABLE a(
  b integer,
  c integer,
  CONSTRAINT "NO_REPEAT" UNIQUE(b, c)
);
------------------
INSERT INTO a
VALUES (1, 1),
  (1, 1);
--============================================================
DROP TABLE messages;
-------------------------------------------------------------
CREATE TABLE messages(
  author varchar(64) NOT NULL CHECK(author != ''),
  body varchar(5000) NOT NULL CONSTRAINT "EMPTY_BODY" CHECK (body != ''),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp,
  is_read boolean NOT NULL DEFAULT false
);
-------------------------------------------------------------
INSERT INTO messages
VALUES ('user', '');
-------------------------------------------------------------
/*
 ЯЗЫКИ SQL
 DDL - Data Definition Language | CREATE, DROP , ALTER,
 DQL - Data Query Lang | SELECT
 DML - Data Manipulation Lang | INSERT, DELETE, UPDATE
 DCL - Data Control Lang | администрирование GRANT REVOKE
 TCL - Transaction Control Lang | COMMIT REVOKE
 */
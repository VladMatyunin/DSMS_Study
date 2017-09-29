DO
$body$
BEGIN
  IF NOT EXISTS (
      SELECT                       -- SELECT list can stay empty for this
      FROM   pg_catalog.pg_user
      WHERE  usename = 'my_user') THEN

    CREATE ROLE my_user LOGIN PASSWORD 'qwerty';
  END IF;
END
$body$;
CREATE SCHEMA TEST;
GRANT ALL PRIVILEGES ON SCHEMA TEST TO my_user;

SET SEARCH_PATH TO TEST;

CREATE TABLE SystemUser(
  Id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE SystemSection(
  Id SERIAL8 PRIMARY KEY,
  Description VARCHAR(500),
  Name VARCHAR(100) UNIQUE NOT NULL
);

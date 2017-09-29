SET SEARCH_PATH TO test;

INSERT INTO systemsection VALUES
  (1, 'this is test section1', 'section1'),
  (2, 'this is test section2', 'section2'),
  (3, 'this is test section3', 'section3');

INSERT INTO systemuser VALUES
  (1, 'this is test user1', 'user1', 'user1@email.ru'),
  (2, 'this is test user2', 'user2', 'user2@email.ru'),
  (3, 'this is test user3', 'user3', 'user3@email.ru');

INSERT INTO systemusersectionaccess VALUES
  (1, 'admin',1),
  (1, 'admin',2),
  (2, 'user', 3);
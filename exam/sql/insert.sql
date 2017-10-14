INSERT INTO company(name)
VALUES
('company1'),
('company2');

INSERT INTO sys_user(name, company_id)
VALUES
('user1',1);

INSERT INTO metrics(name, description)
VALUES
  ('dollar', 'this is dollar'),
  ('euro', 'this is euro');

INSERT INTO metric_constraints(max, min, date_constraint, metric_id, company_id)
VALUES 
  (50, 40, now(), 1, 1),
  (55, 40, now(), 1, 2),
  (50, 60, now(), 2, 1);

INSERT INTO current_metrics(metric_id, metric_value, date_metric, constraint_id)
VALUES 
  (1, 55, now(), 1),
  (1, 50, now(), 1),
  (2, 40, now(), 2),
  (2, 51, now(), 3);
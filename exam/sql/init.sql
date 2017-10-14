CREATE TABLE metrics(
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(1000)
);

CREATE TABLE company(
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE metric_constraints(
  id SERIAL PRIMARY KEY,
  max DECIMAL,
  min DECIMAL,
  date_constraint TIMESTAMP,
  metric_id INTEGER REFERENCES metrics(id),
  company_id INTEGER REFERENCES company(id)
);

CREATE TABLE sys_user(
  id SERIAL PRIMARY KEY,
  name VARCHAR(10) NOT NULL,
  company_id INTEGER REFERENCES company(id)
);

CREATE TABLE current_metrics(
  id SERIAL PRIMARY KEY,
  metric_id INTEGER REFERENCES metrics(id),
  metric_value DECIMAL NOT NULL,
  date_metric TIMESTAMP NOT NULL,
  constraint_id INTEGER REFERENCES metric_constraints(id)
);

CREATE TABLE audit(
  id SERIAL PRIMARY KEY,
  metric_id INTEGER REFERENCES metrics(id),
  updated_by_id INTEGER REFERENCES sys_user(id)
);

CREATE TABLE alerts (
  id SERIAL PRIMARY KEY,
  metric_id INTEGER REFERENCES metrics(id),
  constraint_id INTEGER REFERENCES metric_constraints(id),
  current_value DECIMAL NOT NULL,
  last_updated_by_id INTEGER REFERENCES sys_user(id)
);
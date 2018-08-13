DROP TABLE spendings;
DROP TABLE users;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  goal VARCHAR(255),
  spending_limit INT,
  income INT
);

CREATE TABLE spendings(
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE CASCADE,
  tag VARCHAR(255),
  merchant VARCHAR(255),
  price INT,
  product VARCHAR(255),
  purchase_date DATE
);

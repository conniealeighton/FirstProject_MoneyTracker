DROP TABLE spendings;
DROP TABLE merchants;
DROP TABLE tags;
DROP TABLE users;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  goal VARCHAR(255),
  spending_limit INT,
  income INT
);

CREATE TABLE merchants(
  id SERIAL PRIMARY KEY,
  name VARCHAR (255)
);

CREATE TABLE tags(
  id SERIAL PRIMARY KEY,
  name VARCHAR (255)
);

CREATE TABLE spendings(
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE CASCADE,
  tag_id INT REFERENCES tags(id) ON DELETE CASCADE,
  merchant_id INT REFERENCES merchants(id) ON DELETE CASCADE,
  price INT,
  product VARCHAR(255),
  purchase_date DATE
);

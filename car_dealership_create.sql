CREATE TABLE IF NOT EXISTS customer(
  customer_id SERIAL PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(150),
  address VARCHAR(150),
  phone_number INTEGER,
  billing_info VARCHAR(150),
  service_ticket INTEGER,
  invoice_item_with_badge_num_id INTEGER,
  FOREIGN KEY(service_ticket) REFERENCES service_facility(service_ticket),
  FOREIGN KEY(invoice_item_with_badge_num_id) REFERENCES salesperson(invoice_item_with_badge_num_id)
);

CREATE TABLE IF NOT EXISTS parts_inventory(
  available parts SERIAL PRIMARY KEY,
  quantity INTEGER
);

CREATE TABLE IF NOT EXISTS service_facility(
  service_ticket SERIAL PRIMARY KEY,
  customer_id INTEGER,
  sub_total NUMERIC(20,2),
  total_cost NUMERIC(25,2),
  available_parts VARCHAR(150),
  FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY(available_parts) REFERENCES parts_inventory(available parts)
);

CREATE TABLE IF NOT EXISTS salesperson(
  invoice_item_with_badge_num_id SERIAL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS new_cars(
  new_car_vin_number SERIAL PRIMARY KEY,
  make VARCHAR(20),
  invoice_item_with_badge_num_id INTEGER,
  new_car_product_id INTEGER,
  FOREIGN KEY(invoice_item_with_badge_num_id) REFERENCES salesperson(invoice_item_with_badge_num_id),
  FOREIGN KEY(new_car_product_id) REFERENCES new_cars_inventory(new_car_product_id)
);

CREATE TABLE IF NOT EXISTS new_cars_inventory(
  new_car_product_id SERIAL PRIMARY KEY,
  quantity INTEGER,
  color VARCHAR(15),
  year INTEGER,
  model VARCHAR(15),
  customer_id INTEGER,
  product_amount NUMERIC(20,2),
  FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE IF NOT EXISTS used_cars(
  used_car_vin_number SERIAL PRIMARY KEY,
  make VARCHAR(15),
  invoice_item_with_badge_num_id INTEGER,
  used_car_product_id INTEGER,
  FOREIGN KEY(used_car_product_id) REFERENCES used_cars_inventory(used_car_product_id),
  FOREIGN KEY(invoice_item_with_badge_num_id) REFERENCES salesperson(invoice_item_with_badge_num_id)
);

CREATE TABLE IF NOT EXISTS used_cars_inventory(
  used_car_product_id SERIAL PRIMARY KEY,
  quantity INTEGER,
  color VARCHAR(15),
  year Integer,
  model VARCHAR(15),
  customer_id Integer,
  product_amount NUMERIC(20,2),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

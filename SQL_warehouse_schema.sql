-- DATABASE

DROP DATABASE IF EXISTS cars_data_warehouse;
CREATE DATABASE cars_data_warehouse;
USE cars_data_warehouse;

-- DIMENSION TABLES
CREATE TABLE dim_model (
  model_id INT AUTO_INCREMENT PRIMARY KEY,
  mark VARCHAR(50),
  model VARCHAR(50),
  description TEXT
);

CREATE TABLE dim_date (
  date_id INT AUTO_INCREMENT PRIMARY KEY,
  year INT,
  decade INT,
  is_recent BOOLEAN
);

CREATE TABLE dim_gearbox (
  gearbox_id INT AUTO_INCREMENT PRIMARY KEY,
  gearbox_type VARCHAR(20)
);

CREATE TABLE dim_features (
  features_id INT AUTO_INCREMENT PRIMARY KEY,
  isofix BOOLEAN,
  led BOOLEAN,
  cruise_control BOOLEAN,
  bluetooth BOOLEAN,
  auto_clim BOOLEAN,
  rear_cam BOOLEAN,
  rear_rad BOOLEAN
);


-- FACT TABLE : 
CREATE TABLE fact_car_sales (
  sale_id INT AUTO_INCREMENT PRIMARY KEY,
  model_id INT,
  date_id INT,
  gearbox_id INT,
  features_id INT,
  km INT,
  price DECIMAL(10,2),
  FOREIGN KEY (model_id) REFERENCES dim_model(model_id),
  FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
  FOREIGN KEY (gearbox_id) REFERENCES dim_gearbox(gearbox_id),
  FOREIGN KEY (features_id) REFERENCES dim_features(features_id)
);

SET GLOBAL local_infile = 1;


LOAD DATA LOCAL INFILE 'C:\Users\Utilisateur\Desktop\data Warehouse\dimension_model.csv'
INTO TABLE dim_model
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'C:\Users\Utilisateur\Desktop\data Warehouse\dimension_date.csv'
INTO TABLE dim_date
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:\Users\Utilisateur\Desktop\data Warehouse\dimension_gearbox.csv'
INTO TABLE dim_gearbox
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'C:\Users\Utilisateur\Desktop\data Warehouse\dimension_features.csv'
INTO TABLE dim_features
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'C:\Users\Utilisateur\Desktop\data Warehouse\fact_car_sales.csv'
INTO TABLE fact_car_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(model_id, date_id, gearbox_id, features_id, km, price);

-- verifier que toutes les tables soient pas vides

SELECT COUNT(*) FROM dim_model;
SELECT COUNT(*) FROM dim_date;
SELECT COUNT(*) FROM dim_gearbox;
SELECT COUNT(*) FROM dim_features;
SELECT COUNT(*) FROM fact_car_sales;


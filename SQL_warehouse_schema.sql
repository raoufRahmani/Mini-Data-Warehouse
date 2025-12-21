CREATE DATABASE cars_data_warehouse;
USE cars_data_warehouse;
CREATE TABLE dim_model (
  model_id INT PRIMARY KEY,
  mark VARCHAR(50),
  model VARCHAR(50),
  description TEXT
);

CREATE TABLE dim_date (
  date_id INT PRIMARY KEY,
  year INT,
  decade INT,
  is_recent BOOLEAN
);

CREATE TABLE dim_gearbox (
  gearbox_id INT PRIMARY KEY,
  gearbox_type VARCHAR(20)
);

CREATE TABLE dim_features (
  features_id INT PRIMARY KEY,
  isofix BOOLEAN,
  led BOOLEAN,
  cruise_control BOOLEAN,
  bluetooth BOOLEAN,
  auto_clim BOOLEAN,
  rear_cam BOOLEAN,
  rear_rad BOOLEAN
);

CREATE TABLE fact_car_sales (
  model_id INT,
  date_id INT,
  gearbox_id INT,
  features_id INT,
  km INT,
  price FLOAT,
  FOREIGN KEY (model_id) REFERENCES dim_model(model_id),
  FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
  FOREIGN KEY (gearbox_id) REFERENCES dim_gearbox(gearbox_id),
  FOREIGN KEY (features_id) REFERENCES dim_features(features_id)
);

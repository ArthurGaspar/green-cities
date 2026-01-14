-- for creating directly with MySQL Workbench on an EXISTING CONNECTION:

-- (use any user or password you prefer)
-- CREATE USER 'cityzenith_user'@'localhost' IDENTIFIED BY 'cityzenith_pass_123';
-- GRANT ALL PRIVILEGES ON cityzenith.* TO 'cityzenith_user'@'localhost';
-- GRANT CREATE ON *.* TO 'cityzenith_user'@'localhost';
-- FLUSH PRIVILEGES;

-- then just paste the entire following schema.sql

CREATE DATABASE IF NOT EXISTS cityzenith;
USE cityzenith;

CREATE TABLE neighborhoods (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    geo_boundary TEXT, -- GeoJSON as text
    area_sq_km DECIMAL(10, 2),
    population_density DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE green_spaces (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,
    area_sq DECIMAL(10, 2) NOT NULL,
    neighborhood_id INT,
    coordinates TEXT, -- GeoJSON point
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhoods(id) ON DELETE SET NULL
);

CREATE TABLE green_spaces_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL
);

CREATE TABLE air_quality_readings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    neighborhood_id INT NOT NULL,
    pm2_5 DECIMAL(5, 2),
    pm10 DECIMAL(5, 2),
    aqi DECIMAL(5, 2), -- Air Quality Index
    timestamp DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhoods(id) ON DELETE CASCADE
);

CREATE TABLE property_values (
    id INT AUTO_INCREMENT PRIMARY KEY,
    neighborhood_id INT NOT NULL,
    avg_property_value DECIMAL(12, 2) NOT NULL,
    quarter TINYINT NOT NULL,
    year YEAR NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhoods(id) ON DELETE CASCADE
);

CREATE INDEX idx_neighborhood_id ON neighborhoods(id);
CREATE INDEX idx_neighborhood_density ON neighborhoods(area_sq_km, population_density);
CREATE INDEX idx_green_spaces_neighborhood ON green_spaces(neighborhood_id);
CREATE INDEX idx_air_quality_measures ON air_quality_readings(pm2_5, pm10, aqi);
CREATE INDEX idx_air_quality_neighborhood_time ON air_quality_readings(neighborhood_id, timestamp);
CREATE INDEX idx_property_values_neighborhood_year ON property_values(neighborhood_id, year, quarter);

-- sample data for São Paulo neighborhoods
INSERT INTO neighborhoods (name, area_sq_km, population_density, geo_boundary) VALUES
('Pinheiros', 12.5, 85.2, '{"type": "Polygon", "coordinates": [[[-46.705, -23.568], [-46.695, -23.568], [-46.695, -23.558], [-46.705, -23.558], [-46.705, -23.568]]]}'),
('Vila Madalena', 8.3, 92.1, '{"type": "Polygon", "coordinates": [[[-46.695, -23.558], [-46.685, -23.558], [-46.685, -23.548], [-46.695, -23.548], [-46.695, -23.558]]]}'),
('Jardins', 5.7, 45.8, '{"type": "Polygon", "coordinates": [[[-46.675, -23.568], [-46.665, -23.568], [-46.665, -23.558], [-46.675, -23.558], [-46.675, -23.568]]]}'),
('Moema', 9.2, 67.3, '{"type": "Polygon", "coordinates": [[[-46.665, -23.608], [-46.655, -23.608], [-46.655, -23.598], [-46.665, -23.598], [-46.665, -23.608]]]}');

-- sample green spaces
INSERT INTO green_spaces (name, type, area_sq, neighborhood_id, coordinates) VALUES
('Parque Villa-Lobos', 'park', 732000, 1, '{"type": "Point", "coordinates": [-46.724, -23.546]}'),
('Praça do Pôr do Sol', 'square', 8500, 1, '{"type": "Point", "coordinates": [-46.703, -23.552]}'),
('Parque da Água Branca', 'park', 137000, 2, '{"type": "Point", "coordinates": [-46.662, -23.532]}'),
('Jardim Europa', 'garden', 12500, 3, '{"type": "Point", "coordinates": [-46.678, -23.572]}'),
('Parque do Ibirapuera', 'park', 1580000, 4, '{"type": "Point", "coordinates": [-46.655, -23.587]}');

INSERT INTO green_spaces_types (type) VALUES
('park'),
('square'),
('garden'),
('forest')

-- sample air quality readings
INSERT INTO air_quality_readings (neighborhood_id, pm2_5, pm10, aqi, timestamp) VALUES
(1, 12.5, 25.3, 45.2, '2024-01-15 10:00:00'),
(1, 15.2, 28.7, 52.1, '2024-01-15 14:00:00'),
(2, 18.3, 32.1, 58.7, '2024-01-15 10:00:00'),
(2, 16.8, 30.5, 55.3, '2024-01-15 14:00:00'),
(3, 9.8, 20.1, 38.9, '2024-01-15 10:00:00'),
(3, 11.2, 22.7, 42.5, '2024-01-15 14:00:00'),
(4, 14.5, 27.8, 49.6, '2024-01-15 10:00:00'),
(4, 13.2, 25.9, 46.8, '2024-01-15 14:00:00');

-- sample property values
INSERT INTO property_values (neighborhood_id, avg_property_value, quarter, year) VALUES
(1, 850000.00, 1, 2024),
(1, 865000.00, 2, 2024),
(2, 920000.00, 1, 2024),
(2, 935000.00, 2, 2024),
(3, 1200000.00, 1, 2024),
(3, 1220000.00, 2, 2024),
(4, 950000.00, 1, 2024),
(4, 965000.00, 2, 2024);
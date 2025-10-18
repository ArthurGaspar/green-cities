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
    type ENUM('park', 'forest', 'garden', 'square') NOT NULL,
    area_sq DECIMAL(10, 2) NOT NULL,
    neighborhood_id INT,
    coordinates TEXT, -- GeoJSON point
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhoods(id) ON DELETE SET NULL
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

-- Indexes for performance
CREATE INDEX idx_air_quality_neighborhood_time ON air_quality_readings(neighborhood_id, timestamp);
CREATE INDEX idx_property_values_neighborhood_year ON property_values(neighborhood_id, year, quarter);
CREATE INDEX idx_green_spaces_neighborhood ON green_spaces(neighborhood_id);
-- Uncomment to create the database schema if needed
CREATE DATABASE mandatory; 
USE mandatory;

-- Drop the database if it exists (optional)
-- DROP DATABASE IF EXISTS mandatory;
-- Create a view where we can see where people are from citywise
CREATE view PassengerCity AS
SELECT city, zip_code FROM passenger
WHERE city = 'Copenhagen'
;
-- Create Passenger table
CREATE TABLE IF NOT EXISTS Passenger (
    Id VARCHAR(10) PRIMARY KEY,            -- Card number as primary key
    email_address VARCHAR(255) NOT NULL,   -- Email address
    first_name VARCHAR(100) NOT NULL,      -- First name
    last_name VARCHAR(100),                -- Last name (optional)
    street_name VARCHAR(255) NOT NULL,     -- Street name
    civic_number VARCHAR(11) NOT NULL,     -- CPR civic number (DDMMYY-XXXX)
    city VARCHAR(100) NOT NULL,            -- City
    zip_code VARCHAR(4) NOT NULL,          -- 4-digit zip code
    country VARCHAR(100) NOT NULL,         -- Country
    phone_number VARCHAR(15)               -- Phone number
);

-- Create Stop table
CREATE TABLE IF NOT EXISTS Stop (
    Id INT PRIMARY KEY AUTO_INCREMENT,     -- Stop ID
    name VARCHAR(255) NOT NULL,            -- Stop name
    longitude DOUBLE NOT NULL,             -- Longitude coordinate
    latitude DOUBLE NOT NULL               -- Latitude coordinate
);

-- Create Busline table
CREATE TABLE IF NOT EXISTS Busline (
    name_of_line VARCHAR(100) PRIMARY KEY, -- Busline name
    start_stop VARCHAR(255) NOT NULL,      -- Starting stop name
    end_stop VARCHAR(255) NOT NULL         -- Ending stop name
);

-- Create Journey table
CREATE TABLE IF NOT EXISTS Journey (
    Id INT PRIMARY KEY AUTO_INCREMENT,     -- Journey ID
    passenger_id VARCHAR(10) NOT NULL,     -- Foreign key to Passenger
    duration TIME NOT NULL,                -- Journey duration
    timestamp DATETIME NOT NULL,           -- Journey timestamp
    start_stop_id INT NOT NULL,            -- Foreign key to Stop (start stop)
    end_stop_id INT NOT NULL,              -- Foreign key to Stop (end stop)
    busline_id VARCHAR(100) NOT NULL,      -- Foreign key to Busline
    FOREIGN KEY (passenger_id) REFERENCES Passenger(Id),
    FOREIGN KEY (busline_id) REFERENCES Busline(name_of_line),
    FOREIGN KEY (start_stop_id) REFERENCES Stop(Id),
    FOREIGN KEY (end_stop_id) REFERENCES Stop(Id)
);

-- Create Order_of_Stop table
CREATE TABLE IF NOT EXISTS Order_of_Stop (
    stop_id INT NOT NULL,                  -- Foreign key to Stop
    busline_id VARCHAR(100) NOT NULL,      -- Foreign key to Busline
    stop_order INT NOT NULL,               -- Order of the stop
    PRIMARY KEY (stop_id, busline_id),
    FOREIGN KEY (stop_id) REFERENCES Stop(Id),
    FOREIGN KEY (busline_id) REFERENCES Busline(name_of_line)
);

-- Corrected Insert for Passenger table
INSERT INTO Passenger (
    Id,
    email_address,
    first_name,
    last_name,
    street_name,
    civic_number,
    city,
    zip_code,
    country,
    phone_number
)
VALUES (
    'CIT01',                          -- Unique identifier
    'johndoe@example.com',            -- Email address
    'John',                           -- First name
    'Doe',                            -- Last name
    'Main Street',                    -- Street name
    '150557-1234',                    -- Civic number in CPR format (DDMMYY-XXXX)
    'Sample City',                    -- City
    '1234',                           -- Zip code
    'Sample Country',                 -- Country
    '+1234567890'                     -- Phone number
);

INSERT INTO Passenger (
    Id, email_address, first_name, last_name, street_name, civic_number, city, zip_code, country, phone_number
)
VALUES 
    ('CIT53', 'JennyPeterson@example.com', 'Jenny', 'Peterson', 'Malmvej', '150557-1234', 'Copenhagen', '2100', 'Denmark', '+45123456789'),
    ('CIT87', 'janedoe@example.com', 'Jane', 'Doe', 'Vimmersgade', '201295-5678', 'Aarhus', '8000', 'Denmark', '+45234567890');
    
    INSERT INTO Stop (name, longitude, latitude)
VALUES 
    ('Central Station', 12.56553, 55.67594),
    ('City Square', 12.57377, 55.67610),
    ('Airport', 12.64012, 55.61809);

INSERT INTO Busline (name_of_line, start_stop, end_stop)
VALUES 
    ('Line1', 'Central Station', 'City Square'),
    ('Line2', 'City Square', 'Airport');

INSERT INTO Journey (passenger_id, duration, timestamp, start_stop_id, end_stop_id, busline_id)
VALUES 
    ('CIT01', '00:45:00', '2024-11-16 08:30:00', 1, 2, 'Line1'),
    ('CIT53', '01:10:00', '2024-11-16 09:00:00', 2, 3, 'Line2');

INSERT INTO Order_of_Stop (stop_id, busline_id, stop_order)
VALUES 
    (1, 'Line1', 1),
    (2, 'Line1', 2),
    (2, 'Line2', 1),
    (3, 'Line2', 2);

-- Display all passengers
SELECT * FROM Passenger;

-- Display all journeys
SELECT * FROM Journey;

-- Display all stops
SELECT * FROM Stop;

-- Display all buslines
SELECT * FROM Busline;

-- Display all orders of stop
SELECT * FROM Order_of_Stop;
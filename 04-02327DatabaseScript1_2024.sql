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

-- Breakpoint. Previous queries need to be executed first.

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

-- Populate the database - combined data for section 1 through 6.
-- Insert into Passenger table
INSERT INTO Passenger (
    Id, email_address, first_name, last_name, street_name, civic_number, city, zip_code, country, phone_number
)
VALUES 
    ('CIT01', 'johndoe@example.com', 'John', 'Doe', 'Main Street', '150557-1234', 'Sample City', '1234', 'Sample Country', '+1234567890'), -- Corrected Insert
    ('CIT53', 'JennyPeterson@example.com', 'Jenny', 'Peterson', 'Malmvej', '150557-1234', 'Copenhagen', '2100', 'Denmark', '+45123456789'),
    ('CIT87', 'janedoe@example.com', 'Jane', 'Doe', 'Vimmersgade', '201295-5678', 'Aarhus', '8000', 'Denmark', '+45234567890'),
    ('P001', 'alice@example.com', 'Alice', 'Smith', 'Main St', '010101-1234', 'Copenhagen', '1000', 'Denmark', '+4512345678'),
    ('P002', 'bob@example.com', 'Bob', 'Johnson', 'Oak St', '020202-5678', 'Aarhus', '8000', 'Denmark', '+4598765432'),
    ('P003', 'carol@example.com', 'Carol', 'Williams', 'Elm St', '030303-9101', 'Odense', '5000', 'Denmark', '+4587654321'),
    ('P004', 'dave@example.com', 'Dave', 'Brown', 'Maple St', '040404-3141', 'Copenhagen', '1000', 'Denmark', '+4576543210');

-- Insert into Stop table
INSERT INTO Stop (name, longitude, latitude)
VALUES 
    ('Central Station', 12.56553, 55.67594),
    ('City Square', 12.57377, 55.67610),
    ('Airport', 12.64012, 55.61809),
    ('Harbor', 12.59123, 55.68089),
    ('Park Avenue', 12.54889, 55.69000),
    ('Unused Stop', 12.60000, 55.60000);

-- Insert into Busline table
INSERT INTO Busline (name_of_line, start_stop, end_stop)
VALUES 
    ('Line1', 'Central Station', 'City Square'),
    ('Line2', 'City Square', 'Airport'),
    ('Line3', 'Harbor', 'Park Avenue');

-- Insert into Journey table
INSERT INTO Journey (passenger_id, duration, timestamp, start_stop_id, end_stop_id, busline_id)
VALUES 
    ('CIT01', '00:45:00', '2024-11-16 08:30:00', 1, 2, 'Line1'),
    ('CIT53', '01:10:00', '2024-11-16 09:00:00', 2, 3, 'Line2'),
    ('P001', '00:30:00', '2024-11-16 08:00:00', 1, 2, 'Line1'),
    ('P001', '00:45:00', '2024-11-16 10:00:00', 2, 3, 'Line2'),
    ('P002', '00:50:00', '2024-11-16 09:00:00', 3, 4, 'Line3'),
    ('P003', '00:20:00', '2024-11-16 08:15:00', 4, 5, 'Line3'),
    ('P004', '00:40:00', '2024-11-16 11:00:00', 1, 2, 'Line1'),
    ('P004', '00:25:00', '2024-11-16 13:00:00', 1, 2, 'Line1');

-- Insert into Order_of_Stop table
INSERT INTO Order_of_Stop (stop_id, busline_id, stop_order)
VALUES 
    (1, 'Line1', 1),
    (2, 'Line1', 2),
    (2, 'Line2', 1),
    (3, 'Line2', 2),
    (3, 'Line3', 1),
    (4, 'Line3', 2),
    (5, 'Line3', 3);

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

-- Create Passenger table if it does not exist

-- CREATE DATABASE mandatory; USE mandatory; 
-- uncomment above statement when you want to create the schema that is needed. :)
-- DROP DATABASE IF EXISTS mandatory;
-- uncomment above statement to delete schema. :)  
CREATE TABLE IF NOT EXISTS Passenger (
    Id VARCHAR(10) PRIMARY KEY,
    email_address VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    street_name VARCHAR(255) NOT NULL,
    civic_number VARCHAR(11) NOT NULL,
    city VARCHAR(100) NOT NULL,
    zip_code VARCHAR(4) NOT NULL,
    country VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15)
);

-- Create Journey table if it does not exist
CREATE TABLE IF NOT EXISTS Journey (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id VARCHAR(20) NOT NULL,
    duration TIME NOT NULL,
    timestamp DATETIME NOT NULL,
    busline_id VARCHAR(20) NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(Id),
    FOREIGN KEY (busline_id) REFERENCES Busline(name_of_line)
);

-- Create Stop table if it does not exist
CREATE TABLE IF NOT EXISTS Stop (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    longitude DOUBLE NOT NULL,
    latitude DOUBLE NOT NULL
);

-- Create Busline table if it does not exist
CREATE TABLE IF NOT EXISTS Busline (
    name_of_line VARCHAR(100) PRIMARY KEY,
    start_stop VARCHAR(255) NOT NULL,
    end_stop VARCHAR(255) NOT NULL
);

-- Create Order_of_Stop table if it does not exist
CREATE TABLE IF NOT EXISTS Order_of_Stop (
    stop_id INT NOT NULL,
    journey_id INT NOT NULL,
    stop_order INT NOT NULL,
    PRIMARY KEY (stop_id, journey_id),
    FOREIGN KEY (stop_id) REFERENCES Stop(Id),
    FOREIGN KEY (journey_id) REFERENCES Journey(Id)
);

INSERT INTO Passenger(Id, 
email_adress, 
first_name, 
last_name, 
street_name, 
civic_number, 
city, 
zip_code, 
country, 
phone_number)
Values( 'CIT01','first@email.com','First','Name','Initial','Street','010101-0101','Copenhagen','2100','Denmark','+451234567890');

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
    '1234',                          -- Zip code
    'Sample Country',                 -- Country
    '+1234567890'                     -- Phone number
);


-- Create Passenger table if it does not exist
CREATE TABLE IF NOT EXISTS Passenger (
    Id VARCHAR(20) PRIMARY KEY,
    email_address VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    street_name VARCHAR(255) NOT NULL,
    civic_number INT NOT NULL,
    city VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20)
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

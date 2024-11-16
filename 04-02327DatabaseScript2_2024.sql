UPDATE Passenger
SET 
    email_address = 'newemail@example.com',  -- New email address
    street_name = 'Updated Street',         -- New street name
    civic_number = '010101-4321',           -- New civic number
    city = 'Updated City',                  -- New city
    zip_code = '5678',                      -- New zip code
    country = 'Updated Country'             -- New country
WHERE 
    first_name = 'John' AND 
    last_name = 'Daisy';                      -- Targeting John Doe

DELETE FROM Passenger
WHERE Id = 'CIT01';

INSERT INTO Busline Values('Line 43','City Square','Central Station' );

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

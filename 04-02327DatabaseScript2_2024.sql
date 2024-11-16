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
    last_name = 'Doe';                      -- Targeting John Doe

SELECT * FROM Passenger;
SELECT * FROM Stop;
SELECT * FROM Journey;
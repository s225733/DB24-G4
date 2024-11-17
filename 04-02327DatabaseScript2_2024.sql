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

-- Queries for section 6
-- Query 1: Show the ID of the passengers who took a ride from the first stop of the line taken.
SELECT DISTINCT j.passenger_id
FROM Journey j
JOIN Order_of_Stop os ON j.start_stop_id = os.stop_id AND j.busline_id = os.busline_id
WHERE os.stop_order = 1;

-- Query 2: Show the name of the bus stop served by the most lines.
SELECT s.name, COUNT(DISTINCT os.busline_id) AS line_count
FROM Stop s
JOIN Order_of_Stop os ON s.Id = os.stop_id
GROUP BY s.Id, s.name
ORDER BY line_count DESC
LIMIT 1;

-- Query 3: For each line, show the ID of the passenger who took the ride that lasted the longest.
SELECT j.busline_id, j.passenger_id, MAX(j.duration) AS longest_duration
FROM Journey j
GROUP BY j.busline_id;

-- Query 4: Show the ID of the passengers who never took a bus line more than once per day.
SELECT p.Id
FROM Passenger p
WHERE NOT EXISTS (
    SELECT j1.passenger_id
    FROM Journey j1
    WHERE p.Id = j1.passenger_id
    GROUP BY j1.passenger_id, j1.busline_id, DATE(j1.timestamp)
    HAVING COUNT(*) > 1
);

-- Query 5: Show the name of the bus stops that are never used, that is, they are neither the start nor the end stop for any ride.
SELECT s.name
FROM Stop s
WHERE s.Id NOT IN (
    SELECT start_stop_id FROM Journey
    UNION
    SELECT end_stop_id FROM Journey
);




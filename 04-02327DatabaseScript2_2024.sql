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

-- Query 5: Updated Query. Check all stops instead of start and end stop for utilization. If a stop is not part of any busroute, it isn't utilized.
SELECT *
FROM Stop s
WHERE s.Id NOT IN (
    SELECT os.stop_id FROM Order_of_Stop os
);

DELIMITER //

CREATE FUNCTION LinesServingBothStops(stop1 INT, stop2 INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN (
        SELECT COUNT(DISTINCT os1.busline_id)
        FROM Order_of_Stop os1
        JOIN Order_of_Stop os2 ON os1.busline_id = os2.busline_id
        WHERE os1.stop_id = stop1 AND os2.stop_id = stop2
    );
END //

DELIMITER ;

SELECT LinesServingBothStops(1, 2) AS LinesCount;

DELIMITER //

CREATE PROCEDURE AddStopToLine(new_stop INT, line_name VARCHAR(100))
BEGIN
    -- Declare variables at the start of the procedure
    DECLARE max_order INT;

    -- Check if the stop is already served by the line
    IF NOT EXISTS (
        SELECT 1
        FROM Order_of_Stop
        WHERE stop_id = new_stop AND busline_id = line_name
    ) THEN
        -- Get the maximum stop order for the line
        SELECT MAX(stop_order) INTO max_order
        FROM Order_of_Stop
        WHERE busline_id = line_name;

        -- Add the new stop to the line with the next order number
        INSERT INTO Order_of_Stop (stop_id, busline_id, stop_order)
        VALUES (new_stop, line_name, COALESCE(max_order, 0) + 1);
    END IF;
END //

DELIMITER ;

CALL AddStopToLine(3, 'Line1');

DELIMITER //

CREATE TRIGGER PreventInvalidRide
BEFORE INSERT ON Journey
FOR EACH ROW
BEGIN
    -- Check if the ride starts and ends at the same stop
    IF NEW.start_stop_id = NEW.end_stop_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Start and end stops cannot be the same.';
    END IF;

    -- Check if the start stop is not served by the line
    IF NOT EXISTS (
        SELECT 1
        FROM Order_of_Stop
        WHERE stop_id = NEW.start_stop_id AND busline_id = NEW.busline_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Start stop is not served by the specified line.';
    END IF;

    -- Check if the end stop is not served by the line
    IF NOT EXISTS (
        SELECT 1
        FROM Order_of_Stop
        WHERE stop_id = NEW.end_stop_id AND busline_id = NEW.busline_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'End stop is not served by the specified line.';
    END IF;
END //

DELIMITER ;


INSERT INTO Journey (passenger_id, duration, timestamp, start_stop_id, end_stop_id, busline_id)
VALUES ('CIT01', '00:30:00', NOW(), 1, 1, 'Line1'); -- This will trigger an error.

INSERT INTO Journey (passenger_id, duration, timestamp, start_stop_id, end_stop_id, busline_id)
VALUES ('CIT01', '00:30:00', NOW(), 1, 3, 'Line1'); -- This will also trigger an error if stop 3 is not served by Line1.

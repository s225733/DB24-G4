-- We populate the database with necessary information to get the necessary results.
INSERT INTO Passenger (Id, email_address, first_name, last_name, street_name, civic_number, city, zip_code, country, phone_number)
VALUES 
    ('P001', 'alice@example.com', 'Alice', 'Smith', 'Main St', '010101-1234', 'Copenhagen', '1000', 'Denmark', '+4512345678'),
    ('P002', 'bob@example.com', 'Bob', 'Johnson', 'Oak St', '020202-5678', 'Aarhus', '8000', 'Denmark', '+4598765432'),
    ('P003', 'carol@example.com', 'Carol', 'Williams', 'Elm St', '030303-9101', 'Odense', '5000', 'Denmark', '+4587654321'),
    ('P004', 'dave@example.com', 'Dave', 'Brown', 'Maple St', '040404-3141', 'Copenhagen', '1000', 'Denmark', '+4576543210');

INSERT INTO Stop (name, longitude, latitude)
VALUES 
    ('Central Station', 12.56553, 55.67594),
    ('City Square', 12.57377, 55.67610),
    ('Airport', 12.64012, 55.61809),
    ('Harbor', 12.59123, 55.68089),
    ('Park Avenue', 12.54889, 55.69000);

INSERT INTO Busline (name_of_line, start_stop, end_stop)
VALUES 
    ('Line1', 'Central Station', 'City Square'),
    ('Line2', 'City Square', 'Airport'),
    ('Line3', 'Harbor', 'Park Avenue');

INSERT INTO Journey (passenger_id, duration, timestamp, start_stop_id, end_stop_id, busline_id)
VALUES 
    ('P001', '00:30:00', '2024-11-16 08:00:00', 1, 2, 'Line1'), -- Query 1, starts from first stop
    ('P001', '00:45:00', '2024-11-16 10:00:00', 2, 3, 'Line2'), -- Query 4, single ride per day
    ('P002', '00:50:00', '2024-11-16 09:00:00', 3, 4, 'Line3'), -- Query 3, longest for Line3
    ('P003', '00:20:00', '2024-11-16 08:15:00', 4, 5, 'Line3'),
    ('P004', '00:40:00', '2024-11-16 11:00:00', 1, 2, 'Line1'),
    ('P004', '00:25:00', '2024-11-16 13:00:00', 1, 2, 'Line1'); -- Query 4, duplicate on the same day

INSERT INTO Order_of_Stop (stop_id, busline_id, stop_order)
VALUES 
    (1, 'Line1', 1), -- Central Station (first stop for Line1)
    (2, 'Line1', 2), -- City Square
    (2, 'Line2', 1), -- City Square (first stop for Line2)
    (3, 'Line2', 2), -- Airport
    (3, 'Line3', 1), -- Harbor (first stop for Line3)
    (4, 'Line3', 2), -- Park Avenue
    (5, 'Line3', 3); -- Additional stop to ensure unused stops

INSERT INTO Stop (name, longitude, latitude)
VALUES 
    ('Unused Stop', 12.60000, 55.60000); -- Not referenced in Journey or Order_of_Stop

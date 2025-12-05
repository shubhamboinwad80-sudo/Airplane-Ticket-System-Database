

-- Disable Safe Updates globally for this script to allow updates/deletes
SET SQL_SAFE_UPDATES = 0;

-- 1. DATABASE SETUP
CREATE DATABASE AirlineReservationDB;
USE AirlineReservationDB;


/* =============================================================================
   PART 1: CA-II - ER DIAGRAM IMPLEMENTATION (CREATION)
=============================================================================
*/

-- 1.1 Create Independent Tables
CREATE TABLE Airline (
    AirlineID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    PhoneNo VARCHAR(15),
    Website VARCHAR(100),
    AirlineCode VARCHAR(10)
);

CREATE TABLE Airport (
    AirportID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Location VARCHAR(100),
    Country VARCHAR(50),
    Code VARCHAR(10)
);

CREATE TABLE Passenger (
    PassengerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(200),
    Passport VARCHAR(20),
    Contact VARCHAR(15)
);

CREATE TABLE BookingOffice (
    BookingOfficeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    OfficeNo VARCHAR(10),
    StreetNo VARCHAR(10),
    City VARCHAR(50)
);

CREATE TABLE TravelAgency (
    TravelAgencyID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Mobile VARCHAR(15),
    Website VARCHAR(100),
    City VARCHAR(50)
);

-- 1.2 Create Dependent Tables
CREATE TABLE Flight (
    FlightID INT PRIMARY KEY AUTO_INCREMENT,
    FlightNo VARCHAR(10) NOT NULL,
    AirlineID INT,
    FromAirportID INT,
    ToAirportID INT,
    FlightDate DATE,
    FlightTime TIME,
    Status VARCHAR(20),
    FOREIGN KEY (AirlineID) REFERENCES Airline (AirlineID),
    FOREIGN KEY (FromAirportID) REFERENCES Airport (AirportID),
    FOREIGN KEY (ToAirportID) REFERENCES Airport (AirportID)
);

CREATE TABLE Partner (
    PartnerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    TravelAgencyID INT,
    FOREIGN KEY (TravelAgencyID) REFERENCES TravelAgency (TravelAgencyID)
);

CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    PassengerID INT,
    FlightID INT,
    SeatNo VARCHAR(5),
    Class VARCHAR(20),
    Price DECIMAL(10,2),
    BookingDate DATE,
    BookingOfficeID INT,
    TravelAgencyID INT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger (PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flight (FlightID)
);

CREATE TABLE Crew (
    CrewID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Job VARCHAR(50),
    Contact VARCHAR(15),
    FlightID INT,
    FOREIGN KEY (FlightID) REFERENCES Flight (FlightID)
);

-- 1.3 Insert Data for Part 1
INSERT INTO Airline (Name, PhoneNo, Website, AirlineCode) VALUES
('Air India', '+91-1123456789', 'https://www.airindia.in', 'AI'),
('IndiGo', '+91-9876543210', 'https://www.goindigo.in', '6E'),
('SpiceJet', '+91-2234567890', 'https://www.spicejet.com', 'SG'),
('Vistara', '+91-3345678901', 'https://www.airvistara.com', 'UK'),
('Emirates', '+971-600555555', 'https://www.emirates.com', 'EK');

INSERT INTO Airport (Name, Location, Country, Code) VALUES
('Indira Gandhi International', 'Delhi', 'India', 'DEL'),
('Chhatrapati Shivaji International', 'Mumbai', 'India', 'BOM'),
('Kempegowda International', 'Bengaluru', 'India', 'BLR'),
('Dubai International', 'Dubai', 'UAE', 'DXB'),
('Heathrow Airport', 'London', 'UK', 'LHR');

INSERT INTO Flight (FlightNo, AirlineID, FromAirportID, ToAirportID, FlightDate, FlightTime, Status) VALUES
('AI101', 1, 1, 2, '2025-09-01', '10:30:00', 'On Time'),
('6E202', 2, 2, 3, '2025-09-02', '14:45:00', 'Delayed'),
('SG303', 3, 3, 1, '2025-09-03', '09:15:00', 'On Time'),
('UK404', 4, 1, 4, '2025-09-04', '22:00:00', 'Cancelled'),
('EK505', 5, 4, 2, '2025-09-05', '18:30:00', 'On Time');

INSERT INTO Passenger (Name, Email, Address, Passport, Contact) VALUES
('Rajesh Kumar', 'rajesh@example.com', 'Delhi, India', 'P1234567', '+91-9000011111'),
('Priya Singh', 'priya@example.com', 'Mumbai, India', 'P2345678', '+91-9000022222'),
('Amit Patel', 'amit@example.com', 'Ahmedabad, India', 'P3456789', '+91-9000033333'),
('Sara Khan', 'sara@example.com', 'Bengaluru, India', 'P4567890', '+91-9000044444'),
('John Doe', 'john@example.com', 'Dubai, UAE', 'P5678901', '+971-500001111');

INSERT INTO BookingOffice (Name, OfficeNo, StreetNo, City) VALUES
('Central Booking', '101', '12', 'Delhi'),
('Skyline Office', '202', '45', 'Mumbai'),
('FlightHub', '303', '78', 'Bengaluru'),
('TravelNest', '404', '56', 'Dubai'),
('AirConnect', '505', '90', 'London');

INSERT INTO TravelAgency (Name, Mobile, Website, City) VALUES
('GoTravel', '+91-8112233445', 'https://gotravel.com', 'Delhi'),
('SkyJet Travels', '+91-8223344556', 'https://skyjet.com', 'Mumbai'),
('FlightMasters', '+91-8334455667', 'https://flightmasters.com', 'Bengaluru'),
('Global Wings', '+971-544332211', 'https://globalwings.ae', 'Dubai'),
('HolidayPro', '+44-204555666', 'https://holidaypro.co.uk', 'London');

INSERT INTO Partner (Name, TravelAgencyID) VALUES
('Hotel Sunrise', 1),
('Luxury Stay', 2),
('Elite Lounge', 3),
('Desert Tours', 4),
('City Explorer', 5);

INSERT INTO Ticket (PassengerID, FlightID, SeatNo, Class, Price, BookingDate, BookingOfficeID, TravelAgencyID) VALUES
(1, 1, '12A', 'Economy', 5500.00, '2025-08-20', 1, 1),
(2, 2, '15B', 'Business', 8500.00, '2025-08-21', 2, 2),
(3, 3, '10C', 'Economy', 5000.00, '2025-08-22', 3, 3),
(4, 4, '5D', 'First', 12000.00, '2025-08-23', 4, 4),
(5, 5, '8E', 'Economy', 7000.00, '2025-08-24', 5, 5);

INSERT INTO Crew (Name, Job, Contact, FlightID) VALUES
('Captain Ramesh', 'Pilot', '+91-7000011111', 1),
('Anita Sharma', 'Co-Pilot', '+91-7000022222', 1),
('Vikas Nair', 'Cabin Crew', '+91-7000033333', 2),
('Nisha Gupta', 'Cabin Crew', '+91-7000044444', 3),
('James Wilson', 'Pilot', '+971-5000002222', 5);


/* =============================================================================
   PART 2: CA-03 - NORMALIZATION (2NF TO 3NF)
=============================================================================
*/

-- 2.1 Create Tables in 2NF
CREATE TABLE Passenger_2NF (
    PassengerID INT PRIMARY KEY AUTO_INCREMENT,
    PassengerName VARCHAR(100),
    Passport VARCHAR(20),
    Age INT,
    Sex CHAR(1),
    Email VARCHAR(100),
    Contact VARCHAR(20),
    Address VARCHAR(200)
);

CREATE TABLE Flight_2NF (
    FlightID INT PRIMARY KEY,
    FlightFrom VARCHAR(50),
    FlightTo VARCHAR(50),
    DepTime TIME,
    ArrTime TIME,
    AirlineName VARCHAR(100),
    AirlinePhone VARCHAR(20),
    AirlineWebsite VARCHAR(100)
);

CREATE TABLE Ticket_2NF (
    TicketID INT PRIMARY KEY,
    PassengerID INT,
    FlightID INT,
    TravelAgency VARCHAR(100),
    TicketType VARCHAR(40),
    SeatNo INT,
    Price FLOAT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger_2NF (PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flight_2NF (FlightID)
);

CREATE TABLE Crew_2NF (
    CrewID INT AUTO_INCREMENT PRIMARY KEY,
    FlightID INT,
    CrewRole VARCHAR(50),
    CrewName VARCHAR(100),
    FOREIGN KEY (FlightID) REFERENCES Flight_2NF(FlightID)
);

-- 2.2 Insert 2NF Data
INSERT INTO Passenger_2NF (PassengerName, Passport, Age, Sex, Email, Contact, Address) VALUES
('Arjun Mehta', 'P1001', 30, 'M', 'arjun@gmail.com', '9999990001', 'Delhi, India'),
('Riya Singh', 'P1002', 25, 'F', 'riya@gmail.com', '9999990002', 'Mumbai, India'),
('Karan Sharma', 'P1003', 40, 'M', 'karan@gmail.com', '9999990003', 'Bangalore, India'),
('Anita Desai', 'P1004', 35, 'F', 'anita@gmail.com', '9999990004', 'Delhi, India');

INSERT INTO Flight_2NF VALUES
(1001, 'Delhi', 'Dubai', '14:00:00', '16:30:00', 'Air India', '+91-22-2277-1100', 'www.airindia.in'),
(1002, 'Mumbai', 'London', '10:00:00', '20:15:00', 'IndiGo', '+91-22-2345-7890', 'www.goindigo.in'),
(1003, 'Bangalore', 'Singapore', '12:00:00', '19:00:00', 'SpiceJet', '+91-44-2244-9988', 'www.spicejet.com'),
(1004, 'Dubai', 'New York', '09:00:00', '22:00:00', 'Emirates', '+971-4-708-1111', 'www.emirates.com');

INSERT INTO Ticket_2NF VALUES
(401, 1, 1001, 'MakeMyTrip - Delhi Office', 'Economy', 12, 12000),
(402, 2, 1002, 'Yatra - Mumbai Office', 'Business', 2, 55000),
(403, 3, 1003, 'Cleartrip - Bangalore Office', 'Economy', 45, 15000),
(404, 4, 1004, 'Expedia - Dubai Office', 'Business', 5, 60000);

-- 2.3 Convert to 3NF (Data Preservation Method)

-- A. Handle Airlines
CREATE TABLE Airline_3NF (
    AirlineID INT PRIMARY KEY AUTO_INCREMENT,
    AirlineName VARCHAR(100),
    AirlinePhone VARCHAR(20),
    AirlineWebsite VARCHAR(100)
);

INSERT INTO Airline_3NF (AirlineName, AirlinePhone, AirlineWebsite) VALUES
('Air India', '+91-22-2277-1100', 'www.airindia.in'),
('IndiGo', '+91-22-2345-7890', 'www.goindigo.in'),
('SpiceJet', '+91-44-2244-9988', 'www.spicejet.com'),
('Emirates', '+971-4-708-1111', 'www.emirates.com');

-- Add ID column first
ALTER TABLE Flight_2NF ADD COLUMN AirlineID INT;

-- Update IDs based on Name match
UPDATE Flight_2NF f
JOIN Airline_3NF a ON f.AirlineName = a.AirlineName
SET f.AirlineID = a.AirlineID;

-- Drop old columns now that data is linked
ALTER TABLE Flight_2NF
DROP COLUMN AirlineName,
DROP COLUMN AirlinePhone,
DROP COLUMN AirlineWebsite,
ADD FOREIGN KEY (AirlineID) REFERENCES Airline_3NF(AirlineID);

-- B. Handle Travel Agencies
CREATE TABLE TravelAgency_3NF (
    AgencyID INT PRIMARY KEY AUTO_INCREMENT,
    AgencyName VARCHAR(100)
);

INSERT INTO TravelAgency_3NF (AgencyName) VALUES
('MakeMyTrip - Delhi Office'),
('Yatra - Mumbai Office'),
('Cleartrip - Bangalore Office'),
('Expedia - Dubai Office');

-- Add ID column first
ALTER TABLE Ticket_2NF ADD COLUMN AgencyID INT;

-- Update IDs based on Name match
UPDATE Ticket_2NF t
JOIN TravelAgency_3NF a ON t.TravelAgency = a.AgencyName
SET t.AgencyID = a.AgencyID;

-- Drop old columns now that data is linked
ALTER TABLE Ticket_2NF
DROP COLUMN TravelAgency,
ADD FOREIGN KEY (AgencyID) REFERENCES TravelAgency_3NF (AgencyID);


-- 2.4 Final Analysis Queries

-- Query 1: List all passengers going to London
SELECT p.PassengerName, f.FlightTo
FROM Ticket_2NF t
JOIN Passenger_2NF p ON t.PassengerID = p.PassengerID
JOIN Flight_2NF f ON t.FlightID = f.FlightID
WHERE f.FlightTo = 'London';

-- Query 2: List tickets ordered by Price
SELECT TicketID, Price
FROM Ticket_2NF
ORDER BY Price DESC;

-- Query 3: Find average ticket price per destination
SELECT f.FlightTo, AVG(t.Price) AS AvgPrice
FROM Ticket_2NF t
JOIN Flight_2NF f ON t.FlightID = f.FlightID
GROUP BY f.FlightTo;

-- Query 4: Count passengers per flight
SELECT f.FlightID, COUNT(t.TicketID) AS PassengerCount
FROM Ticket_2NF t
JOIN Flight_2NF f ON t.FlightID = f.FlightID
GROUP BY f.FlightID
HAVING COUNT(t.TicketID) > 1;

-- Query 5: Update ticket price for Business Class (Fixing Safe Update Error)
UPDATE Ticket_2NF
SET Price = Price * 1.1
WHERE TicketType = 'Business';

-- Re-enable Safe Updates (Best Practice)
SET SQL_SAFE_UPDATES = 1;
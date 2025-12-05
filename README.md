# Airplane-Ticket-System-Database

## Overview
This is a Database Management System (DBMS) project designed to manage the core operations of an airline. It utilizes a relational database to handle complex relationships between passengers, flights, bookings, and crew members.

## Key Features
* **Normalized Schema:** The database is designed in **3NF (Third Normal Form)** to eliminate data redundancy and ensure data integrity.
* **Complex Relationships:** Manages one-to-many and many-to-many relationships (e.g., one passenger can have multiple bookings; one flight has many crew members).
* **Optimized Queries:** Includes SQL scripts for common tasks like checking flight availability, updating booking status, and retrieving passenger history.

## Database Schema
The system consists of the following core entities:
* **Passengers:** Stores personal details and contact info.
* **Flights:** Manages routes, schedules, and aircraft types.
* **Bookings:** Links passengers to specific flights with status (Confirmed/Waitlisted).
* **Crew:** Assigns pilots and cabin crew to specific schedules.

## Tech Stack
* **Database:** MySQL / SQL
* **Concepts Used:** Primary Keys, Foreign Keys, Joins, Triggers.

## How to Use
1. Import the `.sql` file into your database management tool (e.g., MySQL Workbench).
2. Run the provided query scripts to test data insertion and retrieval.

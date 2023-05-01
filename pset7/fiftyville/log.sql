-- Keep a log of any SQL queries you execute as you solve the mystery.

-- What tables does it have.
.schema
.tables

-- Get more information about this table.
.schema crime_scene_reports

-- Find descriptions of the crime on a particular day and particular street.
SELECT description
FROM crime_scene_reports
WHERE month = 7
AND day = 28
AND street = 'Humphrey Street';

-- Get more information about this table.
.schema interviews

-- View the interview records of three witnesses
SELECT name, transcript
FROM interviews
WHERE year = 2021
AND month = 7
AND day = 28
AND transcript LIKE '%bakery%';

-- Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away.
-- If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.
-- Find all the people who got out of the parking lot.
SELECT name
FROM people
WHERE license_plate IN (
    SELECT license_plate
    FROM bakery_security_logs
    WHERE month = 7
    AND day = 28
    AND hour = 10
    AND minute > 15
    AND minute <= 25
    AND activity = 'exit'
)
ORDER BY name;
-- +---------+
-- |  name   |
-- +---------+
-- | Bruce   |
-- | Barry   |
-- | Diana   |
-- | Iman    |
-- | Kelsey  |
-- | Luca    |
-- | Sofia   |
-- | Vanessa |
-- +---------+

-- I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery,
-- I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.
-- Find the person who withdrew money on Leggett Street.
SELECT name
FROM people, bank_accounts
WHERE people.id = bank_accounts.person_id
AND account_number IN (
    SELECT account_number
    FROM atm_transactions
    WHERE month = 7
    AND day = 28
    AND atm_location = 'Leggett Street'
    AND transaction_type = 'withdraw'
)
ORDER BY name;
-- +---------+
-- |  name   |
-- +---------+
-- | Benista |
-- | Brooke  |
-- | Bruce   |
-- | Diana   |
-- | Iman    |
-- | Kenny   |
-- | Luca    |
-- | Taylor  |
-- +---------+

-- As the thief was leaving the bakery, they called someone who talked to them for less than a minute.
-- In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
-- The thief then asked the person on the other end of the phone to purchase the flight ticket.
-- The thief bought the earliest ticket for tomorrow
SELECT name
  FROM people
 WHERE passport_number IN (
    SELECT passport_number
    FROM passengers
    WHERE flight_id IN (
        SELECT id
        FROM flights
        WHERE month = 7
        AND day = 29
        AND origin_airport_id IN (
            SELECT id
            FROM airports
            WHERE city = 'Fiftyville'
        )
        ORDER BY hour ASC
        LIMIT 1
    )
)
 ORDER BY name;
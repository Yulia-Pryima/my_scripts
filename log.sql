-- The CS50 Duck has been stolen! The town of Fiftyville has called upon you to solve the mystery of the stolen duck.
-- Authorities believe that the thief stole the duck and then, shortly afterwards, took a flight out of town with the help of an accomplice.
-- Your goal is to identify:
-- Who the thief is,
-- What city the thief escaped to, and
-- Who the thief’s accomplice is who helped them escape
-- All you know is that the theft took place on July 28, 2020 and that it took place on Chamberlin Street.

-- The theft took place on July 28, 2020 and that it took place on Chamberlin Street.
SELECT description FROM crime_scene_reports WHERE month = 7 AND day = 28 AND street = 'Chamberlin Street';
-- Theft of the CS50 duck took place at 10:15am at the Chamberlin Street courthouse.
-- Interviews were conducted today with three witnesses who were present at the time — each of their interview transcripts mentions the courthouse.
SELECT name, transcript FROM interviews WHERE year = 2020 AND month = 7 AND day = 28 AND transcript LIKE '%courthouse%';
-- Ruth: Sometime within ten minutes of the theft, I saw the thief get into a car in the courthouse parking lot and drive away.
SELECT license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28
AND activity = 'entrance' AND hour < 11
AND license_plate IN
(SELECT license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28
AND activity = 'exit' AND hour BETWEEN 10 AND 11 AND minute BETWEEN 15 AND 25)
ORDER BY hour, minute;
--license_plate
L93JTIZ
94KL13X
322W7JE
0NTHK55
4328GD8
5P2BI95
6P58WS2
G412CB7
SELECT hour, minute,license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28
AND activity = 'exit' AND hour BETWEEN 10 AND 11 AND minute BETWEEN 15 AND 25
ORDER BY hour, minute;
-- hour | minute | license_plate
10 | 16 | 5P2BI95
10 | 18 | 94KL13X
10 | 18 | 6P58WS2
10 | 19 | 4328GD8
10 | 20 | G412CB7
10 | 21 | L93JTIZ
10 | 23 | 322W7JE
10 | 23 | 0NTHK55
-- Eugene: If you have security footage from the courthouse parking lot, you might want to look for cars that left the parking lot in that time frame.
SELECT name, phone_number, passport_number, license_plate
FROM people
WHERE license_plate IN
('5P2BI95','L93JTIZ', '94KL13X', '322W7JE', '0NTHK55', '4328GD8', '6P58WS2', 'G412CB7');
--name | phone_number | passport_number | license_plate
Patrick | (725) 555-4692 | 2963008352 | 5P2BI95
Amber | (301) 555-4174 | 7526138472 | 6P58WS2
Elizabeth | (829) 555-5269 | 7049073643 | L93JTIZ
Roger | (130) 555-0289 | 1695452385 | G412CB7
Danielle | (389) 555-5198 | 8496433585 | 4328GD8
Russell | (770) 555-1861 | 3592750733 | 322W7JE
Evelyn | (499) 555-9472 | 8294398571 | 0NTHK55
Ernest | (367) 555-5533 | 5773159633 | 94KL13X
-- Earlier this morning, before I arrived at the courthouse, I was walking by the ATM on Fifer Street and saw the thief there withdrawing some money.
SELECT account_number, amount
FROM atm_transactions
WHERE atm_location = 'Fifer Street' AND year = 2020 AND month = 7 AND day = 28 AND transaction_type ='withdraw';
--account_number | amount
28500762 | 48
28296815 | 20
76054385 | 60
49610011 | 50
16153065 | 80
25506511 | 20
81061156 | 30
26013199 | 35
SELECT atm_transactions.account_number, bank_accounts.account_number,
people.name, people.phone_number, people.passport_number, people.license_plate,
atm_transactions.transaction_type, atm_transactions.amount,
bank_accounts.creation_year
FROM bank_accounts
JOIN people ON bank_accounts.person_id = people.id
JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
WHERE atm_transactions.account_number = bank_accounts.account_number
AND atm_location = 'Fifer Street' AND year = 2020 AND month = 7 AND day = 28 AND transaction_type ='withdraw'
ORDER BY bank_accounts.account_number, atm_transactions.account_number;
--account_number | account_number | name | phone_number | passport_number | license_plate | transaction_type | amount | creation_year
16153065 | 16153065 | Roy | (122) 555-4581 | 4408372428 | QX4YZN3 | withdraw | 80 | 2012
25506511 | 25506511 | Elizabeth | (829) 555-5269 | 7049073643 | L93JTIZ | withdraw | 20 | 2014
26013199 | 26013199 | Russell | (770) 555-1861 | 3592750733 | 322W7JE | withdraw | 35 | 2012
28296815 | 28296815 | Bobby | (826) 555-1652 | 9878712108 | 30G67EN | withdraw | 20 | 2014
28500762 | 28500762 | Danielle | (389) 555-5198 | 8496433585 | 4328GD8 | withdraw | 48 | 2014
49610011 | 49610011 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X | withdraw | 50 | 2010
76054385 | 76054385 | Madison | (286) 555-6063 | 1988161715 | 1106N58 | withdraw | 60 | 2015
81061156 | 81061156 | Victoria | (338) 555-6650 | 9586786673 | 8X428L0 | withdraw | 30 | 2018
-- atm_transactions.account_number and bank_accounts.account_number are same
SELECT bank_accounts.account_number, people.phone_number,people.name, people.passport_number, people.license_plate,
atm_transactions.amount, bank_accounts.creation_year
FROM bank_accounts
JOIN people ON bank_accounts.person_id = people.id
JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
WHERE atm_transactions.account_number = bank_accounts.account_number
AND atm_location = 'Fifer Street' AND year = 2020 AND month = 7 AND day = 28 AND transaction_type ='withdraw'
ORDER BY bank_accounts.account_number;
-- account_number | phone_number | name | passport_number | license_plate | amount | creation_year
16153065 | (122) 555-4581 | Roy | 4408372428 | QX4YZN3 | 80 | 2012
25506511 | (829) 555-5269 | Elizabeth | 7049073643 | L93JTIZ | 20 | 2014
26013199 | (770) 555-1861 | Russell | 3592750733 | 322W7JE | 35 | 2012
28296815 | (826) 555-1652 | Bobby | 9878712108 | 30G67EN | 20 | 2014
28500762 | (389) 555-5198 | Danielle | 8496433585 | 4328GD8 | 48 | 2014
49610011 | (367) 555-5533 | Ernest | 5773159633 | 94KL13X | 50 | 2010
76054385 | (286) 555-6063 | Madison | 1988161715 | 1106N58 | 60 | 2015
81061156 | (338) 555-6650 | Victoria | 9586786673 | 8X428L0 | 30 | 2018
-- Raymond: As the thief was leaving the courthouse, they called someone who talked to them for less than a minute.
SELECT phone_calls.caller, phone_calls.receiver, phone_calls.duration, people.name, people.passport_number, people.license_plate
FROM phone_calls
JOIN people
ON people.phone_number = phone_calls.caller
WHERE duration < 60 AND caller IN
(SELECT phone_number
FROM people
WHERE license_plate IN
('5P2BI95','L93JTIZ', '94KL13X', '322W7JE', '0NTHK55', '4328GD8', '6P58WS2', 'G412CB7'))
GROUP BY caller;
-- caller | receiver | duration | name | passport_number | license_plate
(130) 555-0289 | (996) 555-8899 | 51 | Roger | 1695452385 | G412CB7
(367) 555-5533 | (375) 555-8161 | 45 | Ernest | 5773159633 | 94KL13X
(499) 555-9472 | (892) 555-8872 | 36 | Evelyn | 8294398571 | 0NTHK55
(770) 555-1861 | (725) 555-3243 | 49 | Russell | 3592750733 | 322W7JE
--
SELECT bank_accounts.account_number, people.phone_number,people.name, people.passport_number, people.license_plate,
atm_transactions.amount, bank_accounts.creation_year
FROM bank_accounts
JOIN people ON bank_accounts.person_id = people.id
JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
WHERE atm_transactions.account_number = bank_accounts.account_number
AND atm_location = 'Fifer Street' AND year = 2020 AND month = 7 AND day = 28 AND transaction_type ='withdraw'
AND people.phone_number IN
('(130) 555-0289', '(367) 555-5533', '(499) 555-9472', '(770) 555-1861')
ORDER BY bank_accounts.account_number;
-- Finding the thief by phone number:
--account_number | phone_number | name | passport_number | license_plate | amount | creation_year
26013199 | (770) 555-1861 | Russell | 3592750733 | 322W7JE | 35 | 2012
49610011 | (367) 555-5533 | Ernest | 5773159633 | 94KL13X | 50 | 2010
-- caller | receiver | duration | name | passport_number | license_plate
(367) 555-5533 | (375) 555-8161 | 45 | Ernest | 5773159633 | 94KL13X
(770) 555-1861 | (725) 555-3243 | 49 | Russell | 3592750733 | 322W7JE
-- Finding accomplice. Who suspected potencial thief was calling to?
SELECT phone_number, name, passport_number, license_plate
FROM people
WHERE phone_number IN ('(375) 555-8161', '(725) 555-3243');
--phone_number | name | passport_number | license_plate
(725) 555-3243 | Philip | 3391710505 | GW362R6
(375) 555-8161 | Berthold |  | 4V16VO0
-- Conclusion: THIEF/ACCOMPLICE are Ernest/Berthold OR Russell/Philip

-- Raymond: In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
-- Raymond: The thief then asked the person on the other end of the phone to purchase the flight ticket.
SELECT airports.full_name, flights.destination_airport_id, flights.day, flights.hour, flights.minute,
passengers.passport_number, passengers.seat, people.name, people.phone_number
FROM airports
JOIN flights ON flights.origin_airport_id = airports.id
JOIN passengers ON passengers.flight_id = flights.id
JOIN people ON passengers.passport_number = people.passport_number
WHERE flights.origin_airport_id IN
(SELECT id FROM airports WHERE airports.city = 'Fiftyville')
AND flights.year = 2020 AND flights.month = 7 AND flights.day = 29
AND passengers.passport_number IN
(5773159633, 3592750733)
ORDER BY flights.day, flights.hour, flights.minute;
-- Where thief Ernest ESCAPED TO?
SELECT abbreviation, full_name, city
FROM airports
WHERE id = 4;
-- abbreviation | full_name | city
LHR | Heathrow Airport | London
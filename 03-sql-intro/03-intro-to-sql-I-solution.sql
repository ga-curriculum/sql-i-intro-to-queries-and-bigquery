-- SQL I Introduction to Queries and BigQuery
-- Queries - Solutions to exercises from the 03-intro-to-sql-I.md file.


-- Part 1: Basic queries with `SELECT`, `FROM`, `LIMIT`, and `DISTINCT`

-- Exercise 1.1
-- 1. Select all columns from the `mascots` table.

SELECT *
FROM bigquery-public-data.ncaa_basketball.mascots;


-- 2. Select the first 20 team names and their market names from the `mbb_teams` table.

SELECT name, market
FROM bigquery-public-data.ncaa_basketball.mbb_teams;
LIMIT 20;

-- Stretch Challenge 1.1
-- Get the colors of all the teams (Hex codes). __hint__: you will need to identify the correct table to retrieve this data from.

SELECT color
FROM bigquery-public-data.ncaa_basketball.team_colors;


-- Exercise 1.2
-- 1. Find out how many unique seasons are in our dataset. You can use the `mbb_games_sr` table.

SELECT DISTINCT season
FROM bigquery-public-data.ncaa_basketball.mbb_games_sr;

-- 2. Get unique colors (hex codes) from the `team_colors` table.

SELECT DISTINCT color
FROM bigquery-public-data.ncaa_basketball.team_colors;


-- Stretch Challenge 1.2
-- 1. Find all unique combinations of conference names (conf_name) and venue names (venue_name) in the `mbb_teams` table.

SELECT DISTINCT conf_name, venue_name
FROM bigquery-public-data.ncaa_basketball.mbb_teams
ORDER BY conf_name;



-- Part 2: Ordering data with `ORDER BY`

--Exercise 2.1
-- 1. Find out which teams have the biggest arenas. Get the team name, city (`market`), and venue capacity. Then sort the results by venue capacity from largest to smallest.

SELECT name, market, venue_capacity
FROM bigquery-public-data.ncaa_basketball.mbb_teams
ORDER BY venue_capacity DESC;

--Stretch Challenge 2.1
-- 1. Select the team names and conference names from `mbb_teams`, ordered by conference name alphabetically, then by team name alphabetically within each conference. Limit the results to the top 50.

SELECT name, conf_name
FROM bigquery-public-data.ncaa_basketball.mbb_teams
ORDER BY conf_name ASC, name ASC
LIMIT 50;


-- Part 3: Aliasing tables and column names with `AS`

-- Exercise 3.1
-- 1. Rewrite your query from Exercise 2 using aliases for the table.

SELECT name AS team_name,
       market AS city, 
       venue_capacity AS seating_capacity
FROM bigquery-public-data.ncaa_basketball.mbb_teams
ORDER BY seating_capacity DESC;

-- Stretch Challenge 3.1
-- Create a query that finds unique combinations of:
-- 1. Conference name (alias: 'league')
-- 2. Division (alias: 'level')
-- 3. Market (alias: 'city')
-- 4. Order results first by conference name, then by division
-- 5. Limit to first 25 results

SELECT DISTINCT
    conf_name AS league,
    division_name AS level,
    market AS city
FROM bigquery-public-data.ncaa_basketball.mbb_teams
ORDER BY league, level
LIMIT 25;


-- Part 4: Aggregating Data with `COUNT()`, `SUM()`, and `AVG()`

-- Exercise 4.1
-- 1. How many teams are there in the `mbb_teams` table?

SELECT COUNT(name) AS total_teams
FROM bigquery-public-data.ncaa_basketball.mbb_teams;

-- 2. Calculate the following statistics in the `mbb_games_sr` table:
--   - Total number of games
--   - Average attendance
--   - Sum of all points scored by home teams

SELECT
    COUNT(*) AS total_games,
    AVG(attendance) AS avg_attendance,
    SUM(h_points) AS total_home_points,
FROM bigquery-public-data.ncaa_basketball.mbb_games_sr;


-- Stretch Challenge 4.1
-- Create one query that shows the following statistics:
-- - Number of teams
-- - Average venue capacity
-- - Total venue capacity
-- - Number of unique venues (some teams might share venues)
-- - Order the results by the number of teams in descending order.

SELECT
    COUNT(name) AS num_teams,
    AVG(venue_capacity) AS avg_venue_capacity,
    SUM(venue_capacity) AS total_venue_capacity,
    COUNT(DISTINCT venue_name) AS unique_venues
FROM bigquery-public-data.ncaa_basketball.mbb_teams
ORDER BY num_teams DESC;


-- Optional Further Exploration

-- Explore the other tables in the `ncaa_basketball` dataset and try to formulate your own queries based on what you've learned.
-- For example:

-- 1. Who has the highest single-game 'points' value recorded (across all seasons)?

SELECT abbr_name, points
FROM bigquery-public-data.ncaa_basketball.mbb_players_games_sr
ORDER BY points DESC
LIMIT 10;

-- 2. What is the total number of assists recorded in the dataset?

SELECT SUM(assists) AS total_assists
FROM bigquery-public-data.ncaa_basketball.mbb_players_games_sr;

-- 3. What is the average number of steals per game across all players and games?

SELECT AVG(steals) AS avg_steals
FROM bigquery-public-data.ncaa_basketball.mbb_players_games_sr;
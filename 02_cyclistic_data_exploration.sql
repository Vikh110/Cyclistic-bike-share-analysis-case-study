-- checking for number of null values in all columns
SELECT COUNT(*) - COUNT(ride_id) ride_id,
 COUNT(*) - COUNT(rideable_type) rideable_type,
 COUNT(*) - COUNT(started_at) started_at,
 COUNT(*) - COUNT(ended_at) ended_at,
 COUNT(*) - COUNT(start_station_name) start_station_name,
 COUNT(*) - COUNT(start_station_id) start_station_id,
 COUNT(*) - COUNT(end_station_name) end_station_name,
 COUNT(*) - COUNT(end_station_id) end_station_id,
 COUNT(*) - COUNT(start_lat) start_lat,
 COUNT(*) - COUNT(start_lng) start_lng,
 COUNT(*) - COUNT(end_lat) end_lat,
 COUNT(*) - COUNT(end_lng) end_lng,
 COUNT(*) - COUNT(member_casual) member_casual
FROM combined_table_cyclist;

-- checking for duplicate rows
SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM combined_table_cyclist;

-- ride_id - all have length of 16
SELECT LENGTH(ride_id) AS length_ride_id, COUNT(ride_id) AS no_of_rows
FROM combined_table_cyclist
GROUP BY length_ride_id;

-- rideable_type - 3 unique types of bikes
SELECT DISTINCT (rideable_type) AS types_of_rides, COUNT(rideable_type) AS no_of_trips_per_type
FROM combined_table_cyclist
GROUP BY rideable_type;

-- exceeds_or_equals_a_day  - total rows = 0
SELECT COUNT(*) AS exceeds_or_equals_a_day
FROM combined_table_cyclist
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) >= 1440;  



 -- less than or equals a minute - total rows = 151070
SELECT COUNT(*) AS less_than_or_equals_a_minute
FROM combined_table_cyclist
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) <= 1;     



-- start_station_name, start_station_id - total 875716 rows with both start station name and id missing

SELECT COUNT(ride_id) AS rows_with_start_station_null          -- return 875716 rows
FROM combined_table_cyclist
WHERE start_station_name IS NULL AND start_station_id IS NULL;

-- end_station_name, end_station_id - total 929202 rows with both end station name and id missing

SELECT COUNT(ride_id) AS rows_with_null_end_station          -- return 929202 rows
FROM combined_table_cyclist
WHERE end_station_name IS NULL AND end_station_id IS NULL;

-- end_lat, end_lng - total 6990 rows with both missing
SELECT COUNT(ride_id) AS rows_with_null_end_loc
FROM combined_table_cyclist
WHERE end_lat IS NULL AND end_lng IS NULL;


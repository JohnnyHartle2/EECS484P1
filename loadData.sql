INSERT INTO Users (user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender)
SELECT DISTINCT user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender FROM project1.PUBLIC_USER_INFORMATION;

INSERT INTO Friends (user1_id, user2_id)
SELECT user1_id, user2_id FROM project1.PUBLIC_ARE_FRIENDS;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT current_city, current_state, current_country FROM project1.PUBLIC_USER_INFORMATION
UNION
SELECT hometown_city, hometown_state, hometown_country FROM project1.PUBLIC_USER_INFORMATION;

INSERT INTO User_Hometown_Cities (user_id, hometown_city_id)
SELECT DISTINCT u.user_id, c.city_id
FROM Cities c
JOIN project1.PUBLIC_USER_INFORMATION u
ON u.hometown_city = c.city_name
AND u.hometown_state = c.state_name
AND u.hometown_country = c.country_name;

INSERT INTO User_Current_Cities (user_id, current_city_id)
SELECT DISTINCT u.user_id, c.city_id
FROM project1.PUBLIC_USER_INFORMATION u
JOIN Cities c
ON u.current_city = c.city_name
AND u.current_state= c.state_name
AND u.current_country = c.country_name;

INSERT INTO Programs(institution, concentration, degree)
SELECT institution_name, program_concentration, program_degree 
FROM project1.PUBLIC_USER_INFORMATION
WHERE institution_name IS NOT NULL 
AND program_concentration IS NOT NULL 
AND program_degree IS NOT NULL;

INSERT INTO Education(user_id, program_id, program_year)
SELECT DISTINCT u.user_id, p.program_id, u.program_year
FROM project1.PUBLIC_USER_INFORMATION u
JOIN Programs p
ON p.concentration = u.program_concentration
AND p.degree = u.program_degree
AND p.institution = u.institution_name;

INSERT INTO User_Events(event_id, event_creator_id, event_name, event_tagline,
event_description, event_host, event_type, event_subtype, event_address, event_start_time, event_end_time, event_city_id)
SELECT p.event_id, p.event_creator_id, p.event_name, p.event_tagline, p.event_description, p.event_host,
p.event_type, p.event_subtype, p.event_address, p.event_start_time, p.event_end_time, c.city_id
FROM project1.Public_Event_Information p
JOIN Cities c
ON p.event_city = c.city_name
AND p.event_state = c.state_name
AND p.event_country	= c.country_name;

INSERT INTO Albums(album_id, album_owner_id, album_name, album_created_time,
album_modified_time, album_link, album_visibility)
SELECT p.album_id, u.user_id, p.album_name, p.album_created_time, p.album_modified_time, p.album_link,
p.album_visibility
FROM project1.Public_Photo_Information p 
JOIN Users u 
ON u.user_id = p.owner_id;
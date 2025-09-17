CREATE OR REPLACE VIEW VIEW_PHOTO_INFORMATION AS
SELECT
  a.album_id AS album_id,
  a.album_owner_id AS owner_id,
  a.cover_photo_id AS cover_photo_id,
  a.album_name AS album_name,
  a.album_created_time AS album_created_time,
  a.album_modified_time AS album_modified_time,
  a.album_link AS album_link,
  a.album_visibility AS album_visibility,
  p.photo_id AS photo_id,
  p.photo_caption AS photo_caption,
  p.photo_created_time AS photo_created_time,
  p.photo_modified_time AS photo_modified_time,
  p.photo_link AS photo_link
FROM Albums a
JOIN Photos p
ON p.album_id = a.album_id;


CREATE OR REPLACE VIEW VIEW_TAG_INFORMATION AS
SELECT
  t.tag_photo_id AS photo_id,
  t.tag_subject_id AS tag_subject_id,
  t.tag_created_time AS tag_created_time,
  t.tag_x AS tag_x_coordinate,
  t.tag_y AS tag_y_coordinate
FROM Tags t;


CREATE OR REPLACE VIEW VIEW_USER_INFORMATION AS
SELECT
    u.user_id AS user_id,
    u.first_name AS first_name,
    u.last_name AS last_name,
    u.year_of_birth AS year_of_birth,
    u.month_of_birth AS month_of_birth,
    u.day_of_birth AS day_of_birth,
    u.gender AS gender,
    cc.city_name AS current_city,
    cc.state_name AS current_state,
    cc.country_name AS current_country,
    hc.city_name AS hometown_city,
    hc.state_name AS hometown_state,
    hc.country_name AS hometown_country,
    p.institution AS institution_name,
    e.program_year AS program_year,
    p.concentration AS program_concentration,
    p.degree AS program_degree
FROM Users u
LEFT JOIN User_Current_Cities ucc
       ON u.user_id = ucc.user_id
LEFT JOIN Cities cc
       ON ucc.current_city_id = cc.city_id
LEFT JOIN User_Hometown_Cities uhc
       ON u.user_id = uhc.user_id
LEFT JOIN Cities hc
       ON uhc.hometown_city_id = hc.city_id
LEFT JOIN Education e
       ON u.user_id = e.user_id
LEFT JOIN Programs p
       ON e.program_id = p.program_id;


CREATE OR REPLACE VIEW VIEW_EVENT_INFORMATION AS
SELECT
    e.event_id AS event_id,
    e.event_creator_id AS event_creator_id,
    e.event_name AS event_name,
    e.event_tagline AS event_tagline,
    e.event_description AS event_description,
    e.event_host AS event_host,
    e.event_type AS event_type,
    e.event_subtype AS event_subtype,
    e.event_address AS event_address,
    c.city_name AS event_city,
    c.state_name AS event_state,
    c.country_name AS event_country,
    e.event_start_time AS event_start_time,
    e.event_end_time AS event_end_time
FROM User_Events e
LEFT JOIN Cities c
       ON e.event_city_id = c.city_id;


CREATE OR REPLACE VIEW VIEW_ARE_FRIENDS AS
SELECT
    f.user1_id AS user1_id,
    f.user2_id AS user2_id
FROM Friends f;

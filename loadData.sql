CREATE TRIGGER Order_Friend_Pairs
    BEFORE INSERT ON Friends
    FOR EACH ROW
        DECLARE temp INTEGER;
        BEGIN
            IF :NEW.user1_id > :NEW.user2_id THEN
                temp := :NEW.user2_id;
                :NEW.user2_id := :NEW.user1_id;
                :NEW.user1_id := temp;
            END IF;
        END;
/

CREATE SEQUENCE New_City_ID
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER Insert_City
    BEFORE INSERT ON Cities
    FOR EACH ROW
        BEGIN
            SELECT New_City_ID.NEXTVAL INTO :NEW.city_id FROM DUAL;
        END;
/

CREATE SEQUENCE New_Program_ID
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER Insert_Program
    BEFORE INSERT ON Programs
    FOR EACH ROW
        BEGIN
            SELECT New_Program_ID.NEXTVAL INTO :NEW.program_id FROM DUAL;
        END;
/

INSERT INTO Users (user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender)
SELECT user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender FROM project1.PUBLIC_USER_INFORMATION;

INSERT INTO Friends (user1_id, user2_id)
SELECT user1_id, user2_id FROM project1.PUBLIC_ARE_FRIENDS;

INSERT INTO Cities (city_id, city_name, state_name, country_name)
SELECT (current_city, current_state, current_country) FROM project1.PUBLIC_USER_INFORMATION
UNION
SELECT (hometown_city, hometown_state, hometown_country) FROM project1.PUBLIC_USER_INFORMATION

INSERT INTO User_Hometown_Cities (city_id, user_id)
SELECT Cities.city_id, project1.PUBLIC_USER_INFORMATION.user_id
FROM Cities
ON project1.PUBLIC_USER_INFORMATION.hometown_city = Cities.city_name
AND project1.PUBLIC_USER_INFORMATION.hometown_state= Cities.state_name
AND project1.PUBLIC_USER_INFORMATION.hometown_country = Cities.country_name

INSERT INTO User_Current_Cities (current_city_id, user_id)
SELECT Cities.city_id, project1.PUBLIC_USER_INFORMATION.user_id
FROM project1.PUBLIC_USER_INFORMATION
JOIN Cities
ON project1.PUBLIC_USER_INFORMATION.current_city = Cities.city_name
AND project1.PUBLIC_USER_INFORMATION.current_state= Cities.state_name
AND project1.PUBLIC_USER_INFORMATION.current_country = Cities.country_name

INSERT INTO Programs(program_id, institution, concentration, degree)
SELECT (program_year, program_concentration, program_degree) FROM project1.PUBLIC_USER_INFORMATION

INSERT INTO Education(user_id, program_id, program_year)
SELECT project1.PUBLIC_USER_INFORMATION.user_id, Program.program_id, project1.PUBLIC_USER_INFORMATION.program_year
FROM project1.PUBLIC_USER_INFORMATION
JOIN Programs
ON Programs.program_concentration = project1.PUBLIC_USER_INFORMATION.program_concentration
AND Programs.program_degree = project1.PUBLIC_USER_INFORMATION.program_degree
AND Programs.institution = project1.PUBLIC_USER_INFORMATION.institution_name

USE tmc;


CREATE TABLE users (
    user_name CHAR(64) NOT NULL,
    user_pass CHAR(255) NOT NULL,
    PRIMARY KEY (user_name));  


CREATE TABLE user_roles (
    user_name CHAR(64) NOT NULL,
    role_name CHAR(64) NOT NULL,
    PRIMARY KEY (user_name, role_name));

-- vi: se ts=4 sw=4 et:

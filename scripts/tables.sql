
USE tmc;


CREATE TABLE users (
    name CHAR(64) NOT NULL,
    pass CHAR(255) NOT NULL,
    PRIMARY KEY (name));  


CREATE TABLE user_roles (
    user_name CHAR(64) NOT NULL,
    role_name CHAR(64) NOT NULL,
    PRIMARY KEY (user_name, role_name));

-- vi: se ts=4 sw=4 et:
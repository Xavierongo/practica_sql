-- Creamos las 5 tablas siguiendo las especificaciones del diagrama. 


CREATE TABLE keepcoding.students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    country VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    age INT,
    gender VARCHAR(10),
    education_level VARCHAR(50));


CREATE TABLE keepcoding.bootcamps (
    bootcamp_id SERIAL PRIMARY KEY,
    bootcamp_name VARCHAR(100),
    edition VARCHAR(50),
    edition_year INT,
    start_date DATE,
    end_date DATE,
    price DECIMAL(10, 2));


CREATE TABLE keepcoding.professors (
    profesor_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE);


CREATE TABLE keepcoding.modules (
    module_id SERIAL PRIMARY KEY,
    bootcamp_id INT REFERENCES bootcamps(bootcamp_id),
    module_name VARCHAR(100),
    duration_in_hours INT);


CREATE TABLE keepcoding.students_bootcamps (
    alumno_id INT REFERENCES alumnos(alumno_id),
    bootcamp_id INT REFERENCES bootcamps(bootcamp_id),
    enrollment_date DATE,
    status VARCHAR(20),
    PRIMARY KEY (alumno_id, bootcamp_id));


CREATE TABLE keepcoding.modules_professors (
    profesor_id INT REFERENCES profesores(profesor_id),
    modulo_id INT REFERENCES modulos(modulo_id),
    start_date DATE,
    end_date DATE,
    completed_hours INT,
    PRIMARY KEY (profesor_id, modulo_id));
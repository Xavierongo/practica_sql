
--TABLA alumnos
-- Alteraciones en la tabla alumnos
ALTER TABLE keepcoding.students 
    ALTER COLUMN name SET NOT NULL;

ALTER TABLE keepcoding.students 
    ALTER COLUMN surname SET NOT NULL;

ALTER TABLE keepcoding.students 
    ALTER COLUMN email SET NOT NULL;

-- Agregar restricciones a la tabla alumnos
ALTER TABLE keepcoding.students 
    ADD CONSTRAINT chk_email_format CHECK (email LIKE '%_@_%._%');

ALTER TABLE keepcoding.students 
    ADD CONSTRAINT chk_age_range CHECK (age >= 18 AND age <= 100);


--TABLA bootcamps

-- Alteraciones en la tabla bootcamps
ALTER TABLE keepcoding.bootcamps 
    ALTER COLUMN bootcamp_name SET NOT NULL;

ALTER TABLE keepcoding.bootcamps 
    ALTER COLUMN start_date SET NOT NULL;

ALTER TABLE keepcoding.bootcamps 
    ALTER COLUMN end_date SET NOT NULL;

-- Agregar restricciones a la tabla bootcamps
ALTER TABLE keepcoding.bootcamps 
    ADD CONSTRAINT chk_end_after_start CHECK (end_date > start_date);

ALTER TABLE keepcoding.bootcamps 
    ADD CONSTRAINT chk_price_non_negative CHECK (price >= 0);




--TABLA profesores
ALTER TABLE keepcoding.professors 
    ALTER COLUMN name SET NOT NULL;

ALTER TABLE keepcoding.professors 
    ALTER COLUMN email SET NOT NULL;

ALTER TABLE keepcoding.professors 
    ADD CONSTRAINT chk_email_format_profesor CHECK (email LIKE '%_@_%._%');




-- TABLA modulos
ALTER TABLE keepcoding.modules 
    ALTER COLUMN module_name SET NOT NULL;

ALTER TABLE keepcoding.modules 
    ADD CONSTRAINT chk_duration_positive CHECK (duration_in_hours > 0);


--TABLA INTERMEDIA alumnos_bootcamps
ALTER TABLE keepcoding.students_bootcamps
    ADD CONSTRAINT chk_grade
    CHECK (status IN ('PASSED', 'ABANDONED', 'SUSPENDED', 'IN COURSE'));


--TABLA INTERMEDIA  profesores_modulos
ALTER TABLE keepcoding.modules_professors 
    ALTER COLUMN start_date SET NOT NULL;

ALTER TABLE keepcoding.modules_professors 
    ALTER COLUMN end_date SET NOT NULL;

ALTER TABLE keepcoding.modules_professors 
    ADD CONSTRAINT chk_end_after_start_prof_mod CHECK (end_date > start_date);







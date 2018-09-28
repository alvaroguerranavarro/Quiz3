-- Quiz 3
-- PARTE 1
--1.Create a tablespace with name 'quiz_manana' and three datafiles. Each datafile of 30Mb.
CREATE TABLESPACE quiz_manana DATAFILE
'datafile1.dbf' SIZE 30M,
'datafile2.dbf' SIZE 30M,
'datafile3.dbf' SIZE 30M;

--2.Create a profile with idle time of 15 minutes, the name of the profile should be 'estudiante_quiz'
CREATE PROFILE estudiante_quiz limit
idle_time 15;

--3. Create an user named "carlos_2" with password "carlos_2". 
	-- The user should be able to connect
	-- The user should has the profile "estudiante_quiz"
	-- The user should be associated to the tablespace "quiz_manana"
	-- The user should be able to create tables WITHOUT USING THE DBA ROLE. 
CREATE USER carlos_2
IDENTIFIED BY carlos_2
DEFAULT TABLESPACE quiz_manana
PROFILE estudiante_quiz
QUOTA UNLIMITED ON quiz_manana;

GRANT CONNECT TO carlos_2
GRANT CREATE SESSION TO carlos_2;
GRANT CREATE TABLE TO carlos_2;

--4. Create an user named "user2" with password "user2"
	-- The user should be able to connect
	-- The user should has the profile "estudiante_quiz"
	-- The user should be associated to the tablespace "quiz_manana"
-- The user shouldn't be able to create tables.

CREATE USER user2
IDENTIFIED BY user2
DEFAULT TABLESPACE quiz_manana
PROFILE estudiante_quiz
QUOTA UNLIMITED ON quiz_manana;

GRANT CONNECT TO user2
GRANT CREATE SESSION TO user2;

-- PARTE 2

create table icfes (
tipo_documento 	varchar2(255),
nacionalidad		varchar2(255),
genero					varchar2(255),
fecha_nacimiento	date,
periodo					varchar2(255),
consecutivo			varchar2(255),
departamento_residencia	varchar2(255),
codigo_departamento_residencia	integer,
municipio_residencia		varchar2(255),
codigo_municipio_residencia	varchar2(255),
estrato					varchar2(255),
educacion_padre	varchar2(255),
educacion_madre	varchar2(255),
tiene_internet	varchar2(255),
tiene_tv				varchar2(255),
tiene_lavadora	varchar2(255),
tiene_horno_micro_o_gas	varchar2(255),
tiene_automovil	varchar2(255),
tiene_motocicleta	varchar2(255),
tiene_consola_videojuegos	varchar2(255),
colegio_codigo_icfes	varchar2(255),
colegio_codigo_dane		varchar2(255),
colegio_nombre				varchar2(255),
puntaje_lectura_critica	integer,
puntaje_matematicas		integer,
puntaje_ciencias_naturales	integer,
puntaje_sociales			integer,
puntaje_ingles				integer,
desempeno_ingles			varchar2(255),
puntaje_global				integer
);

-- 3. Give permission to view table "icfes" of the user2 (Do selects)

GRANT SELECT ON icfes TO  user2;

-- PARTE 3

--1. SHOW THE GENRE, DATE OF BIRTH, SEQUENCE (CONSECUTIVO), MUNICIPIO, GLOBAL SCORE (PUNTAJE GLOBAL) OF THE OLDEST STUDENT
SELECT genero,fecha_nacimiento,consecutivo,municipio_residencia,puntaje_global
FROM icfes
WHERE fecha_nacimiento=(SELECT MAX(fecha_nacimiento) FROM icfes WHERE puntaje_global = (SELECT MAX(puntaje_global) FROM icfes));

--2. SHOW THE GENRE, DATE OF BIRTH, SEQUENCE (CONSECUTIVO), MUNICIPIO, GLOBAL SCORE (PUNTAJE GLOBAL) OF THE STUDENTS WHICH HAVE A B1 IN DESEMPEÑO OF ENGLISH
SELECT genero,fecha_nacimiento,consecutivo,municipio_residencia,puntaje_global
FROM icfes
WHERE desempeno_ingles = 'B1';

-- 3 COUNT THE NUMBER COLEGIO_NOMBRE WITHOUT REPETITION (UNIQUE VALUES) OF THE STUDENTS
SELECT COUNT(DISTINCT(colegio_nombre))
FROM icfes;

--4  COUNT THE NUMBER OF STUDENTS WHICH ARE LOCATED IN PASTO
SELECT COUNT(tipo_documento)
FROM icfes
WHERE municipio_residencia='PASTO';

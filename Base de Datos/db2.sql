CREATE TABLE administrador
(id_admin number not null
nombre varchar2(20) NOT NULL,
nombreusu varchar2(25) NOT NULL,
apellido varchar2(20) NOT NULL,
pass varchar(20),
id_rol
);

CREATE TABLE (

);
CREATE TABLE jugador


CREATE TABLE persona (
codPersona number NOT NULL,
dni varchar2(9) NOT NULL,
nombre varchar2(20) NOT NULL,
telefono number NOT NULL,
mail VARCHAR2(150) NOT NULL,
localidad VARCHAR2(50) NOT NULL
);
 



CREATE TABLE equipo(
codEquipo number NOT NULL,
nombre varchar2(20) NOT NULL,
Nacionalidad varchar2(50),
Fecha_Creacion date,
telefono number,
mail VARCHAR2(150) NOT NULL,
escudo varbinary
);
CREATE TABLE jornada


CREATE TABLE partido


CREATE TABLE resultado


CREATE TABLE entrenador


CREATE TABLE asistente


CREATE TABLE calendario


CREATE TABLE fichero


CREATE TABLE rol
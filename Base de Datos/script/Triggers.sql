/*TRIGGERS*/
/*1. Controlar el max de jugadores por equipos*/
set serveroutput on

create or replace trigger jugMax
before insert on jugador
for each row
declare 
v_numJugadores PLS_INTEGER;
begin
    select count(*) into v_numJugadores
    from jugador
    where id_equipo= :new.id_equipo;
  if v_numJugadores = 6 then
    raise_application_error(-20007,'ERROR: EQUIPO COMPLETO');
  END IF;
END;

alter  trigger jugMax disable; 

/*2. Controlar que una vez generado el calendario no se pueden modificar,
ni equipos, ni jugadores*/
desc calendario;
select * from calendario;
/**********************PARA LA TABLA JUGADORES****************************** */
create or replace trigger calCerradoJU
before insert or update or delete on jugador
for each row
declare
  v_crud varchar2 (250);
  v_cerrado char(1);
begin
 select cerrado into v_cerrado
 from calendario;
 CASE
  when inserting then
     v_crud :='NO SE PUEDE INSERTAR JUGADOR, EL CALENDARIO ESTA CERRADO';
  when updating then
      v_crud :='NO SE PUEDE MODIFICAR EL JUGADOR, EL CALENDARIO ESTA CERRADO';
  when deleting then
     v_crud:= 'NO SE PUEDE BORRAR EL JUGADOR EL CALENDARIO ESTA CERRADO';
 END CASE;
 if upper(v_cerrado)='S' then
 raise_application_error(-20008,('ERROR: ' || v_crud));
 END IF;
END; 
 
 alter  trigger calCerrado disable; 
 
/**********************PARA LA TABLA EQUIPOS****************************** */
create or replace trigger calCerradoEQ
before insert or update or delete on equipo
for each row
declare
  v_crud varchar2 (250);
  v_cerrado char(1);
begin
 select cerrado into v_cerrado
 from calendario;
 CASE
  when inserting then
     v_crud :='NO SE PUEDE INSERTAR EQUIPO, EL CALENDARIO ESTA CERRADO';
  when updating then
      v_crud :='NO SE PUEDE MODIFICAR EL EQUIPO, EL CALENDARIO ESTA CERRADO';
  when deleting then
     v_crud:= 'NO SE PUEDE BORRAR EL EQUIPO EL CALENDARIO ESTA CERRADO';
 END CASE;
 if upper(v_cerrado)='S' then
 raise_application_error(-20008,('ERROR: ' || v_crud));
 END IF;
END;  
 

/**********************Controlar min jugadores****************************** */

create or replace trigger jugMin
for update of cerrado on calendario compound trigger

newCalendario calendario%rowtype;
v_numJugadores PLS_INTEGER;
v_cerrado char(1);
e_calendario_cerrado EXCEPTION;

cursor id_equipo_cursor is
select COD_EQUIPO,NOMBRE,NACIONALIDAD,FECHA_CREACION,TELEFONO,MAIL,ESCUDO
from equipo;

before each row is

begin
if updating then
newCalendario.ID_CALENDARIO:= :new.ID_CALENDARIO;
newCalendario.CERRADO:= :new.CERRADO;
newCalendario.TEMPORADA:= :new.TEMPORADA;
end if;
end before each row;


before statement is
begin

select newCalendario.cerrado into v_cerrado
from calendario;

if upper(v_cerrado)='S' then
raise e_calendario_cerrado;
end if;

FOR v_cod_equipo in id_equipo_cursor loop

select count(*) into v_numJugadores
from jugador
where id_equipo= v_cod_equipo.COD_EQUIPO;

if v_numJugadores < 2 then
raise_application_error(-20011,'ERROR: EQUIPO '||v_cod_equipo.COD_EQUIPO||' CON POCOS JUGADORES');
END IF;
end loop;

	EXCEPTION
	WHEN e_calendario_cerrado then
	RAISE_APPLICATION_ERROR(-20012, 'ERROR: EL CALENDARIO ESTA CERRADO');
	END BEFORE STATEMENT;
end;

alter trigger jugMin disable;


update calendario
set cerrado='N';

insert into equipo (nombre, nacionalidad, fecha_creacion, telefono, mail, escudo)
values('playedsrs', 'alemadasna', to_date('01/04/2020', 'DD/MM/YYYY'),648557, 
        'plafasyers@gmail.com', 'tiene');
        
       
update calendario
set cerrado='N';

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo)
VALUES ('512708J',' tine Pages','8901','3 Chelmsford Close- Sutton',6,10291);

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo)
VALUES ('500108J',' enne Pages','871601','3 Chelmsford Close- Sutton',6,10291);

update calendario
set cerrado='N';

/**********************Controlar el insert de calendario****************************** */

      
create or replace trigger calCerrado 
before insert or update or delete on calendario 
declare
v_cerrado char(1);
e_calendario_cerrado EXCEPTION;
begin

select cerrado into v_cerrado
from calendario;

if upper(v_cerrado)='S' then
raise e_calendario_cerrado;
end if;

EXCEPTION
WHEN e_calendario_cerrado THEN
RAISE_APPLICATION_ERROR(-20201,'ERROR: EL CALENDARIO ESTA CERRADO');
end;

alter trigger calCerrado disable;

update calendario
set cerrado='N';

insert into calendario (cerrado,temporada) values ('N','5');

delete calendario;
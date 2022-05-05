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
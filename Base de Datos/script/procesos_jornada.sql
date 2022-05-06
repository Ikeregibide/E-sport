DESC JORNADA


/*FUNCION PARA COMPROBAR QUE UNA JORNADA EXISTE*/
create or replace function validar_jornada
(p_jornada in number)
return boolean
is
  v_idJornada number;
begin
  select num_jornada into v_idJornada
  from jornada
  where jornada.num_jornada = p_jornada;
return true;
exception
  when no_data_found then 
    return false;
end validar_jornada;


/*PROCEDIMIENTO PARA AÑADIR jornada*/
create or replace procedure nuevo_jornada
(
p_fecha jornada.fecha%type,
p_numSemana jornada.num_semana%type,
p_idCalendario jornada.id_calendario%type
)
is
begin
  if validar_jornada(p_idCalendario)then

     insert into jornada
     (FECHA,NUM_SEMANA,id_calendario)
        values(p_fecha,p_numSemana,p_idCalendario);
  else
    dbms_output.put_line ('El equipo no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_jornada;



/*PROCEDIMIENTO PARA BORRAR jronada*/
create or replace procedure borrar_jornada(
p_numJornada jornada.num_jornada%type
)
is
begin
  if validar_jornada(p_numJornada) then
   delete from jornada
   where num_jornada = p_numJornada;
   
   else
        dbms_output.put_line ('El dueno no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_jornada;  
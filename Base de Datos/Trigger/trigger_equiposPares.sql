SET SERVEROUTPUT ON
create or replace trigger equiposPares
  before update on CALENDARIO
  FOR EACH ROW
  DECLARE
  cant_equipos PLS_INTEGER;
  equipos_Impares EXCEPTION;
  BEGIN
  DBMS_OUTPUT.PUT_LINE('S');
  SELECT COUNT(*) INTO cant_equipos 
  FROM EQUIPO;

  IF (MOD(cant_equipos,2) = 0) THEN
  dbms_output.put_line('SE HA EJECUTADO CORRECTAMENTE');
  ELSE
  RAISE equipos_Impares;
  END IF;
  EXCEPTION
  WHEN equipos_Impares THEN
  RAISE_APPLICATION_ERROR(-20100, ' LO SENTIMOS PERO LOS EQUIPOS SON IMPARES ' ||SQLERRM);
  
END;
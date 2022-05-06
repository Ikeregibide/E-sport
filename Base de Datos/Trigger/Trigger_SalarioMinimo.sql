CREATE OR REPLACE TRIGGER SalarioMinimo
FOR INSERT OR UPDATE OF sueldo ON jugador COMPOUND TRIGGER

newJugador jugador%rowtype;
v_sueldosTotal NUMBER; --La suma de todo el sueldo
v_presupuestoMaximoPorEquipo number:=200000; --El presupuesto maximo
v_nuevoSueldo NUMBER;
v_errorSalario EXCEPTION;

BEFORE EACH ROW IS
BEGIN
if inserting then
newJugador.ID_JUGADOR:= :new.ID_JUGADOR;
newJugador.DNI:= :new.DNI;
newJugador.NOMBRE:= :new.NOMBRE;
newJugador.TELEFONO:= :new.TELEFONO;
newJugador.DIRECCION:= :new.DIRECCION;
newJugador.ID_EQUIPO:= :new.ID_EQUIPO;
newJugador.NICKNAME:= :new.NICKNAME;
newJugador.SUELDO:= :new.SUELDO;
newJugador.ID_ROL:= :new.ID_ROL;

end if;

END BEFORE EACH ROW;


BEFORE STATEMENT IS

BEGIN

SELECT sum(newJugador.SUELDO)
INTO v_sueldosTotal
FROM jugador;

v_nuevoSueldo := newJugador.SUELDO + v_sueldosTotal;

IF(v_nuevoSueldo>v_presupuestoMaximoPorEquipo)THEN
dbms_output.put_line(' FUNCIONA ');
ELSE
RAISE v_errorSalario;
END IF;
EXCEPTION
WHEN v_errorSalario THEN
RAISE_APPLICATION_ERROR(-20101, ' Estás introduciendo un salario superior al salario mínimo ' );

end BEFORE STATEMENT;
END;
alter trigger SalarioMinimo disable;
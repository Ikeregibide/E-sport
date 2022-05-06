/*Pruebas_procesos_jornada*/
/*PRUEBAS PROCEDIMIENTO NUEVO-JORNADA*/
/*PRUEBO CON UN NUMERO DE JORNADA QUE EXISTE*/
/*FECHA   
--------
07/05/22
14/05/22
20/05/22
27/05/22
*/
begin
  nuevo_jornada(to_date('05/05/2022', 'DD/MM/YYYY'),
  '22', 1);
end;
SELECT *
FROM jornada;
/*FECHA   
--------
07/05/22
14/05/22
20/05/22
27/05/22
05/05/22
*/
/*Comprobamos de meter una fecha futura
no nos da ningun error pero ala hora de comprobar 
no inserta nada*/
begin
  nuevo_jornada(to_date('07/05/2022', 'DD/MM/YYYY'),
  '22', 1);
end;
SELECT *
FROM jornada;
/*
FECHA   
--------
07/05/22
14/05/22
20/05/22
27/05/22
05/05/24
*/




/*PRUEBAS PROCEDIMIENTO BORRAR_JORNADA
CON UN ID EXISITENTE*/
/*
NUM_JORNADA FECHA    NU ID_CALENDARIO
----------- -------- -- -------------
          1 07/05/22 18             1
          2 14/05/22 19             1
          3 20/05/22 20             1
          4 27/05/22 21             1
          5 05/05/22 22             1
*/

begin
  borrar_jornada(5);
end;
SELECT *
FROM jornada;

/*
NUM_JORNADA FECHA    NU ID_CALENDARIO
----------- -------- -- -------------
          1 07/05/22 18             1
          2 14/05/22 19             1
          3 20/05/22 20             1
          4 27/05/22 21             1
*/

/*PRUEBO CON UN ID QUE NO EXISTE*/
begin
  borrar_jornada(192);
end;
/*El jugador no existe*/



/




































































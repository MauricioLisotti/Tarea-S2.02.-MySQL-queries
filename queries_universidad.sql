# 1-Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
select apellido1, apellido2, nombre from persona where tipo='alumno' order by apellido1 asc, apellido2 asc, nombre asc;

# 2-Halla el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
select nombre, apellido1, apellido2 from persona where tipo='alumno' and telefono is null;

# 3-Devuelve el listado de los alumnos que nacieron en 1999.
select * from persona where tipo='alumno' and fecha_nacimiento like '1999%';

# 4-Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.
select * from persona where tipo='profesor' and telefono is null and nif like '%k';

# 5-Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
select * from asignatura where id_grado=7 and cuatrimestre=1 and curso=3;

# 6-Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.
select p.nombre, p.apellido1, p.apellido2, d.nombre from (persona p left join profesor q on p.id=q.id_profesor) left join departamento d on q.id_departamento=d.id where d.nombre is not null order by p.apellido1 asc, p.apellido2 asc, p.nombre asc;

# 7-Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 26902806M.
select asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin from  (alumno_se_matricula_asignatura left join asignatura on alumno_se_matricula_asignatura.id_asignatura=asignatura.id) left join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar=curso_escolar.id where alumno_se_matricula_asignatura.id_alumno = (select id from persona where nif like '26902806M');

# 8-Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
select nombre from departamento where id in (select id_departamento from profesor where id_profesor in (select a.id_profesor from asignatura a left join grado g on a.id_grado = g.id where g.nombre like 'Grado en Ingeniería Informática (Plan 2015)'));

# 9-Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.
select distinct alumno_se_matricula_asignatura.id_alumno from (alumno_se_matricula_asignatura left join asignatura on alumno_se_matricula_asignatura.id_asignatura=asignatura.id) left join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar=curso_escolar.id where anyo_inicio like '2018';

# Resuelva las 6 siguientes consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

# 1-Devuelve un listado con los nombres de todos los profesores y departamentos que tienen vinculados. El listado también debe mostrar a aquellos profesores que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y nombre.
select d.nombre, p.apellido1, p.apellido2, p.nombre from (persona p right join profesor t on p.id=t.id_profesor) left join departamento d on t.id_departamento=d.id order by d.nombre asc, p.apellido1 asc, p.apellido2 asc, p.nombre asc;

# 2-Devuelve un listado con los profesores que no están asociados a un departamento.
select p.apellido1, p.apellido2, p.nombre, t.id_departamento from (persona p left join profesor t on p.id=t.id_profesor) where t.id_departamento is null;

# 3-Devuelve un listado con los departamentos que no tienen profesores asociados. p.apellido1, p.apellido2, p.nombre, t.id_departamento
select d.*, t.id_departamento from departamento d left join profesor t on d.id=t.id_departamento where t.id_departamento is null;

# 4-Devuelve un listado con los profesores que no imparten ninguna asignatura.
select t.*, a.id_profesor from profesor t left join asignatura a on t.id_profesor=a.id_profesor where a.id_profesor is null;

# 5-Devuelve un listado con las asignaturas que no tienen un profesor asignado.
select a.* from asignatura a left join profesor t on a.id_profesor=t.id_profesor where a.id_profesor is null;

# 6-Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
select d.*, a.id as id_asignatura from (profesor t left join departamento d on t.id_departamento=d.id) left join asignatura a on t.id_profesor=a.id_profesor where a.id is null;


# Consultas resumen:

# 1-Devuelve el número total de alumnos existentes.
select count(*) as cant_personas from persona where tipo like 'alumno';

# 2-Calcula cuántos alumnos nacieron en 1999.
select count(*) as born_1999 from persona where tipo like 'alumno' and fecha_nacimiento like '%1999%';

# 3-Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.
select d.nombre as nombre_departamento, count(t.id_profesor) as num_profesor from departamento d right join profesor t on d.id=t.id_departamento group by d.nombre order by num_profesor desc;

# 4-Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que carecen de profesores asociados. Estos departamentos también deben aparecer en el listado.
select d.nombre as nombre_departamento, count(t.id_profesor) as num_profesor from departamento d left join profesor t on d.id=t.id_departamento group by d.nombre order by num_profesor desc;

# 5-Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que carecen de asignaturas asociadas. Estos grados también deben aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
select g.nombre, count(a.id) as cant_asignaturas from grado g left join asignatura a on g.id=a.id_grado group by g.nombre order by cant_asignaturas desc;

# 6-Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
select g.nombre, count(a.id) as cant_asignaturas from grado g left join asignatura a on g.id=a.id_grado group by g.nombre having count(a.id) > 40;

# 7-Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos existentes para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que existen de este tipo.
select g.nombre, a.tipo, sum(a.creditos) as num_creditos from grado g right join asignatura a on g.id=a.id_grado group by a.tipo, g.id order by g.nombre;

# 8-Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado tendrá que mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
select c.anyo_inicio as año_inicio, count(a.id_alumno) as cant_alumnos from curso_escolar c left join alumno_se_matricula_asignatura a on c.id=a.id_curso_escolar group by c.anyo_inicio;

# 9-Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta a aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.
select p.id, p.nombre, p.apellido1, p.apellido2, count(a.id) as cant_asignaturas from (persona p right join profesor t on p.id=t.id_profesor) left join asignatura a on t.id_profesor=a.id_profesor group by p.id order by cant_asignaturas desc;

# 10-Devuelve todos los datos del alumno más joven.
select * from persona p left join alumno_se_matricula_asignatura a on p.id=a.id_alumno where p.fecha_nacimiento = (select max(fecha_nacimiento) from persona);

# 11-Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.
select p.* from (persona p right join profesor t on p.id=t.id_profesor) left join asignatura a on t.id_profesor=a.id_profesor where a.id is null and t.id_departamento is not null;

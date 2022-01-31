use tienda;

# 1-Lista el nombre de todos los productos que hay en la mesa producto.
select nombre from producto;

# 2-Lista los nombres y los precios de todos los productos de la mesa producto.
select nombre, precio from producto;

# 3-Lista todas las columnas de la tabla producto.
show columns from producto;

# 4-Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
select nombre, precio as "precio_euros", (select precio * 1.13) as  "precio_dolares" from producto;

# 5-Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes sobrenombre para las columnas: nombre de producto, euros, dólares.
select nombre as 'nom de producto', precio as euros, (select precio * 1.13) as dolars from producto;

# 6-Lista los nombres y los precios de todos los productos de la mesa producto, convirtiendo los nombres a mayúscula.
select upper(nombre), precio from producto;

# 7-Lista los nombres y los precios de todos los productos de la mesa producto, convirtiendo los nombres a minúscula.
select lower(nombre), precio from producto;

# 8-Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
select nombre, left(upper(nombre), 2) as inicial from fabricante;

# 9-Lista los nombres y los precios de todos los productos de la mesa producto, redondeando el valor del precio.
select nombre, round(precio) precio from producto;

# 10-Lista los nombres y precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
select nombre, truncate(precio, 0) from producto;

# 11-Lista el código de los fabricantes que tienen productos en la mesa producto.
select codigo from fabricante where codigo in (select codigo_fabricante from producto);

# 12-Lista el código de los fabricantes que tienen productos en la mesa producto, eliminando los códigos que aparecen repetidos.
select codigo from fabricante where codigo in (select codigo_fabricante from producto group by codigo_fabricante having count(codigo_fabricante) = 1);

# 13-Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre from fabricante order by nombre asc;

# 14-Lista los nombres de los fabricantes ordenados de forma descendente.
select nombre from fabricante order by nombre desc;

# 15-Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
select nombre from producto order by nombre asc, precio desc;

# 16-Devuelve una lista con las 5 primeras filas de la mesa fabricante.
select * from fabricante limit 5;

# 17-Devuelve una lista con 2 filas a partir de la cuarta fila de la mesa fabricante. La cuarta fila también debe incluirse en la respuesta.
select * from fabricante limit 3, 2;

# 18-Lista el nombre y precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT). NOTA: Aquí no podría usar MIN(precio), necesitaría GROUP BY.
select nombre, precio from producto order by precio asc limit 1;

# 19-Lista el nombre y precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT). NOTA: Aquí no podría usar MAX(precio), necesitaría GROUP BY.
select nombre, precio from producto order by precio desc limit 1;

# 20-Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
select nombre from producto where codigo_fabricante = 2;

# 21-Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
select p.nombre, p.precio, f.nombre as nombre_fabricante from producto p, fabricante f where p.codigo_fabricante=f.codigo;

# 22-Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
select p.nombre, p.precio, f.nombre as nombre_fabricante from producto p, fabricante f where p.codigo_fabricante=f.codigo order by f.nombre asc;

# 23-Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
select p.codigo, p.nombre, f.nombre as nombre_fabricante, p.codigo_fabricante from  producto p, fabricante f where p.codigo_fabricante=f.codigo order by f.codigo asc;

# 24-Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select p.nombre, p.precio, f.nombre as nombre_fabricante from producto p, fabricante f where p.codigo_fabricante=f.codigo order by p.precio asc limit 1;

# 25-Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
select p.nombre, p.precio, f.nombre as nombre_fabricante from producto p, fabricante f where p.codigo_fabricante=f.codigo order by p.precio desc limit 1;

# 26-Devuelve una lista de todos los productos del fabricante Lenovo.
select * from producto where codigo_fabricante in (select codigo from fabricante where nombre like 'Lenovo');

# 27-Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200 €.
select * from producto where codigo_fabricante in (select codigo from fabricante where nombre like 'Crucial') and precio>200;

# 28-Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
select p.* from producto p join fabricante f on p.codigo_fabricante=f.codigo where 
	f.nombre like 'Asus' or
	f.nombre like 'Hewlett-Packard' or
	f.nombre like 'Seagate';

# 29-Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.
select * from producto where codigo_fabricante in (select codigo from fabricante where 
	nombre like 'Asus' or
    nombre like 'Hewlett-Packard' or
	nombre like 'Seagate');
    
# 30-Devuelve un listado con el nombre y precio de todos los productos de los fabricantes cuyo nombre acabe por la vocal e.
select p.nombre, p.precio from producto p, fabricante f where p.codigo_fabricante=f.codigo and f.nombre like '%e';

# 31-Devuelve un listado con el nombre y precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
select p.nombre, p.precio from producto p, fabricante f where p.codigo_fabricante=f.codigo and f.nombre like '%w%';

# 32-Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180 €. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
select p.nombre, p.precio, f.nombre from producto p, fabricante f where p.codigo_fabricante=f.codigo and p.precio >=180 order by p.precio desc, p.nombre asc;

# 33-Devuelve un listado con el código y el nombre de fabricante, sólo de aquellos fabricantes que tienen productos asociados en la base de datos.
select codigo, nombre from fabricante where codigo in (select codigo_fabricante from producto);

# 34-Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también a aquellos fabricantes que no tienen productos asociados.
select * from fabricante f left join producto p on f.codigo=p.codigo_fabricante;

# 35-Devuelve un listado en el que sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
select * from fabricante f left join producto p on f.codigo=p.codigo_fabricante where p.nombre is null;

# 36-Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
select * from producto where codigo_fabricante in (select codigo from fabricante where nombre='Lenovo');

# 37-Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
select * from producto where precio = 
	(select max(precio) from producto where codigo_fabricante = 
		(select codigo from fabricante where nombre = 'Lenovo'));
        
# 38-Lista el nombre del producto más caro del fabricante Lenovo.
select p.nombre from producto p left join fabricante f on p.codigo_fabricante=f.codigo where f.nombre = 'Lenovo' having max(p.precio);

# 39-Lista el nombre del producto más barato del fabricante Hewlett-Packard.
select p.nombre from producto p left join fabricante f on p.codigo_fabricante=f.codigo where f.nombre = 'Hewlett-Packard' having min(p.precio);

# 40-Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
select * from producto left join fabricante on producto.codigo_fabricante=fabricante.codigo 
	where producto.precio >= (select max(precio) from producto 
		where codigo_fabricante in (select codigo from fabricante 
			where nombre = 'Lenovo'))
	and producto.codigo_fabricante not in (select codigo from fabricante where nombre = 'Lenovo');
    
# 41-Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
select * from producto p left join fabricante f on p.codigo_fabricante=f.codigo
	where f.nombre like 'Asus' 
	and p.precio > (select avg(precio) from producto left join fabricante on producto.codigo_fabricante=fabricante.codigo 
		where fabricante.nombre = 'Asus');

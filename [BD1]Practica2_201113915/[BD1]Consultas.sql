-- ======================================================================================
-- Consulta 1
-- Mostrar el nombre del hospital, su dirección y el número de fallecidos por cada hospi-
-- tal registrado.
-- ====================================================================================== 

SELECT Hospital.Nombre, Hospital.Direccion, COUNT(Victima.Id_Victima) AS NumeroFallecidos 
    FROM Victima
        INNER JOIN Hospital_Persona ON Hospital_Persona.Victima = Victima.Id_Victima
        INNER JOIN Hospital ON Hospital.Id_Hospital = Hospital_Persona.Hospital
            WHERE Victima.Fecha_Muerte IS NOT NULL
                GROUP BY Hospital.Nombre, Hospital.Direccion
                ORDER BY NumeroFallecidos DESC;

-- ======================================================================================
-- Consulta 2
-- Mostrar el nombre, apellido de todas las víctimas en cuarentena que presentaron una 
-- efectividad mayor a 5 en el tratamiento “Transfusiones de sangre”.
-- ======================================================================================

SELECT Victima.Nombre, Victima.Apellido--, Estado.Estado, Tratamiento_Persona.Efectividad_Victima, Tratamiento.Tratamiento
    FROM Victima
        INNER JOIN Tratamiento_Persona ON Tratamiento_Persona.Victima = Id_Victima
        INNER JOIN Tratamiento ON Tratamiento_Persona.Tratamiento = Tratamiento.Id_Tratamiento
        INNER JOIN Estado ON Victima.Estado = Estado.Id_Estado
            WHERE UPPER(Tratamiento.Tratamiento) = 'TRANSFUSIONES DE SANGRE' 
                AND UPPER(Estado.Estado) = 'EN CUARENTENA'
                    AND Tratamiento_Persona.Efectividad_Victima > 5;

-- ======================================================================================
-- Consulta 3
-- Mostrar el nombre, apellido y dirección de las víctimas fallecidas con más de tres 
-- personas asociadas.
-- ======================================================================================

SELECT Victima.Nombre, Victima.Apellido, Victima.Direccion--, COUNT(Asociado) AS No_Asociados
    FROM Victima 
        INNER JOIN Conocimiento ON Id_Victima = Conocimiento.Victima
            WHERE Victima.Fecha_Muerte IS NOT NULL
                GROUP BY Id_Victima, Victima.Nombre, Victima.Apellido, Victima.Direccion
                    HAVING COUNT(Asociado) >3;
      
-- ======================================================================================
-- Consulta 4
-- Mostrar el nombre y apellido de todas las víctimas en estado “Sospecha” que tuvieron
-- contacto físico de tipo “Beso” con más de 2 de sus asociados.
-- ====================================================================================== 

SELECT Victima.Nombre, Victima.Apellido--, Estado.Estado, Contacto_Fisico.Contacto_Fisico
    FROM Victima
        INNER JOIN Estado ON Victima.Estado = Estado.Id_Estado
        INNER JOIN Contacto_Personas ON Contacto_Personas.Victima = Victima.Id_Victima
        INNER JOIN Contacto_Fisico ON Contacto_Fisico.Id_Contacto = Contacto_Personas.Contacto_Fisico
            WHERE UPPER(Estado.Estado) = 'SOSPECHA' AND UPPER(Contacto_Fisico.Contacto_Fisico) = 'BESO'
            GROUP BY Victima.Nombre, Victima.Apellido, Estado.Estado, Contacto_Fisico.Contacto_Fisico 
            HAVING COUNT(Contacto_Personas.Asociado)>2;

-- ======================================================================================
-- Consulta 5
-- Top 5 de víctimas que más tratamientos se han aplicado del tratamiento “Oxígeno”.
-- ====================================================================================== 

SELECT * FROM
(
    SELECT Victima.Id_Victima, Victima.Nombre, Victima.Apellido, Tratamiento.Tratamiento, count(tratamiento_persona.tratamiento)
        FROM Tratamiento_Persona
        INNER JOIN Victima ON Victima.Id_Victima = Tratamiento_Persona.Victima
        INNER JOIN Tratamiento ON Tratamiento.Id_Tratamiento = Tratamiento_Persona.Tratamiento
            WHERE UPPER(Tratamiento.Tratamiento) = 'OXIGENO'
            GROUP BY Victima.Id_Victima, Victima.Nombre, Victima.Apellido, Tratamiento.Tratamiento, tratamiento_persona.fecha_inicio, tratamiento_persona.fecha_fin
            ORDER BY count(tratamiento_persona.tratamiento) DESC
)WHERE ROWNUM <= 5;

-- ======================================================================================
-- Consulta 6
-- Mostrar el nombre, el apellido y la fecha de fallecimiento de todas las víctimas que 
-- se movieron por la dirección “1987 Delphine Well” a los cuales se les aplicó "Manejo 
-- de la presión arterial" como tratamiento.
-- ====================================================================================== 

SELECT Victima.Nombre, Victima.Apellido, Victima.Fecha_Muerte--, Ubicacion.Direccion, Tratamiento.*
    FROM Victima
        INNER JOIN Ubicacion ON Ubicacion.Victima = Victima.Id_Victima
        INNER JOIN Tratamiento_Persona ON Tratamiento_Persona.Victima = Victima.Id_Victima
        INNER JOIN Tratamiento ON Tratamiento.Id_Tratamiento = Tratamiento_Persona.Tratamiento
            WHERE Victima.Fecha_Muerte IS NOT NULL 
            AND UPPER(Ubicacion.Direccion) = '1987 DELPHINE WELL' 
            AND UPPER(Tratamiento.Tratamiento) = 'MANEJO DE LA PRESION ARTERIAL';

-- ======================================================================================
-- Consulta 7
-- Mostrar nombre, apellido y dirección de las víctimas que tienen menos de 2 allegados 
-- los cuales hayan estado en un hospital y que se le hayan aplicado únicamente dos tra-
-- tamientos.
-- ====================================================================================== 

SELECT Allegados.Nombre, Allegados.Apellido, Allegados.Direccion/*, Allegado,*/ Trat FROM
(
SELECT Victima.Id_Victima, Victima.Nombre, Victima.Apellido, Victima.Direccion, Contacto_Personas.Asociado, COUNT(Contacto_Personas.Victima) AS Allegado
    FROM Victima INNER JOIN Contacto_Personas ON Victima.Id_Victima = Contacto_Personas.Victima
        GROUP BY Victima.Id_Victima, Victima.Nombre, Victima.Apellido, Victima.Direccion, Contacto_Personas.Asociado
            HAVING COUNT(Contacto_Personas.Asociado) < 2
)Allegados INNER JOIN
(
SELECT Victima.Id_Victima, Victima.Nombre, Victima.Apellido, Victima.Direccion, COUNT(Tratamiento_Persona.Victima) AS Trat
    FROM Victima 
        INNER JOIN Hospital_Persona ON  Hospital_Persona.Victima = Victima.Id_Victima
        INNER JOIN Tratamiento_Persona ON Tratamiento_Persona.Victima = Victima.Id_Victima
            GROUP BY Victima.Id_Victima, Victima.Nombre, Victima.Apellido, Victima.Direccion
            HAVING COUNT(Tratamiento_Persona.Victima) = 2
)Tratamientos ON Tratamientos.Id_Victima =  Allegados.Id_Victima;

-- ======================================================================================
-- Consulta 8
-- Mostrar el número de mes ,de la fecha de la primera sospecha, nombre y apellido de las
-- víctimas que más tratamientos se han aplicado y las que menos. 
-- (Todo en una sola consulta).
-- ====================================================================================== 

SELECT to_char(Fecha_Primera_Sospecha, 'MM') as Mes, Nombre, Apellido, Trat as Tratamiento FROM
(
    SELECT Victima.Nombre, Victima.Apellido, Victima.Fecha_Primera_Sospecha, COUNT(Tratamiento_Persona.Victima) AS Trat
        FROM Tratamiento_Persona
            INNER JOIN Victima ON Victima.Id_Victima = Tratamiento_Persona.Victima
                GROUP BY Victima.Nombre, Victima.Apellido, Victima.Fecha_Primera_Sospecha
),

(
    SELECT MAX(CONTEO) AS MAXIMO, MIN(CONTEO) AS MINIMO FROM(
        SELECT COUNT(Tratamiento_Persona.Victima) AS CONTEO
                FROM Tratamiento_Persona
                    INNER JOIN Victima ON Victima.Id_Victima = Tratamiento_Persona.Victima
                        GROUP BY Victima.Nombre, Victima.Apellido
    ) 
)
WHERE Trat = MAXIMO OR Trat = MINIMO
ORDER BY Trat DESC;

-- ======================================================================================
-- Consulta 9
-- Mostrar el porcentaje de víctimas que le corresponden a cada hospital.
-- ====================================================================================== 

SELECT Hospital.Nombre, Hospital.Direccion, TRUNC( COUNT(Hospital_Persona.Victima) *100 / (SELECT COUNT(*) FROM hospital_persona), 2 )|| '%' AS Porcentaje_Victimas
    FROM Hospital_Persona
        INNER JOIN Hospital ON Hospital.Id_Hospital = Hospital_Persona.Hospital
        GROUP BY Hospital.Id_Hospital, Hospital.Nombre, Hospital.Direccion
            ORDER BY Hospital.Nombre, Hospital.Direccion;

-- ======================================================================================
-- Consulta 10
-- Mostrar el porcentaje del contacto físico más común de cada hospital de la siguiente 
-- manera: nombre de hospital, nombre del contacto físico, porcentaje de víctimas.
-- ====================================================================================== 
    
SELECT Individuales.Nombre, Individuales.Contacto_Fisico, TRUNC(Individual/Total*100,2)||'%' AS Porcentaje_Victimas
FROM (
    SELECT Nombre, MAX(Individual) AS Maximo FROM(
        SELECT Hospital.Nombre, Contacto_Fisico.Contacto_Fisico, COUNT(Contacto_Fisico.Id_Contacto) AS Individual
            FROM Hospital
                INNER JOIN Hospital_Persona ON Hospital_Persona.Hospital = Hospital.Id_Hospital
                INNER JOIN Victima ON Hospital_Persona.Victima = Victima.Id_Victima
                INNER JOIN Contacto_Personas ON Contacto_Personas.Victima = Victima.Id_Victima
                INNER JOIN Contacto_Fisico ON Contacto_Personas.Contacto_Fisico = Contacto_Fisico.Id_Contacto
                    GROUP BY Hospital.Nombre, Contacto_Fisico.Contacto_Fisico
    )
    GROUP BY Nombre

)Maximos 
INNER JOIN
(
    SELECT Hospital.Nombre, COUNT(Contacto_Personas.Contacto_Fisico) AS Total
        FROM Hospital
            INNER JOIN Hospital_Persona ON Hospital_Persona.Hospital = Hospital.Id_Hospital
            INNER JOIN Victima ON Hospital_Persona.Victima = Victima.Id_Victima
            INNER JOIN Contacto_Personas ON Contacto_Personas.Victima = Victima.Id_Victima
                GROUP BY Hospital.Nombre 
) Totales ON Totales.Nombre = Maximos.Nombre 
INNER JOIN
(
    SELECT Hospital.Nombre, Contacto_Fisico.Contacto_Fisico, COUNT(Contacto_Fisico.Id_Contacto) AS Individual
        FROM Hospital
            INNER JOIN Hospital_Persona ON Hospital_Persona.Hospital = Hospital.Id_Hospital
            INNER JOIN Victima ON Hospital_Persona.Victima = Victima.Id_Victima
            INNER JOIN Contacto_Personas ON Contacto_Personas.Victima = Victima.Id_Victima
            INNER JOIN Contacto_Fisico ON Contacto_Personas.Contacto_Fisico = Contacto_Fisico.Id_Contacto
                GROUP BY Hospital.Nombre, Contacto_Fisico.Contacto_Fisico
) Individuales ON Individuales.Individual = Maximos.Maximo AND Individuales.Nombre = Maximos.Nombre
ORDER BY Individuales.Nombre;

-- ====================================================================================== 
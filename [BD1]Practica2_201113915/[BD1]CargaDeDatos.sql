-- ======================================================================================
-- Llenando Tabla Tratamiento
-- ======================================================================================

INSERT INTO Tratamiento (Tratamiento, Efectividad)
    SELECT DISTINCT Registro.Tratamiento, Registro.Efectividad 
        FROM Registro
            WHERE Registro.Tratamiento IS NOT NULL
             GROUP BY Registro.Tratamiento, Registro.Efectividad;

-- ======================================================================================
-- Llenando Tabla Hospital
-- ======================================================================================

INSERT INTO Hospital(Nombre, Direccion)        
    SELECT DISTINCT Nombre_Hospital, Direccion_Hospital
        FROM Registro
            WHERE Nombre_Hospital IS NOT NULL AND Direccion_Hospital IS NOT NULL;

-- ======================================================================================
-- Llenando Tabla Estado
-- ======================================================================================

INSERT INTO Estado (Estado)   
    SELECT DISTINCT Estado_Victima
        FROM Registro
            WHERE Estado_Victima IS NOT NULL;

-- ======================================================================================
-- Llenando Tabla Contacto_Fisico
-- ======================================================================================            

INSERT INTO Contacto_Fisico (Contacto_Fisico)
    SELECT DISTINCT Contacto_Fisico
        FROM Registro
            WHERE Contacto_Fisico IS NOT NULL;    

-- ======================================================================================
-- Llenando Tabla Victima
-- ======================================================================================

INSERT INTO Victima(Nombre, Apellido, Direccion, Fecha_Primera_Sospecha, Fecha_Confirmacion, Fecha_Muerte, Estado)
    SELECT DISTINCT Nombre_Victima, Apellido_Victima, Direccion_Victima, Fecha_Primera_Sospecha, Fecha_Confirmacion, Fecha_Muerte, Estado.Id_Estado
        FROM Registro
            INNER JOIN Estado ON Estado.Estado = Registro.Estado_Victima
                WHERE Nombre_Victima IS NOT NULL AND Apellido_Victima IS NOT NULL;

-- ======================================================================================
-- Llenando Tabla Hospital_Persona
-- ======================================================================================

INSERT INTO Hospital_Persona(Victima, Hospital)
    SELECT DISTINCT Id_Victima, Id_Hospital
        FROM Registro
            INNER JOIN Victima ON Victima.Nombre = Nombre_Victima AND Victima.Apellido = Apellido_Victima
            INNER JOIN Hospital ON Hospital.Nombre = Nombre_Hospital AND Hospital.Direccion = Direccion_Hospital
                WHERE Id_Victima IS NOT NULL AND Id_Hospital IS NOT NULL;

-- ======================================================================================
-- Llenando Tabla Asociado
-- ======================================================================================

INSERT INTO Asociado(Nombre, Apellido)
    SELECT DISTINCT Nombre_Asociado, Apellido_Asociado
        FROM Registro
            WHERE Nombre_Asociado IS NOT NULL AND Apellido_Asociado IS NOT NULL;

-- ======================================================================================
-- Llenando Tabla Conocimiento
-- ======================================================================================             
                        
INSERT INTO Conocimiento
    SELECT DISTINCT Id_Victima, Id_Asociado, Fecha_Conocio 
            FROM Registro
                INNER JOIN Victima ON Victima.Nombre = Nombre_Victima AND Victima.Apellido = Apellido_Victima
                INNER JOIN Asociado ON Asociado.Nombre = Nombre_Asociado AND Asociado.Apellido = Apellido_Asociado
                    WHERE Id_Victima IS NOT NULL AND Id_Asociado IS NOT NULL AND Fecha_Conocio IS NOT NULL
                        ORDER BY Id_Victima, Id_Asociado;

-- ======================================================================================
-- Llenando Tabla Contacto_Personas
-- ======================================================================================                       

INSERT INTO Contacto_Personas                       
    SELECT DISTINCT Id_Victima, Id_Asociado, Id_Contacto, Fecha_Inicio_Contacto, Fecha_Fin_Contacto
        FROM Registro
            INNER JOIN Victima ON Victima.Nombre = Nombre_Victima AND Victima.Apellido = Apellido_Victima
            INNER JOIN Asociado ON Asociado.Nombre = Nombre_Asociado AND Asociado.Apellido = Apellido_Asociado
            INNER JOIN Contacto_Fisico ON Contacto_Fisico.Contacto_Fisico = Registro.Contacto_Fisico
                WHERE Id_Victima IS NOT NULL AND Id_Asociado IS NOT NULL AND Id_Contacto IS NOT NULL AND Fecha_Inicio_Contacto IS NOT NULL AND Fecha_Fin_Contacto IS NOT NULL
                    ORDER BY Id_Victima, Id_Asociado, Id_Contacto;

-- ======================================================================================
-- Llenando Tabla Ubicacion
-- ======================================================================================

INSERT INTO Ubicacion
    SELECT DISTINCT Id_Victima, Ubicacion_Victima, Fecha_Llegada, Fecha_Retiro
        FROM Registro
            INNER JOIN Victima ON Victima.Nombre = Nombre_Victima AND Victima.Apellido = Apellido_Victima
                WHERE Id_Victima IS NOT NULL AND Ubicacion_Victima IS NOT NULL AND Fecha_Llegada IS NOT NULL AND Fecha_Retiro IS NOT NULL
                    ORDER BY Id_Victima;

-- ======================================================================================
-- Llenando Tabla Tratamiento_Persona
-- ======================================================================================

INSERT INTO Tratamiento_Persona                  
    SELECT DISTINCT Id_Victima, Id_Tratamiento, Fecha_Inicio_Tratamiento, Fecha_Fin_Tratamiento, Efectividad_En_Victima
        FROM Registro
            INNER JOIN Victima ON Victima.Nombre = Nombre_Victima AND Victima.Apellido = Apellido_Victima
            INNER JOIN Tratamiento ON Tratamiento.Tratamiento = Registro.Tratamiento
                WHERE Id_Victima IS NOT NULL AND Id_Tratamiento IS NOT NULL AND Fecha_Inicio_Tratamiento IS NOT NULL AND Fecha_Fin_Tratamiento IS NOT NULL AND Efectividad_En_Victima IS NOT NULL;

-- ======================================================================================          
--SELECT * FROM Tratamiento;
--SELECT * FROM Hospital;
--SELECT * FROM Estado;
--SELECT * FROM Contacto_Fisico;
--SELECT * FROM Victima;
--SELECT * FROM Hospital_Persona;
--SELECT * FROM Asociado;
--SELECT * FROM Conocimiento;
--SELECT * FROM Contacto_Personas;
--SELECT * FROM Ubicacion;
--SELECT * FROM Tratamiento_Persona;
--SELECT * FROM Registro;

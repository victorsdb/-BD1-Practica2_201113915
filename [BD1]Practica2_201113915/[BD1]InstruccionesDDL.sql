-- ELIMINANDO TABLAS
DROP TABLE Tratamiento CASCADE CONSTRAINTS;
DROP TABLE Hospital CASCADE CONSTRAINTS;
DROP TABLE Estado CASCADE CONSTRAINTS;
DROP TABLE Contacto_Fisico CASCADE CONSTRAINTS;
DROP TABLE Victima CASCADE CONSTRAINTS;
DROP TABLE Asociado CASCADE CONSTRAINTS;
DROP TABLE Conocimiento CASCADE CONSTRAINTS;
DROP TABLE Contacto_Personas CASCADE CONSTRAINTS;
DROP TABLE Ubicacion CASCADE CONSTRAINTS;
DROP TABLE Tratamiento_Persona CASCADE CONSTRAINTS;
DROP TABLE Registro CASCADE CONSTRAINTS;

CREATE TABLE Tratamiento(
    Id_Tratamiento INTEGER NOT NULL,
    Tratamiento VARCHAR2(50) NOT NULL,
    Efectividad INTEGER NOT NULL,
    
    CONSTRAINT PK_Tratamiento
    PRIMARY KEY(Id_Tratamiento)
);

CREATE TABLE Hospital(
    Id_Hospital INTEGER NOT NULL,
    Nombre VARCHAR2(50) NOT NULL,
    Direccion VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_Hospital
    PRIMARY KEY(Id_Hospital)
);

CREATE TABLE Estado(
    Id_Estado INTEGER NOT NULL,
    Estado VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_Estado
    PRIMARY KEY(Id_Estado)
);

CREATE TABLE Contacto_Fisico(
    Id_Contacto INTEGER NOT NULL,
    Contacto_Fisico VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_Contacto_Fisico
    PRIMARY KEY(Id_Contacto)
);

CREATE TABLE Victima(
    Id_Victima INTEGER NOT NULL,
    Nombre VARCHAR2(50) NOT NULL,
    Apellido VARCHAR2(50) NOT NULL,
    Direccion VARCHAR2(50) NOT NULL,
    Fecha_Primera_Sospecha DATE NOT NULL,
    Fecha_Confirmacion DATE NOT NULL,
    Fecha_Muerte DATE NULL,
    Estado INTEGER NOT NULL,
    Hospital INTEGER NULL,
    
    CONSTRAINT PK_Victima
    PRIMARY KEY(Id_Victima),
    
    CONSTRAINT FK1_Victima
    FOREIGN KEY (Estado)
    REFERENCES Estado(Id_Estado)
    ON DELETE CASCADE,
    
    CONSTRAINT FK2_Victima
    FOREIGN KEY (Hospital)
    REFERENCES Hospital(Id_Hospital)
    ON DELETE CASCADE
);

CREATE TABLE Asociado(
    Id_Asociado INTEGER NOT NULL,
    Nombre VARCHAR2(50) NOT NULL,
    Apellido VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_Asociado
    PRIMARY KEY(Id_Asociado)
);

CREATE TABLE Conocimiento(
    Victima INTEGER NOT NULL,
    Asociado INTEGER NOT NULL,
    Fecha_Conocio DATE NOT NULL,
    
    CONSTRAINT PK_Conocimiento
    PRIMARY KEY(Victima, Asociado),
    
    CONSTRAINT FK1_Conocimiento
    FOREIGN KEY (Victima)
    REFERENCES Victima(Id_Victima)
    ON DELETE CASCADE,
    
    CONSTRAINT FK2_Conocimiento
    FOREIGN KEY (Asociado)
    REFERENCES Asociado(Id_Asociado)
    ON DELETE CASCADE
);

CREATE TABLE Contacto_Personas(
    Victima INTEGER NOT NULL,
    Asociado INTEGER NOT NULL,
    Contacto_Fisico INTEGER NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    
    CONSTRAINT PK_Contacto_Personas
    PRIMARY KEY(Victima, Asociado, Contacto_Fisico, Fecha_Inicio, Fecha_Fin),
    
    CONSTRAINT FK1_Contacto_Personas
    FOREIGN KEY (Victima)
    REFERENCES Victima(Id_Victima)
    ON DELETE CASCADE,
    
    CONSTRAINT FK2_Contacto_Personas
    FOREIGN KEY (Asociado)
    REFERENCES Asociado(Id_Asociado)
    ON DELETE CASCADE,
    
    CONSTRAINT FK3_Contacto_Personas
    FOREIGN KEY (Contacto_Fisico)
    REFERENCES Contacto_Fisico(Id_Contacto)
    ON DELETE CASCADE
);

CREATE TABLE Ubicacion(
    Victima INTEGER NOT NULL,
    Direccion VARCHAR2(50) NOT NULL,
    Fecha_Llegada DATE NOT NULL,
    Fecha_Retiro DATE NOT NULL,
    
    CONSTRAINT PK_Ubicacion
    PRIMARY KEY(Victima, Direccion, Fecha_Llegada, Fecha_Retiro),
    
    CONSTRAINT FK1_Ubicacion
    FOREIGN KEY (Victima)
    REFERENCES Victima(Id_Victima)
    ON DELETE CASCADE
);

CREATE TABLE Tratamiento_Persona(
    Victima INTEGER NOT NULL,
    Tratamiento INTEGER NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    Efectividad_Victima INTEGER NOT NULL,
    
    CONSTRAINT PK_Tratamiento_Persona
    PRIMARY KEY(Victima, Tratamiento, Fecha_Inicio, Fecha_Fin, Efectividad_Victima)
);


CREATE TABLE Registro(
    Nombre_Victima VARCHAR2(150),
    Apellido_Victima VARCHAR2(150),
    Direccion_Victima VARCHAR2(150),
    Fecha_Primera_Sospecha TIMESTAMP,
    Fecha_Confirmacion TIMESTAMP,
    Fecha_Muerte TIMESTAMP,
    Estado_Victima VARCHAR2(150) NULL,
    Nombre_Asociado VARCHAR2(150) NULL,
    Apellido_Asociado VARCHAR2(150) NULL,
    Fecha_Conocio TIMESTAMP ,
    Contacto_Fisico VARCHAR2(150) NULL,
    Fecha_Inicio_Contacto TIMESTAMP,
    Fecha_Fin_Contacto TIMESTAMP,
    Nombre_Hospital VARCHAR2(150) NULL,
    Direccion_Hospital VARCHAR2(150) NULL,
    Ubicacion_Victima VARCHAR2(150) NULL,
    Fecha_Llegada TIMESTAMP,
    Fecha_Retiro TIMESTAMP,
    Tratamiento VARCHAR2(150) NULL,
    Efectividad INTEGER,
    Fecha_Inicio_Tratamiento TIMESTAMP,
    Fecha_Fin_Tratamiento TIMESTAMP,
    Efectividad_En_Victima INTEGER
);

SELECT * FROM REGISTRO; 

alter session set "_ORACLE_SCRIPT"=true;

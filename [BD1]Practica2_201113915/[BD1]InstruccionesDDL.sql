-- ======================================================================================
-- Eliminando Tablas
-- ======================================================================================
DROP TABLE Tratamiento CASCADE CONSTRAINTS;
DROP TABLE Hospital CASCADE CONSTRAINTS;
DROP TABLE Estado CASCADE CONSTRAINTS;
DROP TABLE Contacto_Fisico CASCADE CONSTRAINTS;
DROP TABLE Victima CASCADE CONSTRAINTS;
DROP TABLE Hospital_Persona CASCADE CONSTRAINTS;
DROP TABLE Asociado CASCADE CONSTRAINTS;
DROP TABLE Conocimiento CASCADE CONSTRAINTS;
DROP TABLE Contacto_Personas CASCADE CONSTRAINTS;
DROP TABLE Ubicacion CASCADE CONSTRAINTS;
DROP TABLE Tratamiento_Persona CASCADE CONSTRAINTS;
DROP TABLE Registro CASCADE CONSTRAINTS;
-- ======================================================================================
-- Creando Tabla Tratamiento
-- ======================================================================================
CREATE TABLE Tratamiento(
    Id_Tratamiento  INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    Tratamiento     VARCHAR2(50)    NOT NULL,
    Efectividad     INTEGER         NOT NULL
);

ALTER TABLE Tratamiento 
    ADD CONSTRAINT PK_Tratamiento
        PRIMARY KEY(Id_Tratamiento);

ALTER TABLE Tratamiento
    ADD CHECK (Efectividad BETWEEN 0 AND 10);
-- ======================================================================================
-- Creando Tabla Hospital
-- ======================================================================================
CREATE TABLE Hospital(
    Id_Hospital INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    Nombre      VARCHAR2(50) NOT NULL,
    Direccion   VARCHAR2(50) NOT NULL
);

ALTER TABLE Hospital
    ADD CONSTRAINT PK_Hospital
        PRIMARY KEY(Id_Hospital);
-- ======================================================================================
-- Creando Tabla Estado
-- ======================================================================================
CREATE TABLE Estado(
    Id_Estado INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    Estado VARCHAR2(50) NOT NULL
);

ALTER TABLE Estado
    ADD CONSTRAINT PK_Estado
        PRIMARY KEY(Id_Estado);
-- ======================================================================================
-- Creando Tabla Contacto_Fisico
-- ======================================================================================
CREATE TABLE Contacto_Fisico(
    Id_Contacto     INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    Contacto_Fisico VARCHAR2(50) NOT NULL
);

ALTER TABLE Contacto_Fisico
    ADD CONSTRAINT PK_Contacto_Fisico
        PRIMARY KEY(Id_Contacto);
-- ======================================================================================
-- Creando Tabla Victima
-- ======================================================================================
CREATE TABLE Victima(
    Id_Victima              INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    Nombre                  VARCHAR2(50)    NOT NULL,
    Apellido                VARCHAR2(50)    NOT NULL,
    Direccion               VARCHAR2(50)    NOT NULL,
    Fecha_Primera_Sospecha  TIMESTAMP       NOT NULL,
    Fecha_Confirmacion      TIMESTAMP       NOT NULL,
    Fecha_Muerte            TIMESTAMP,
    Estado                  INTEGER         NOT NULL
);

ALTER TABLE Victima
    ADD CONSTRAINT PK_Victima
        PRIMARY KEY(Id_Victima);

ALTER TABLE Victima
    ADD CONSTRAINT FK1_Victima
        FOREIGN KEY (Estado)
            REFERENCES Estado(Id_Estado) ON DELETE CASCADE;
-- ======================================================================================
-- Creando Tabla HOSPITAL_PERSONA
-- ======================================================================================
CREATE TABLE Hospital_Persona(
    Victima     INTEGER NOT NULL,
    Hospital    INTEGER NOT NULL
);

ALTER TABLE Hospital_Persona
    ADD CONSTRAINT PK_Hospital_Persona
        PRIMARY KEY(Victima, Hospital);

ALTER TABLE Hospital_Persona
    ADD CONSTRAINT FK1_Hospital_Persona
        FOREIGN KEY (Victima)
            REFERENCES Victima(Id_Victima) ON DELETE CASCADE;
            
ALTER TABLE Hospital_Persona
    ADD CONSTRAINT FK2_Hospital_Persona
        FOREIGN KEY (Hospital)
            REFERENCES Hospital(Id_Hospital) ON DELETE CASCADE;
-- ======================================================================================
-- Creando Tabla Asociado
-- ======================================================================================
CREATE TABLE Asociado(
    Id_Asociado INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    Nombre      VARCHAR2(50) NOT NULL,
    Apellido    VARCHAR2(50) NOT NULL
);

ALTER TABLE Asociado
    ADD CONSTRAINT PK_Asociado
        PRIMARY KEY(Id_Asociado);
-- ======================================================================================
-- Creando Tabla Conocimiento
-- ======================================================================================
CREATE TABLE Conocimiento(
    Victima         INTEGER     NOT NULL,
    Asociado        INTEGER     NOT NULL,
    Fecha_Conocio   TIMESTAMP   NOT NULL
);

ALTER TABLE Conocimiento
    ADD CONSTRAINT PK_Conocimiento
        PRIMARY KEY(Victima, Asociado, Fecha_Conocio);
    
ALTER TABLE Conocimiento
    ADD CONSTRAINT FK1_Conocsimiento
        FOREIGN KEY (Victima)
            REFERENCES Victima(Id_Victima) ON DELETE CASCADE;
    
ALTER TABLE Conocimiento
    ADD CONSTRAINT FK2_Conocimiento
        FOREIGN KEY (Asociado)
            REFERENCES Asociado(Id_Asociado) ON DELETE CASCADE;
-- ======================================================================================
-- Creando Tabla Contacto_Personas
-- ======================================================================================
CREATE TABLE Contacto_Personas(
    Victima         INTEGER     NOT NULL,
    Asociado        INTEGER     NOT NULL,
    Contacto_Fisico INTEGER     NOT NULL,
    Fecha_Inicio    TIMESTAMP   NOT NULL,
    Fecha_Fin       TIMESTAMP   NOT NULL
);

ALTER TABLE Contacto_Personas
    ADD CONSTRAINT PK_Contacto_Personas
    PRIMARY KEY(Victima, Asociado, Contacto_Fisico, Fecha_Inicio, Fecha_Fin);

ALTER TABLE Contacto_Personas
    ADD CONSTRAINT FK1_Contacto_Personas
        FOREIGN KEY (Victima)
            REFERENCES Victima(Id_Victima) ON DELETE CASCADE;

ALTER TABLE Contacto_Personas
    ADD CONSTRAINT FK2_Contacto_Personas
        FOREIGN KEY (Asociado)
            REFERENCES Asociado(Id_Asociado) ON DELETE CASCADE;
    
ALTER TABLE Contacto_Personas
    ADD CONSTRAINT FK3_Contacto_Personas
        FOREIGN KEY (Contacto_Fisico)
            REFERENCES Contacto_Fisico(Id_Contacto) ON DELETE CASCADE;
-- ======================================================================================
-- Creando Tabla Ubicacion
-- ======================================================================================
CREATE TABLE Ubicacion(
    Victima         INTEGER         NOT NULL,
    Direccion       VARCHAR2(50)    NOT NULL,
    Fecha_Llegada   TIMESTAMP       NOT NULL,
    Fecha_Retiro    TIMESTAMP       NOT NULL
);

ALTER TABLE Ubicacion
    ADD CONSTRAINT PK_Ubicacion
        PRIMARY KEY(Victima, Direccion, Fecha_Llegada, Fecha_Retiro);

ALTER TABLE Ubicacion
    ADD CONSTRAINT FK1_Ubicacion
        FOREIGN KEY (Victima)
            REFERENCES Victima(Id_Victima) ON DELETE CASCADE;
-- ======================================================================================
-- Creando Tabla Tratamiento_Persona
-- ======================================================================================
CREATE TABLE Tratamiento_Persona(
    Victima             INTEGER     NOT NULL,
    Tratamiento         INTEGER     NOT NULL,
    Fecha_Inicio        TIMESTAMP   NOT NULL,
    Fecha_Fin           TIMESTAMP   NOT NULL,
    Efectividad_Victima INTEGER     NOT NULL
);

ALTER TABLE Tratamiento_Persona
    ADD CONSTRAINT PK_Tratamiento_Persona
        PRIMARY KEY(Victima, Tratamiento, Fecha_Inicio, Fecha_Fin);

ALTER TABLE Tratamiento_Persona
    ADD CONSTRAINT FK1_Tratamiento_Persona
    FOREIGN KEY (Victima)
    REFERENCES Victima(Id_Victima) ON DELETE CASCADE;
    
ALTER TABLE Tratamiento_Persona
    ADD CONSTRAINT FK2_Tratamiento_Persona
        FOREIGN KEY (Tratamiento)
            REFERENCES Tratamiento(Id_Tratamiento) ON DELETE CASCADE;

ALTER TABLE Tratamiento_Persona
    ADD CHECK (Efectividad_Victima BETWEEN 0 AND 10);
-- ======================================================================================
-- Creando Tabla Registro
-- ======================================================================================
CREATE TABLE Registro(
    Nombre_Victima              VARCHAR2(150),
    Apellido_Victima            VARCHAR2(150),
    Direccion_Victima           VARCHAR2(150),
    Fecha_Primera_Sospecha      TIMESTAMP,
    Fecha_Confirmacion          TIMESTAMP,
    Fecha_Muerte                TIMESTAMP,
    Estado_Victima              VARCHAR2(150),
    Nombre_Asociado             VARCHAR2(150),
    Apellido_Asociado           VARCHAR2(150),
    Fecha_Conocio               TIMESTAMP ,
    Contacto_Fisico             VARCHAR2(150),
    Fecha_Inicio_Contacto       TIMESTAMP,
    Fecha_Fin_Contacto          TIMESTAMP,
    Nombre_Hospital             VARCHAR2(150),
    Direccion_Hospital          VARCHAR2(150),
    Ubicacion_Victima           VARCHAR2(150),
    Fecha_Llegada               TIMESTAMP,
    Fecha_Retiro                TIMESTAMP,
    Tratamiento                 VARCHAR2(150),
    Efectividad                 INTEGER,
    Fecha_Inicio_Tratamiento    TIMESTAMP,
    Fecha_Fin_Tratamiento       TIMESTAMP,
    Efectividad_En_Victima      INTEGER
);
-- ======================================================================================
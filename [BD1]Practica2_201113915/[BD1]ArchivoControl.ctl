OPTIONS (SKIP=1)
    LOAD DATA
    CHARACTERSET UTF8
    INFILE 'Entrada/GRAND_VIRUS_EPICENTER.csv'
    INTO TABLE C##PRACTICA2BD2.REGISTRO TRUNCATE
    FIELDS TERMINATED BY ";"
    TRAILING NULLCOLS(
        NOMBRE_VICTIMA,
        APELLIDO_VICTIMA,
        DIRECCION_VICTIMA,
        FECHA_PRIMERA_SOSPECHA TIMESTAMP 'YYYY-MM-DD HH24:MI:SS.FF',
        FECHA_CONFIRMACION TIMESTAMP 'YYYY-MM-DD HH24:MI:SS.FF',
        FECHA_MUERTE TIMESTAMP 'YYYY-MM-DD HH24:MI:SS.FF',
        ESTADO_VICTIMA,
        NOMBRE_ASOCIADO,
        APELLIDO_ASOCIADO,
        FECHA_CONOCIO TIMESTAMP 'YYYY-MM-DD HH24:MI:SS.FF',
        CONTACTO_FISICO,
        FECHA_INICIO_CONTACTO TIMESTAMP 'YYYY-MM-DD HH24:MI:SS.FF',
        FECHA_FIN_CONTACTO TIMESTAMP 'YYYY-MM-DD HH24:MI:SS.FF',
        NOMBRE_HOSPITAL,
        DIRECCION_HOSPITAL,
        UBICACION_VICTIMA,
        FECHA_LLEGADA TIMESTAMP 'YYYY-MM-DD HH24:MI:SS.FF',
        FECHA_RETIRO TIMESTAMP 'YYYY-MM-DD HH24:MI:SS.FF',
        TRATAMIENTO,
        EFECTIVIDAD,
        FECHA_INICIO_TRATAMIENTO TIMESTAMP 'YYYY-MM-DD HH24:MI:SS.FF',
        FECHA_FIN_TRATAMIENTO TIMESTAMP 'YYYY-MM-DD HH24:MI:SS.FF',
        EFECTIVIDAD_EN_VICTIMA
    )
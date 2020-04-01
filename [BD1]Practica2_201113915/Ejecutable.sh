# ACTIVANDO SQLPLUS
export ORACLE_SID=XE 
export ORAENV_ASK=NO 
. /opt/oracle/product/18c/dbhomeXE/bin/oraenv

# CREANDO LA BASE DE DATOS
echo exit | sqlplus -S C##PRACTICA2BD2/107990@//localhost:1521/XEPDB1 @[BD1]InstruccionesDDL.sql
echo " "
echo -e "\e[92m SE HAN CREADO LAS TABLAS EXITOSAMENTE. ENTER PARA CONTINUAR ... \e[0m"
read

# CARGANDO LOS ARCHIVOS
export ORACLE_SID=XE 
export ORAENV_ASK=NO 
. /opt/oracle/product/18c/dbhomeXE/bin/oraenv

sqlldr userid= C##PRACTICA2BD2/107990@//localhost:1521/XEPDB1 control=[BD1]ArchivoControl.ctl log=log/[BD1]ArchivoControl.log bad=bad/[BD1]ArchivoControl.bad
echo " "
echo -e "\e[96m SE HA LLENADO LA TABLA TEMPORAL EXITOSAMENTE. ENTER PARA CONTINUAR ... \e[0m"
read 


# LLENANDO LA BASE DE DATOS
echo exit | sqlplus -S C##PRACTICA2BD2/107990@//localhost:1521/XEPDB1 @[BD1]CargaDeDatos.sql
echo " "
echo -e "\e[96m SE HA LLENADO LA BASE DE DATOS CORRECTAMENTE!. ENTER PARA CONTINUAR ... \e[0m"
read

# REALIZANDO LAS CONSULTAS
# echo exit | sqlplus -S C##PRACTICA2BD2/107990@//localhost:1521/XEPDB1 @[BD1]Consultas.sql
# echo " "
# echo -e "\e[92m YA SE HAN REALIZADO TODAS LAS CONSULTAS. ENTER PARA CONTINUAR ... \e[0m"
#read
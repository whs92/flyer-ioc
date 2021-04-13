#!../../bin/linux-x86_64/EMIL_PZI_00

#- You may have to change EMIL_PZI_00 to something else
#- everywhere it appears in this file

< envPaths

epicsEnvSet("SYS", "EMILEL")

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/EMIL_PZI_00.dbd"
EMIL_PZI_00_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadTemplate "db/user.substitutions"
#dbLoadRecords "db/EMIL_PZI_00Version.db", "user=emil"
#dbLoadRecords "db/dbSubExample.db", "user=emil"
dbLoadRecords "db/singleAxis.db", "P=$(SYS), A=axis1, S=sensor1"

#- Set this to see messages from mySub
#var mySubDebug 1

#- Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=emil"

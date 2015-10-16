#!/bin/bash

for wind in E1-geo0 E1-geo1 E1-geo2 E1-geo3 E1-geo4 E1-geo5 E1-geo6 E1-geo7a E1-geo7b E1-geo7c E1-geo8 E1-geo9 E1-geo10; do
            
#for wind in E1-geo0 ; do
win=${wind}

for climate in Burbank Chicago Houston Oakland; do
#for climate in Burbank Houston Oakland; do
clim=$climate
	
for ww in wwr15 wwr30 wwr45 wwr60 ;  do
wwr=$ww

for control in DC NDC; do
DLC=$control

run=${wind%%.idf}_${clim}_${wwr}_${DLC}
runname=${run}

cp ./${run}/disag.txt ./disag/${runname}.txt
cp ./${run}/eplusout.csv ./eplusout/${runname}.csv


done
done
done
done
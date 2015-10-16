#!/bin/bash

#for wind in E1-geo7c E1-geo8 E1-geo9; do
            
for wind in E1-geo0 ; do            
            

for climate in Burbank Chicago Houston Oakland; do
clim=$climate
	
for ww in wwr15 wwr30 wwr45 wwr60 ;  do
wwr=$ww

for control in DC NDC; do
DLC=$control



mv ${wind%%.idf}_${clim}_${wwr}_${DLC}_ctIs1 ${wind%%.idf}_${clim}_${wwr}_${DLC}


done
done
done
done
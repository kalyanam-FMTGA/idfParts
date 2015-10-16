#!/bin/bash

cd ..


for wind in `ls WinPropertyAll` ; do
win=${wind}

for climate in `ls /scratch/UG/FMTGA/extshd/idfparts/ClimateRelatedAll` ; do
clim=${climate}
	
for ww in `ls /scratch/UG/FMTGA/extshd/idfparts/WWRAll` ;  do
wwr=${ww}

for control in DC NDC; do
DLC=$control

for shd in ctIs1 ctIs2 ctrl1 ctrl2 ctrl3 ; do
shade=$shd

run=${wind%%.idf}_${climate%%.idf}_${ww%%.idf}_${DLC}_${shade}

cd ./Shade

	if [ -s ./$run.csv ] ; then 
	cp ${wind%%.idf}_${climate%%.idf}_${ww%%.idf}_DC_${shade}.csv ${wind%%.idf}_${climate%%.idf}_${ww%%.idf}_NDC_${shade}.csv
	fi

cd ..

done
done
done
done
done

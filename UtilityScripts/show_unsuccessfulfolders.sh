#!/bin/bash


runs_name=$1

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

if [ -d /scratch/UG/FMTGA/extshd/idfparts/runs/${runs_name}/${run} ] ; then

cd /scratch/UG/FMTGA/extshd/idfparts/runs/${runs_name}/${run}

	if [ -s ./eplusout.csv ] ; then 

    		FILESIZE=$(stat -c%s "./eplusout.csv")

        	if [ $FILESIZE -lt 10000000 ] ;then
        	echo "${run}/eplusout.csv is too small = $FILESIZE bytes."
		
       		fi
	fi


	if [ ! -s ./eplusout.csv ] ; then
		echo "${run}/eplusout.csv is 0 bytes." 
	fi
fi

cd ..

done
done
done
done
done

	



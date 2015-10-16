
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

if [ -d /scratch/UG/FMTGA/extshd/idfparts/Runs/${runs_name}/${run} ] ; then

cd /scratch/UG/FMTGA/extshd/idfparts/Runs/${runs_name}/${run}

	if [ ! -s ./eplustbl.csv ] ; then    		
        	echo "No eplustbl.csv for ${run}"	      		
	fi


	one=${run}

	two=`head -n 168 eplustbl.csv | tail -2 | \
	awk 'BEGIN { FS = "," }{printf("%0.0f\\\t",$3)}'`

	echo -n -e "${one}   \t${two}\n">> /scratch/UG/FMTGA/extshd/idfparts/Runs/UnmetHours_${1}.txt

fi
	
cd ../../


done
done
done
done
done

	



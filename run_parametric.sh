#!/bin/bash

if [ ! -e runs/ ] ; then mkdir runs ; fi

for wind in `ls WinProperty` ; do
win=${wind}




for climate in Burbank Chicago Houston Oakland; do

	if [ $climate == 'Burbank' ] ; then weather=CZ09RV2.epw
	elif [ $climate == 'Chicago' ] ; then weather=USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw
	elif [ $climate == 'Houston' ] ; then weather=USA_TX_Houston-Bush.Intercontinental.AP.722430_TMY3.epw
	elif  [ $climate == 'Oakland' ] ; then weather=CZ03RV2.epw
	fi

for ww in `ls WWR` ;  do
wwr=${ww:0:5}

for control in DC NDC; do
DLC=$control

#for shade in `ls Shade` ;  do
#shade=${shd:0:9}

run=${wind%%.idf}_${climate}_${wwr}_${DLC}
mkdir runs/$run


	
###############################	



smname=${wind%%.idf}_${climate}_${wwr}_${DLC}
	


if [ "${ww:0:5}" == 'wwr00' ] ; then
echo Running without daylight control



	cat ClimateRelated/${climate}.idf \
		General/template.idf \
		WinProperty/${win} \
		WWR/${wwr}.idf \
		DLC/LightAndSolRadSched_generic.idf \
		> ./in.idf
	sed -e 's/++LPDSCHEDFILE++/'NDC'/g' \
                -e 's/++SURFSCHED++/'wwr00'/g' \
                -e 's/++ABSSched++/'wwr00'/g' in.idf > runs/${run}/in.idf

elif [ "$control" == 'DC' ]
then
	
echo Running with daylight control
	
	cat ClimateRelated/${climate}.idf \
		General/template.idf \
		WinProperty/${win} \
		WWR/${wwr}.idf \
		DLC/LightAndSolRadSched_generic.idf \
		> ./in.idf
	sed -e 's/++LPDSCHEDFILE++/'${smname}'/g' \
		-e 's/++SURFSCHED++/'${smname}'/g' \
		-e 's/++ABSSched++/'${smname}'/g' in.idf > runs/${run}/in.idf
		
		
else
	
echo Running without daylight control
	
	cat ClimateRelated/${climate}.idf \
		General/template.idf \
		WinProperty/${win} \
		WWR/${wwr}.idf \
		DLC/LightAndSolRadSched_generic.idf \
		> ./in.idf
	sed -e 's/++LPDSCHEDFILE++/'NDC'/g' \
		-e 's/++SURFSCHED++/'${smname}'/g' \
		-e 's/++ABSSched++/'${smname}'/g' in.idf > runs/${run}/in.idf
fi	
	
###############################


cp rvi/fileName.rvi runs/${run}/in.rvi
cp /software/users/FMTGA/eplus/EnergyPlus/WeatherData/${weather} runs/${run}/in.epw
cp /software/users/FMTGA/eplus/EnergyPlus/bin/Energy+.idd runs/${run}/.
cd runs/${run}

export PATH=$PATH:/software/users/FMTGA/eplus/EnergyPlus/bin
energyplus
readvars in.rvi

dat=`tail -n 53 eplustbl.csv | head -3 | \
	awk 'BEGIN { FS = "," }{printf("%e\\\t",$3/(9.4782e-7))}'`

awk -F, -f ../../disagregate.awk eplusout.csv > disag.txt
echo -n -e "${run}\t">> ../../Summary.txt
total disag.txt >> ../../Summary.txt

total disag.txt |\
	awk '{for(i=0;i<8;i++){printf("%e\t%e\t%e\t%e\t%e\n",$(i*5+1),$(i*5+2),$(i*5+3),$(i*5+4),$(i*5+5))}\
			printf("%e\t%e\t%e\t%e\t%e\t'${dat}'\n",$41,$42,$43,$44,$45)}' |\
	awk 'BEGIN{ gas=9.4782e-7; elec=2.77778e-7;\
		 printf("Heating Gas\tHeating Elec\tColling\t\tFan\t\tLighting\tOther Gas\tOther Elec")}\
		 {if(NR<9) printf("\n%e\t%e\t%e\t%e\t%e",$1*gas,$2*elec,$3*elec,$4*elec,$5*elec) ;\
		 else printf("\t%e\t%e\n",($1)*gas,($3+$4+$5+$6+$7+$8)*elec) }' > table.txt
		 
cd ../../



done
done
done
done
done




#!/bin/bash

cd ..

if [ ! -e runs/ ] ; then mkdir runs ; fi

for wind in `ls WinProperty` ; do
win=${wind}




for climate in Burbank ; do

	if [ $climate == 'Burbank' ] ; then weather=CZ09RV2.epw
	elif [ $climate == 'BurbTDV' ] ; then weather=CZ09RV2.epw
	elif [ $climate == 'Chicago' ] ; then weather=USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw
	elif [ $climate == 'Houston' ] ; then weather=USA_TX_Houston-Bush.Intercontinental.AP.722430_TMY3.epw
	elif  [ $climate == 'Oakland' ] ; then weather=CZ03RV2.epw
	elif  [ $climate == 'OaklTDV' ] ; then weather=CZ03RV2.epw
	fi

for ww in wwr15 wwr30 wwr45 wwr60;  do
wwr=${ww:0:5}

for control in DC NDC; do
#for control in DC ; do
DLC=$control

for shd in `ls Shade` ;  do
shde=${shd%%.csv}
shade=${shde##*_}


run=${wind%%.idf}_${climate}_${wwr}_${DLC}_${shade}

			
		if [ ${shde} == 'ctIs2' ]; then
			mkdir runs/$run	
		else
		continue	
		fi		
	


#	if [ ${run} == ${shde} ]; then
#			mkdir runs/$run
			
#	elif [ ${shde} == 'ctIs1' ]; then
#			mkdir runs/$run	
			
#	elif [ ${shde} == 'ctIs2' ]; then
#			mkdir runs/$run	
		
		
###############################	

if [ -e runs/$run ] ; then 

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
		-e 's/++ABSSched++/'wwr00'/g' \
		-e 's/++INTSHDLPDSCHEDFILE++/'NDC'/g' \
		-e 's/++INTSHDABSSched++/'wwr00'/g' \
		-e 's/++INTSHDSURFSCHED++/'wwr00'/g' \
		-e 's/++CTLSCHEDFILE++/'ctIs1'/g' in.idf > runs/${run}/in.idf            

	elif [ "$control" == 'DC' ]
	then
	
	echo Running with daylight control
	
		cat ClimateRelated/${climate}.idf \
			General/template.idf \
			WinProperty/${win} \
			WWR/${wwr}.idf \
			DLC/LightAndSolRadSched_generic.idf \
			> ./in.idf
			
			if [ ${shde} == 'ctIs1' ]; then

				sed -e 's/++LPDSCHEDFILE++/'${smname}'/g' \
				-e 's/++SURFSCHED++/'${smname}'/g' \
				-e 's/++ABSSched++/'${smname}'/g' \
				-e 's/++INTSHDLPDSCHEDFILE++/''E2-'${smname##*-}'/g' \
				-e 's/++INTSHDABSSched++/''E2-'${smname##*-}'/g' \
				-e 's/++INTSHDSURFSCHED++/''E2-'${smname##*-}'/g' \
				-e 's/++CTLSCHEDFILE++/'ctIs1'/g' in.idf > runs/${run}/in.idf		
						
			elif [ ${shde} == 'ctIs2' ]; then
			
				sed -e 's/++LPDSCHEDFILE++/'${smname}'/g' \
				-e 's/++SURFSCHED++/'${smname}'/g' \
				-e 's/++ABSSched++/'${smname}'/g' \
				-e 's/++INTSHDLPDSCHEDFILE++/''E2-'${smname##*-}'/g' \
				-e 's/++INTSHDABSSched++/''E2-'${smname##*-}'/g' \
				-e 's/++INTSHDSURFSCHED++/''E2-'${smname##*-}'/g' \
				-e 's/++CTLSCHEDFILE++/'ctIs2'/g' in.idf > runs/${run}/in.idf			
						
			else
			
				sed -e 's/++LPDSCHEDFILE++/'${smname}'/g' \
				-e 's/++SURFSCHED++/'${smname}'/g' \
				-e 's/++ABSSched++/'${smname}'/g' \
				-e 's/++INTSHDLPDSCHEDFILE++/''E2-'${smname##*-}'/g' \
				-e 's/++INTSHDABSSched++/''E2-'${smname##*-}'/g' \
				-e 's/++INTSHDSURFSCHED++/''E2-'${smname##*-}'/g' \
				-e 's/++CTLSCHEDFILE++/'${smname}_${shade}'/g' in.idf > runs/${run}/in.idf
						
			fi
			
			
	else
	
	echo Running without daylight control
	
	cat ClimateRelated/${climate}.idf \
		General/template.idf \
		WinProperty/${win} \
		WWR/${wwr}.idf \
		DLC/LightAndSolRadSched_generic.idf \
		> ./in.idf
		
	smname=${wind%%.idf}_${climate}_${wwr}_DC
				
			if [ ${shde} == 'ctIs1' ]; then

				sed -e 's/++LPDSCHEDFILE++/'NDC'/g' \
				-e 's/++SURFSCHED++/'${smname}'/g' \
				-e 's/++ABSSched++/'${smname}'/g' \
				-e 's/++INTSHDLPDSCHEDFILE++/'NDC'/g' \
				-e 's/++INTSHDABSSched++/''E2-'${smname##*-}'/g' \
				-e 's/++INTSHDSURFSCHED++/''E2-'${smname##*-}'/g' \
				-e 's/++CTLSCHEDFILE++/'ctIs1'/g' in.idf > runs/${run}/in.idf		
						
			elif [ ${shde} == 'ctIs2' ]; then
			
				sed -e 's/++LPDSCHEDFILE++/'NDC'/g' \
				-e 's/++SURFSCHED++/'${smname}'/g' \
				-e 's/++ABSSched++/'${smname}'/g' \
				-e 's/++INTSHDLPDSCHEDFILE++/'NDC'/g' \
				-e 's/++INTSHDABSSched++/''E2-'${smname##*-}'/g' \
				-e 's/++INTSHDSURFSCHED++/''E2-'${smname##*-}'/g' \
				-e 's/++CTLSCHEDFILE++/'ctIs2'/g' in.idf > runs/${run}/in.idf			
					
			else
			
				sed -e 's/++LPDSCHEDFILE++/'NDC'/g' \
				-e 's/++SURFSCHED++/'${smname}'/g' \
				-e 's/++ABSSched++/'${smname}'/g' \
				-e 's/++INTSHDLPDSCHEDFILE++/'NDC'/g' \
				-e 's/++INTSHDABSSched++/''E2-'${smname##*-}'/g' \
				-e 's/++INTSHDSURFSCHED++/''E2-'${smname##*-}'/g' \
				-e 's/++CTLSCHEDFILE++/'${smname}_${shade}'/g' in.idf > runs/${run}/in.idf
			
			fi
	
		fi
###############################


	cp rvi/fileName.rvi runs/${run}/in.rvi
	cp /software/users/FMTGA/eplus/EnergyPlus/WeatherData/${weather} runs/${run}/in.epw
	cp /software/users/FMTGA/eplus/EnergyPlus/Energy+.idd runs/${run}/.
	cd runs/${run}

	export PATH=$PATH:/software/users/FMTGA/eplus/EnergyPlus
	export EP_OMP_NUM_THREADS=1

	if [ ! -s ./eplusout.csv ] ; then 

	#runenergyplus
	EnergyPlus	
	runreadvars in.rvi

	fi 



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

else
continue
fi

done
done
done
done
done





#!/bin/bash



awk -F, -f disagregate.awk eplusout.csv > disag.txt
#echo -n -e "${run}\t">> ../../Summary.txt
#total disag.txt >> ../../Summary.txt

total disag.txt |\
	awk '{for(i=0;i<8;i++){printf("%e\t%e\t%e\t%e\t%e\n",$(i*5+1),$(i*5+2),$(i*5+3),$(i*5+4),$(i*5+5))}\
			printf("%e\t%e\t%e\t%e\t%e\n",$41,$42,$43,$44,$45)}' |\
	awk 'BEGIN{ gas=9.4782e-7; elec=2.77778e-7;\
		 printf("Heating Gas\tHeating Elec\tColling\t\tFan\t\tLighting\tOther Gas\tOther Elec")}\
		 {printf("\n%e\t%e\t%e\t%e\t%e",$1*gas,$2*elec,$3*elec,$4*elec,$5*elec)}' > table.txt
				 

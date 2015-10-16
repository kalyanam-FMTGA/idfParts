#!/usr/bin/awk -F, -f
# disagregating the energy use by zone
# mapping variables to column numbers at the end


BEGIN{OFMT="%.9e"}

{
if(NR>1){
gastot=$67
Elechwp=$68
QB=$66
QHP=$69
QHC1=$29
QHC2=$30
QHC3=$31
QHC5=$32
QCC3=$58
QCC2=$59
QCC1=$60
QCC5=$61
SQCC=QCC1+QCC2+QCC3+QCC5
CFM1=$98
CFM2=$99
CFM3=$100
CFM5=$101*1
SCFM=CFM1+CFM2+CFM3+CFM5
Cooling=$27+$28+$70+$71+$72+$73
Fan1=$62
Fan2=$63
Fan3=$64
Fan5=$65
#QTR, CFM, CFMX, gas, QB, QHP, QHCx
#(QTR+CFM/CFMX*QHCx)*gas/(QB+QHP)

#if((QB+QHP)==0)	gassouthext=0.0
#else  {
#	if(CFM1==0) gas1=0
#	else gas1=($42+$82/CFM1*QHC1)*gastot/(QB+QHP)
#	if(CFM2==0) gas2=0
#	else gas2=($34+$74/CFM2*QHC2)*gastot/(QB+QHP)
#	if(CFM3==0) gas3=0
#	else gas3=($38+$78/CFM3*QHC3)*gastot/(QB+QHP)
#gassouthext=6*(gas1+gas2+gas3)
#	print gas1,heatzone($42, $82, CFM1, gastot, QB, QHP, QHC1 ),gas2,heatzone($34, $74, CFM2, gastot, QB, QHP, QHC2 ),gas3,heatzone($38, $78, CFM3, gastot, QB, QHP, QHC3 )
#}

gassouthext=6*(heatzone($34, $74, CFM2, gastot, QB, QHP, QHC2 ) +\
			   heatzone($38, $78, CFM3, gastot, QB, QHP, QHC3 ) +\
			   heatzone($42, $82, CFM1, gastot, QB, QHP, QHC1 ))
	
gassouthcore=6*(heatzone($46, $86, CFM2, gastot, QB, QHP, QHC2 ) +\
			    heatzone($50, $90, CFM3, gastot, QB, QHP, QHC3 ) +\
			    heatzone($54, $94, CFM1, gastot, QB, QHP, QHC1 ))

gasnorthext=6*(heatzone($35, $75, CFM2, gastot, QB, QHP, QHC2 ) +\
			   heatzone($39, $79, CFM3, gastot, QB, QHP, QHC3 ) +\
			   heatzone($43, $83, CFM1, gastot, QB, QHP, QHC1 ))
	
gasnorthcore=6*(heatzone($47, $87, CFM2, gastot, QB, QHP, QHC2 ) +\
			    heatzone($51, $91, CFM3, gastot, QB, QHP, QHC3 ) +\
			    heatzone($55, $95, CFM1, gastot, QB, QHP, QHC1 ))

gaswestext=4*(heatzone($36, $76, CFM2, gastot, QB, QHP, QHC2 ) +\
			   heatzone($40, $80, CFM3, gastot, QB, QHP, QHC3 ) +\
			   heatzone($44, $84, CFM1, gastot, QB, QHP, QHC1 ))
			   
gaswestcore=4*(heatzone($48, $88, CFM2, gastot, QB, QHP, QHC2 ) +\
			   heatzone($52, $92, CFM3, gastot, QB, QHP, QHC3 ) +\
			   heatzone($56, $96, CFM1, gastot, QB, QHP, QHC1 ))		   
			   
gaseastext=4*(heatzone($37, $77, CFM2, gastot, QB, QHP, QHC2 ) +\
			   heatzone($41, $81, CFM3, gastot, QB, QHP, QHC3 ) +\
			   heatzone($45, $85, CFM1, gastot, QB, QHP, QHC1 ))
			   
gaseastcore=4*(heatzone($49, $89, CFM2, gastot, QB, QHP, QHC2 ) +\
			   heatzone($53, $93, CFM3, gastot, QB, QHP, QHC3 ) +\
			   heatzone($57, $97, CFM1, gastot, QB, QHP, QHC1 ))	
			   
gasbasement=heatzone(4*$33, CFM5, CFM5, gastot, QB, QHP, QHC5 )
			   
	
heatsouthext=6*(heatzone($34, $74, CFM2, Elechwp, QB, QHP, QHC2 ) +\
			   heatzone($38, $78, CFM3, Elechwp, QB, QHP, QHC3 ) +\
			   heatzone($42, $82, CFM1, Elechwp, QB, QHP, QHC1 ))
	
heatsouthcore=6*(heatzone($46, $86, CFM2, Elechwp, QB, QHP, QHC2 ) +\
			    heatzone($50, $90, CFM3, Elechwp, QB, QHP, QHC3 ) +\
			    heatzone($54, $94, CFM1, Elechwp, QB, QHP, QHC1 ))

heatnorthext=6*(heatzone($35, $75, CFM2, Elechwp, QB, QHP, QHC2 ) +\
			   heatzone($39, $79, CFM3, Elechwp, QB, QHP, QHC3 ) +\
			   heatzone($43, $83, CFM1, Elechwp, QB, QHP, QHC1 ))
	
heatnorthcore=6*(heatzone($47, $87, CFM2, Elechwp, QB, QHP, QHC2 ) +\
			    heatzone($51, $91, CFM3, Elechwp, QB, QHP, QHC3 ) +\
			    heatzone($55, $95, CFM1, Elechwp, QB, QHP, QHC1 ))

heatwestext=4*(heatzone($36, $76, CFM2, Elechwp, QB, QHP, QHC2 ) +\
			   heatzone($40, $80, CFM3, Elechwp, QB, QHP, QHC3 ) +\
			   heatzone($44, $84, CFM1, Elechwp, QB, QHP, QHC1 ))
			   
heatwestcore=4*(heatzone($48, $88, CFM2, Elechwp, QB, QHP, QHC2 ) +\
			   heatzone($52, $92, CFM3, Elechwp, QB, QHP, QHC3 ) +\
			   heatzone($56, $96, CFM1, Elechwp, QB, QHP, QHC1 ))		   
			   
heateastext=4*(heatzone($37, $77, CFM2, Elechwp, QB, QHP, QHC2 ) +\
			   heatzone($41, $81, CFM3, Elechwp, QB, QHP, QHC3 ) +\
			   heatzone($45, $85, CFM1, Elechwp, QB, QHP, QHC1 ))
			   
heateastcore=4*(heatzone($49, $89, CFM2, Elechwp, QB, QHP, QHC2 ) +\
			   heatzone($53, $93, CFM3, Elechwp, QB, QHP, QHC3 ) +\
			   heatzone($57, $97, CFM1, Elechwp, QB, QHP, QHC1 ))	
			   
heatbasement=heatzone(4*$33, CFM5, CFM5, Elechwp, QB, QHP, QHC5 )

coolsouthext=6*(coolzone($74, CFM2, Cooling, QCC2, SQCC ) +\
			   coolzone($78, CFM3, Cooling, QCC3, SQCC ) +\
			   coolzone($82, CFM1, Cooling, QCC1, SQCC ))
	
coolsouthcore=6*(coolzone($86, CFM2, Cooling, QCC2, SQCC ) +\
			    coolzone($90, CFM3, Cooling, QCC3, SQCC ) +\
			    coolzone($94, CFM1, Cooling, QCC1, SQCC ))

coolnorthext=6*(coolzone($75, CFM2, Cooling, QCC2, SQCC ) +\
			   coolzone($79, CFM3, Cooling, QCC3, SQCC ) +\
			   coolzone($83, CFM1, Cooling, QCC1, SQCC ))
	
coolnorthcore=6*(coolzone($87, CFM2, Cooling, QCC2, SQCC ) +\
			    coolzone($91, CFM3, Cooling, QCC3, SQCC ) +\
			    coolzone($95, CFM1, Cooling, QCC1, SQCC ))

coolwestext=4*(coolzone($76, CFM2, Cooling, QCC2, SQCC ) +\
			   coolzone($80, CFM3, Cooling, QCC3, SQCC ) +\
			   coolzone($84, CFM1, Cooling, QCC1, SQCC ))
			   
coolwestcore=4*(coolzone($88, CFM2, Cooling, QCC2, SQCC ) +\
			   coolzone($92, CFM3, Cooling, QCC3, SQCC ) +\
			   coolzone($96, CFM1, Cooling, QCC1, SQCC ))		   
			   
cooleastext=4*(coolzone($77, CFM2, Cooling, QCC2, SQCC ) +\
			   coolzone($81, CFM3, Cooling, QCC3, SQCC ) +\
			   coolzone($85, CFM1, Cooling, QCC1, SQCC ))
			   
cooleastcore=4*(coolzone($89, CFM2, Cooling, QCC2, SQCC ) +\
			   coolzone($93, CFM3, Cooling, QCC3, SQCC ) +\
			   coolzone($97, CFM1, Cooling, QCC1, SQCC ))	

coolbasement=coolzone(CFM5, CFM5, Cooling, QCC5, SQCC )

fansouthext=6*(fanzone(Fan2,$74,CFM2)+\
				fanzone(Fan3,$78,CFM3)+\
				fanzone(Fan1,$82,CFM1))
fansouthcore=6*(fanzone(Fan2,$86,CFM2)+\
				fanzone(Fan3,$90,CFM3)+\
				fanzone(Fan1,$94,CFM1))
fannorthext=6*(fanzone(Fan2,$75,CFM2)+\
				fanzone(Fan3,$79,CFM3)+\
				fanzone(Fan1,$83,CFM1))
fannorthcore=6*(fanzone(Fan2,$87,CFM2)+\
				fanzone(Fan3,$91,CFM3)+\
				fanzone(Fan1,$95,CFM1))
fanwestext=4*(fanzone(Fan2,$76,CFM2)+\
				fanzone(Fan3,$80,CFM3)+\
				fanzone(Fan1,$84,CFM1))
fanwestcore=4*(fanzone(Fan2,$88,CFM2)+\
				fanzone(Fan3,$92,CFM3)+\
				fanzone(Fan1,$96,CFM1))
faneastext=4*(fanzone(Fan2,$77,CFM2)+\
				fanzone(Fan3,$81,CFM3)+\
				fanzone(Fan1,$85,CFM1))
faneastcore=4*(fanzone(Fan2,$89,CFM2)+\
				fanzone(Fan3,$93,CFM3)+\
				fanzone(Fan1,$97,CFM1))
				
fanbasement=Fan5

lightsouthext=6*($6+$7*10+$8)
lightsouthcore=6*($18+$19*10+$20)
lightnorthext=6*($3+$4*10+$5)
lightnorthcore=6*($15+$16*10+$17)
lightwestext=4*($12+$13*10+$14)
lightwestcore=4*($25+$25*10+$26)
lighteastext=4*($9+$10*10+$11)
lighteastcore=4*($21+$22*10+$23)
lightbasement=$2*4

print gasnorthext,heatnorthext,coolnorthext,fannorthext,lightnorthext,\
	  gasnorthcore,heatnorthcore,coolnorthcore,fannorthcore,lightnorthcore,\
	  gassouthext,heatsouthext,coolsouthext,fansouthext,lightsouthext,\
	  gassouthcore,heatsouthcore,coolsouthcore,fansouthcore,lightsouthcore,\
	  gaswestext,heatwestext,coolwestext,fanwestext,lightwestext,\
	  gaswestcore,heatwestcore,coolwestcore,fanwestcore,lightwestcore,\
	  gaseastext,heateastext,cooleastext,faneastext,lighteastext,\
	  gaseastcore,heateastcore,cooleastcore,faneastcore,lighteastcore,\
	  gasbasement,heatbasement,coolbasement,fanbasement,lightbasement

}

}



function heatzone (QTR,CFM,CFMX,gas,QB,QHP,QHCx) {
	if(CFMX==0 || (QB+QHP)==0) return 0.0
	else return (QTR+QHCx*CFM/CFMX)*gas/(QB+QHP)
}

function coolzone (CFM,CFMX,Cooling,QCCX,SQCC) {
	if(SQCC==0 || CFMX==0) return 0 
	else return CFM*QCCX*Cooling/(SQCC*CFMX) 
}

function fanzone (Fan,CFM,CFMX) {
	if(CFMX==0) return 0 ;
	else return CFM*Fan/CFMX ;
}


#	COL	Field
#	1	Date/Time
#	2	kWh_b,light,north
#	3	Lighting_n,1,3,1
#	4	Lighting_n,1,2,1
#	5	Lighting_n,1,1,1
#	6	Lighting_s,1,3,1
#	7	Lighting_s,1,2,1
#	8	Lighting_s,1,1,1
#	9	Lighting_e,1,3,1
#	10	Lighting_e,1,2,1
#	11	Lighting_e,1,1,1
#	12	Lighting_w,1,3,1
#	13	Lighting_w,1,2,1
#	14	Lighting_w,1,1,1
#	15	Lighting_n,2,3,1
#	16	Lighting_n,2,2,1
#	17	Lighting_n,2,1,1
#	18	Lighting_s,2,3,1
#	19	Lighting_s,2,2,1
#	20	Lighting_s,2,1,1
#	21	Lighting_e,2,3,1
#	22	Lighting_e,2,2,1
#	23	Lighting_e,2,1,1
#	24	Lighting_w,2,3,1
#	25	Lighting_w,2,2,1
#	26	Lighting_w,2,1,1
#	27	kWh_chiller1
#	28	kWh_chiller2
#	29	QHC_1
#	30	QHC_2
#	31	QHC_3
#	32	QHC_5
#	33	QTR_n,b
#	34	QTR_s,1,2,1
#	35	QTR_n,1,2,1
#	36	QTR_w,1,2,1
#	37	QTR_e,1,2,1
#	38	QTR_s,1,3,1
#	39	QTR_n,1,3,1
#	40	QTR_w,1,3,1
#	41	QTR_e,1,3,1
#	42	QTR_s,1,1,1
#	43	QTR_n,1,1,1
#	44	QTR_w,1,1,1
#	45	QTR_e,1,1,1
#	46	QTR_s,2,2,1
#	47	QTR_n,2,2,1
#	48	QTR_w,2,2,1
#	49	QTR_e,2,2,1
#	50	QTR_s,2,3,1
#	51	QTR_n,2,3,1
#	52	QTR_w,2,3,1
#	53	QTR_e,2,3,1
#	54	QTR_s,2,1,1
#	55	QTR_n,2,1,1
#	56	QTR_w,2,1,1
#	57	QTR_e,2,1,1
#	58	QCC_3
#	59	QCC_2
#	60	QCC_1
#	61	QCC_5
#	62	kWh_fan1
#	63	kWh_fan2
#	64	kWh_fan3
#	65	kWh_fan5
#	66	QB
#	67	Gas_tot
#	68	Elec_hwp
#	69	QHP
#	70	kWh_chwsp
#	71	kWh_cond
#	72	kWh_chwp
#	73	kWh_towerFan
#	74	CFM_s,1,2,1
#	75	CFM_n,1,2,1
#	76	CFM_w,1,2,1
#	77	CFM_e,1,2,1
#	78	CFM_s,1,3,1
#	79	CFM_n,1,3,1
#	80	CFM_w,1,3,1
#	81	CFM_e,1,3,1
#	82	CFM_s,1,1,1
#	83	CFM_n,1,1,1
#	84	CFM_w,1,1,1
#	85	CFM_e,1,1,1
#	86	CFM_s,2,2,1
#	87	CFM_n,2,2,1
#	88	CFM_w,2,2,1
#	89	CFM_e,2,2,1
#	90	CFM_s,2,3,1
#	91	CFM_n,2,3,1
#	92	CFM_w,2,3,1
#	93	CFM_e,2,3,1
#	94	CFM_s,2,1,1
#	95	CFM_n,2,1,1
#	96	CFM_w,2,1,1
#	97	CFM_e,2,1,1
#	98	CFM_1
#	99	CFM_2
#	100	CFM_3
#	101	CFM_5

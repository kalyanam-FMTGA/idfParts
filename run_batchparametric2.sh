#!/bin/bash

cd batch

./Burbank_ctrl3_wwr1530_DC.sh &
sleep 5
./Burbank_ctrl3_wwr1530_NDC.sh &
sleep 5
./Burbank_ctrl3_wwr4560_DC.sh &
sleep 5
./Burbank_ctrl3_wwr4560_NDC.sh &
sleep 5
./Chicago_ctrl3_wwr1530_DC.sh &
sleep 5
./Chicago_ctrl3_wwr1530_NDC.sh &
sleep 5
./Chicago_ctrl3_wwr4560_DC.sh &
sleep 5
./Chicago_ctrl3_wwr4560_NDC.sh &
sleep 5
./Houston_ctrl3_wwr1530_DC.sh &
sleep 5
./Houston_ctrl3_wwr1530_NDC.sh &
sleep 5
./Houston_ctrl3_wwr4560_DC.sh &
sleep 5
./Houston_ctrl3_wwr4560_NDC.sh &
sleep 5
./Oakland_ctrl3_wwr1530_DC.sh &
sleep 5
./Oakland_ctrl3_wwr1530_NDC.sh &
sleep 5
./Oakland_ctrl3_wwr4560_DC.sh &
sleep 5
./Oakland_ctrl3_wwr4560_NDC.sh &
sleep 5


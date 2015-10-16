#!/bin/bash

cd batch

./Burbank_ctIs1_wwr1530_DC.sh &
sleep 5
./Burbank_ctIs1_wwr1530_NDC.sh &
sleep 5
./Burbank_ctIs1_wwr4560_DC.sh &
sleep 5
./Burbank_ctIs1_wwr4560_NDC.sh &
sleep 5
./Chicago_ctIs1_wwr1530_DC.sh &
sleep 5
./Chicago_ctIs1_wwr1530_NDC.sh &
sleep 5
./Chicago_ctIs1_wwr4560_DC.sh &
sleep 5
./Chicago_ctIs1_wwr4560_NDC.sh &
sleep 5
./Houston_ctIs1_wwr1530_DC.sh &
sleep 5
./Houston_ctIs1_wwr1530_NDC.sh &
sleep 5
./Houston_ctIs1_wwr4560_DC.sh &
sleep 5
./Houston_ctIs1_wwr4560_NDC.sh &
sleep 5
./Oakland_ctIs1_wwr1530_DC.sh &
sleep 5
./Oakland_ctIs1_wwr1530_NDC.sh &
sleep 5
./Oakland_ctIs1_wwr4560_DC.sh &
sleep 5
./Oakland_ctIs1_wwr4560_NDC.sh &
sleep 5


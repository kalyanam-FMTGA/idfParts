#!/bin/bash

cd batch

./Burbank_ctIs1_wwr00_DC.sh &
sleep 5
./Burbank_ctIs1_wwr00_NDC.sh &
sleep 5
./Chicago_ctIs1_wwr00_DC.sh &
sleep 5

./Chicago_ctIs1_wwr00_NDC.sh &
sleep 5
./Houston_ctIs1_wwr00_DC.sh &
sleep 5
./Houston_ctIs1_wwr00_NDC.sh &
sleep 5
./Oakland_ctIs1_wwr00_DC.sh &
sleep 5

./Oakland_ctIs1_wwr00_NDC.sh &
sleep 5


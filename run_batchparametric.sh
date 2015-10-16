#!/bin/bash

cd batch

./Burbank_ctIs1.sh &
sleep 5
./Burbank_ctIs2.sh &
sleep 5
./Burbank_ctrl3.sh &
sleep 5

./Chicago_ctIs1.sh &
sleep 5
./Chicago_ctIs2.sh &
sleep 5
./Chicago_ctrl3.sh &
sleep 5

./Houston_ctIs1.sh &
sleep 5
./Houston_ctIs2.sh &
sleep 5
./Houston_ctrl3.sh &
sleep 5

./Oakland_ctIs1.sh &
sleep 5
./Oakland_ctIs2.sh &
sleep 5
./Oakland_ctrl3.sh &



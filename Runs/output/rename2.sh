#!/bin/bash

for ori in E N S W ; do
or=$ori

for typ in all cooling fan heating lighting; do
type=$typ

for res in site source ; do
re=$res
            


mv namebase_${or}_${type}_${re}.csv namebase_${or}_${type}_${re}_ctIs1.csv


done
done
done

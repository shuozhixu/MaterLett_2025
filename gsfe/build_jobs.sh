#!/bin/bash

for i in `seq 0 1 64`
do
        mkdir -p $i
        cd $i
        rm -f gsfe gsfe_ori dump.*
        cp ../lmp_gsfe.in .
        cp ../lmp.batch .
        cp ../FeNiCrCoAl-heaweight.setfl .
        cp ../data.AlCoCrFeNi_random_stacking .
        cd ..
done
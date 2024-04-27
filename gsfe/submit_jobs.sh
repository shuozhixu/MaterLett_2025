#!/bin/bash

for i in `seq 0 1 64`
do
        cd $i
        sbatch lmp.batch
        cd ..
done
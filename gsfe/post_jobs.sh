#!/bin/bash

rm -f gsfe_ext_surface test gamma.txt

for i in `seq 0 1 64`
do
        a=0.015625
        a=`echo "scale=6;$a*$i"|bc`
        cd $i
        rm -f gsfe gsfe_ext
        awk -v c=1 'NR==1 { b=$2 } { printf( "%0.2f\t%0.6f\n", $1,( $2-b ) * c ) }' gsfe_ori > gsfe
        gawk -v var="$a" '{print var, $1, $2}' gsfe > gsfe_ext
        cat gsfe_ext >> ../gsfe_ext_surface
        cd ..
done

awk '{$3; print}' gsfe_ext_surface > test
sort -nk2 -nk1 test > gamma.txt
sed -i '1s/^/65 101\n/' gamma.txt

rm -f gsfe_ext_surface test
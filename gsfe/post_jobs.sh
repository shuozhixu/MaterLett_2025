#!/bin/bash

rm -f gsfe_ext_surface gamma_test gamma.txt

cd 0
awk -v c=1 'NR==1 { b=$2 } { printf( "%0.5f\t%0.7f\n", $1,( $2-b ) * c ) }' gsfe_ori > gsfe
cd ..

for i in `seq 0 1 64`
do
        a=0.015625
        a=`echo "scale=6;$a*$i"|bc`
        cd $i
        rm -f gsfe_ext
        awk -v var="$a" '{print var, $1, $2}' gsfe_ori > gsfe_ext
        cat gsfe_ext >> ../gsfe_ext_surface
        cd ..
done

sort -nk2 -nk1 gsfe_ext_surface > gamma_test
awk 'NR==1 { b=$3 } { printf( "%0.5f\t%0.5f\t%0.7f\n", $1, $2, $3-b) }' gamma_test > gamma.txt
sed -i '1s/^/65 101\n/' gamma.txt

rm -f gsfe_ext_surface gamma_test
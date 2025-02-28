#!/usr/bin/bash

rm -f data.*

a=3.55
d=201.638
e=250.595

x=$(echo "scale=5;$d*$a/3.326" | bc)

y=$(echo "scale=5;$e*$a/3.326" | bc)

b=$(echo "scale=5;$a*sqrt(2.)/2." | bc)

atomsk --create fcc $a Ni orient [-1-12] [111] [-110] -duplicate 99 87 120 supercell.cfg

atomsk supercell.cfg -dislocation $x $y screw z y $b dis.imd

c=$(echo "scale=5;$b/2." | bc)

awk -v var="$c" 'NR==3 {$4=var} {print}' dis.imd > dis_mod.imd

atomsk dis_mod.imd -alignx screw_Ni_40nm_pad.xsf

atomsk screw_Ni_40nm_pad.xsf screw_Ni_40nm_pad.cfg

awk -v var="Ni" 'NR==16 {$1=var} {print}' screw_Ni_40nm_pad.cfg > Ni.cfg

atomsk Ni.cfg -select random 1293502 Ni -sub Ni Co NiCo.cfg

atomsk NiCo.cfg -select random 1293502 Ni -sub Ni Cr NiCoCr.cfg

atomsk NiCoCr.cfg -select random 1293502 Ni -sub Ni Fe NiCoCrFe.cfg

atomsk NiCoCrFe.cfg -select random 388050 Ni -sub Ni Al data.NiCoCrFeAl_random_screw.cfg lmp

mv data.NiCoCrFeAl_random_screw.lmp data.NiCoCrFeAl_screw

rm -f *.cfg *.imd *.xsf

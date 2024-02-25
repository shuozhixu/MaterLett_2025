#!/usr/bin/bash

rm -f data.*

a=3.55
p=0.291625064

d=188.735
e=235.233

x=$(echo "scale=5;$d*$a/3.326" | bc)

y=$(echo "scale=5;$e*$a/3.326" | bc)

b=$(echo "scale=5;$a*sqrt(3.)/2." | bc)

atomsk --create fcc $a Ni orient [-110] [111] [11-2] -duplicate 161 82 1 supercell.cfg

atomsk supercell.cfg -dislocation $x $y edge_rm Z Y $b $p -wrap edge_Ni.cfg

atomsk edge_Ni.cfg -select random 18364 Ni -sub Ni Co NiCo.cfg

atomsk NiCo.cfg -select random 18364 Ni -sub Ni Cr NiCoCr.cfg

atomsk NiCoCr.cfg -select random 18365 Ni -sub Ni Fe NiCoCrFe.cfg

atomsk NiCoCrFe.cfg -select random 5509 Ni -sub Ni Al data.NiCoCrFeAl_random_edge.cfg lmp

mv data.NiCoCrFeAl_random_edge.lmp data.NiCoCrFeAl_random_edge

rm -f *.cfg

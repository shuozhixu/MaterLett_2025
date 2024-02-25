#!/usr/bin/bash

rm -f data.*

a=3.55

atomsk --create fcc $a Ni orient [-110] [111] [11-2] -duplicate 162 41 70 edge_Ni_110_top.cfg

atomsk --create fcc $a Ni orient [-110] [111] [11-2] -duplicate 161 41 70 edge_Ni_110_bottom.cfg

atomsk edge_Ni_110_top.cfg -deform X -0.003086419753 0.0 edge_Ni_110_top_deformed.cfg

atomsk edge_Ni_110_bottom.cfg -deform X 0.003105590062 0.0 edge_Ni_110_bottom_deformed.cfg

atomsk --merge Y 2 edge_Ni_110_bottom_deformed.cfg edge_Ni_110_top_deformed.cfg edge_Ni.cfg

atomsk edge_Ni.cfg -select random 1293502 Ni -sub Ni Co NiCo.cfg

atomsk NiCo.cfg -select random 1293502 Ni -sub Ni Cr NiCoCr.cfg

atomsk NiCoCr.cfg -select random 1293502 Ni -sub Ni Fe NiCoCrFe.cfg

atomsk NiCoCrFe.cfg -select random 388050 Ni -sub Ni Al data.NiCoCrFeAl_random_edge.cfg lmp

mv data.NiCoCrFeAl_random_edge.lmp data.NiCoCrFeAl_edge

rm *.cfg

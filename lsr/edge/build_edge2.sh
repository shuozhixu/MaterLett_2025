#!/usr/bin/bash

rm -f data.*

a=3.55

atomsk --create fcc $a Ni orient [-110] [111] [11-2] -duplicate 162 41 1 edge_Ni_111_top.cfg

atomsk --create fcc $a Ni orient [-110] [111] [11-2] -duplicate 161 41 1 edge_Ni_111_bottom.cfg

atomsk edge_Ni_111_top.cfg -deform X -0.003086419753 0.0 edge_Ni_1101top_deformed.cfg

atomsk edge_Ni_111_bottom.cfg -deform X 0.003105590062 0.0 edge_Ni_111_bottom_deformed.cfg

atomsk --merge Y 2 edge_Ni_111_bottom_deformed.cfg edge_Ni_111_top_deformed.cfg edge_Ni.cfg

atomsk edge_Ni.cfg -select random 18478 Ni -sub Ni Co NiCo.cfg

atomsk NiCo.cfg -select random 18478 Ni -sub Ni Cr NiCoCr.cfg

atomsk NiCoCr.cfg -select random 18478 Ni -sub Ni Fe NiCoCrFe.cfg

atomsk NiCoCrFe.cfg -select random 5543 Ni -sub Ni Al data.NiCoCrFeAl_random_edge.cfg lmp

mv data.NiCoCrFeAl_random_edge.lmp data.NiCoCrFeAl_random_edge

rm *.cfg

#!/usr/bin/bash

rm -f *.lmp data.*

a=3.55

atomsk --create fcc $a Al orient [1-10] [11-2] [111] -duplicate 20 20 20 Al.cfg

atomsk Al.cfg -select random 11162 Al -sub Al Co AlCo.cfg

atomsk AlCo.cfg -select random 11162 Al -sub Al Cr AlCoCr.cfg

atomsk AlCoCr.cfg -select random 11162 Al -sub Al Fe AlCoCrFe.cfg

atomsk AlCoCrFe.cfg -select random 11162 Al -sub Al Ni AlCoCrFeNi.cfg lmp

mv AlCoCrFeNi.lmp data.AlCoCrFeNi_gsfe

rm -f *.cfg

# Al<sub>0.3</sub>CoCrFeNi: Atomistics

## Foreword

The purpose of this project is to siimulate (i) dislocation gliding in an obstacle-free lattice, (ii) dislocation/void interactions, and (iii) dislocation/precipitate interactions using atomistic simulations in random Al<sub>0.3</sub>CoCrFeNi multi-principal element alloy (MPEA). To provide references, the same properties for Ni are also calculated in selected cases.

## LAMMPS

Following [another project](https://github.com/shuozhixu/Modelling_2024), we can build LAMMPS with the MANYBODY package and submit jobs on [OSCER](http://www.ou.edu/oscer.html).

Note: if we use sbatch files from [LAMMPSatOU](https://github.com/ANSHURAJ11/LAMMPSatOU), we may need to change the walltime (default: 12 hours) and/or number of cores (default: 16). For this project, I recommend

	#SBATCH --time=200:00:00
	#SBATCH --ntasks-per-node=32

## Interatomic potential

Upon comparing two different interatomic potentials in [another project](https://github.com/shuozhixu/Metals_2025), we decide to use the [Farkas-Caro potential](https://doi.org/10.1557/jmr.2020.294) for the following simulations.

## Dislocation glide and dislocation/obstacle interactions

Calculate the glide of and an obstacle interacting with both edge and screw dislocations at 5 K. The atomsk scripts that are used to build the atomistic structures as well as the LAMMPS input files for the LSR calculations, can be found in the `glide/` directory in this GitHub repository.

Calculations follow [a previous GitHub repository](https://github.com/wrj2018/MSMSE_2020). Consider both edge and screw dislocations and three types of obstacles: void, B2 precipitate, and L1<sub>2</sub> precipitate. Let the obstacle radius be 0.6 nm, 1.2 nm, 2.4 nm, 3.6 nm, and 4.8 nm, respectively. Read [these papers](https://drive.google.com/drive/folders/1Pfg0ZztTd7QkhRMLABwpwrZFWDxasoBQ?usp=sharing) which are on dislocatino/obstacle interactions in metals using atomistic simulations.

Answer two questions:

1. how is the standard deviation in dislocation/obstacle interaction strength compared with that in LSR?
2. how does the orientation of the crystalline precipitates affect the dislocation bypassing stress? Is it possible that, for some orientations, the bypassing stress for a precipitate is larger than that for a void?

## Reference

If you use any files from this GitHub repository, please cite

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107
# Al<sub>0.3</sub>CoCrFeNi: Atomistics: Dislocation glide

## Foreword

The purpose of this project is to simulate dislocation glide in an obstacle-free lattice using atomistic simulations in random Al<sub>0.3</sub>CoCrFeNi multi-principal element alloy. To provide references, dislocation glide in Ni is also studied.

## LAMMPS

Following [a related project](https://github.com/shuozhixu/HEAM_2025), we can build LAMMPS with the MANYBODY package and submit jobs on [OSCER](http://www.ou.edu/oscer.html).

## Interatomic potential

Upon comparing two different interatomic potentials in [another project](https://github.com/shuozhixu/HEAM_2025), we decide to use the [Farkas-Caro potential](https://doi.org/10.1557/jmr.2020.294) for the following simulations.

## Dislocation glide

Calculate the glide of an edge or a screw dislocation at 5 K. The atomsk scripts that are used to build the atomistic structures as well as the LAMMPS input files can be found in this GitHub repository. The input files were modified from [a previous GitHub repository](https://github.com/wrj2018/MSMSE_2020).

## Reference

If you use any files from this GitHub repository, please cite

- Shuozhi Xu, Wu-Rong Jian, Irene J. Beyerlein, [Ideal simple shear strengths of two HfNbTaTi-based quinary refractory multi-principal element alloys](http://dx.doi.org/10.1063/5.0116898), APL Mater. 10 (2022) 111107
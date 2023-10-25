# Al0.3CoCrFeNi

## Foreword

The purpose of this project is to calculate the basic structural parameters (including lattice parameter and elastic constants), generalized stacking fault energies (GSFE), and local slip resistances (LSR) in random Al0.3CoCrFeNi MPEA.

## LAMMPS

LAMMPS on [OSCER](http://www.ou.edu/oscer.html) likely does not come with many packages. To build more packages into LAMMPS, please visit [this page](https://docs.lammps.org/Build_package.html).

To finish this project, at least three packages are needed:

- MANYBODY package. This is to use the manybody potential such as the embedded-atom method potential.
- EXTRA-COMPUTE package. This is to calculate the elastic constants at finite temperatures using the Born matrix method. To learn more, please visit [this page](https://docs.lammps.org/Howto_elastic.html
) and [this page](https://docs.lammps.org/compute_born_matrix.html). [This paper](https://doi.org/10.1063/1.447221) should be cited for the Born matrix method.
- MC package. This is to generate materials with chemical short-range order at a given temperature. [This paper](http://dx.doi.org/10.1103/PhysRevB.85.184203) should be cited if one uses this package.

Note: if you use sbatch files from [LAMMPSatOU](https://github.com/ANSHURAJ11/LAMMPSatOU), you may need to change the walltime (default: 12 hours) and/or number of cores (default: 16). For this project, I recommend

	#SBATCH --time=200:00:00
	#SBATCH --ntasks=32

## One question

Elastic constants and LSR can be used directly in the CPFEM model. But can we use MD to inform the dislocation/precipitate interactions in CPFEM?

## Build the random structure

Al0.3CoCrFeNi has an FCC lattice, according to [this paper](https://doi.org/10.1016/j.actamat.2022.118600). 

Build the random structure using Atomsk.

In this alloy, the CSRO effect has been studied in [a previous paper](https://doi.org/10.1016/j.matdes.2022.111214), so we focus on the random structure. Also, the creep temperature is high (973-1033K), at which the CSRO is negligible.

[This paper](https://doi.org/10.1016/j.msea.2021.141253) used another potential to calculate some properties of this alloy. Please read it.

## Lattice parameters and elastic constants

Use the [EAM potential](https://www.ctcms.nist.gov/potentials/entry/2020--Farkas-D-Caro-A--Fe-Ni-Cr-Co-Al/2020--Farkas-D--Fe-Ni-Cr-Co-Al--LAMMPS--ipr1.html). Calculate its lattice parameters and elastic constants at 0 K, 300 K, ..., 1033 K. The last is the maximum temperature used in [the creep experiments](https://doi.org/10.1016/j.actamat.2022.118600). You decide what intermediate temperatures you will study.

Follow [a previous GitHub repository](https://github.com/shuozhixu/Modelling_2024).

## GSFE

Calculate the GSFE at 0 K. Follow two previous GitHub repositories, led by [Romero](https://github.com/shuozhixu/FLAM2020-GSFE) and [Mubassira](https://github.com/shuozhixu/Modelling_2024), respectively. Consider the randomness of elements.

## LSR

Calculate the LSR of both edge and screw dislocations at 0 K. Follow [a previous GitHub repository](https://github.com/shuozhixu/FLAM2020-LSR). Consider the randomness of elements.

## Dislocation/obstacle interactions

Follow [a previous GitHub repository](https://github.com/wrj2018/MSMSE_2020).

### Dislocation/void interactions

Read [these papers](https://drive.google.com/drive/folders/1uM6CM59NrHx7o2ZFFyyN85nS_ZRpRsa4?usp=sharing) which are on dislocatino/void interactions in metals using atomistic simulations.

### Dislocation/precipitate interactions

There are many papers on this topic too. For example, a previous paper by [Liaw and colleagues](https://doi.org/10.1016/j.ijplas.2020.102819).

For this alloy, please consider both B2 precipitate and L12 precipitate.
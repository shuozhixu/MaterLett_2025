# Al<sub>0.3</sub>CoCrFeNi

## Foreword

The purpose of this project is to calculate the basic structural parameters (including lattice parameter and elastic constants), generalized stacking fault energies (GSFE), local slip resistances (LSR), and dislocation/obstacle interaction strengths in random Al<sub>0.3</sub>CoCrFeNi MPEA.

## LAMMPS

LAMMPS on [OSCER](http://www.ou.edu/oscer.html) likely does not come with many packages. To build more packages into LAMMPS, please visit [this page](https://docs.lammps.org/Build_package.html).

To finish this project, at least two packages are needed:

- MANYBODY package. This is to use the manybody potential such as the embedded-atom method potential.
- EXTRA-COMPUTE package. This is to calculate the elastic constants at finite temperatures using the Born matrix method. To learn more, please visit [this page](https://docs.lammps.org/Howto_elastic.html
) and [this page](https://docs.lammps.org/compute_born_matrix.html). [This paper](https://doi.org/10.1063/1.447221) should be cited for the Born matrix method.

Note: if you use sbatch files from [LAMMPSatOU](https://github.com/ANSHURAJ11/LAMMPSatOU), you may need to change the walltime (default: 12 hours) and/or number of cores (default: 16). For this project, I recommend

	#SBATCH --time=200:00:00
	#SBATCH --ntasks=32

## Discussion

Elastic constants and LSR can be used directly in the CPFEM model. But can we use MD to inform the dislocation/precipitate interactions in CPFEM?

If no, we should fit those precipitate-related parameters in CPFEM from experiments.

Regardless, we should run MD simulations of dislocation/obstacle interactions. Otherwise, it won't make a good paper.

Think about this optin: first, run MD simulations to obtain parameters [1,3,5,16] for CPFEM; second, run CPFEM tensile and creep simulations to fit other parameters; third, run CPFEM creep simulations; fourth, finish all other MD simulations and write an MD paper; fifth, finish all CPFEM simulations and write a CPFEM paper (which will cite the MD paper).

## Interatomic potentials

There are several interatomic potentials for this alloy. Let's focus on the following two:

- The first one is `AlCoCrFeNi_Zhou04.eam.alloy`. If you use it, cite [this paper](http://dx.doi.org/10.1016/S1359-6454(01)00287-7) and [this paper](http://dx.doi.org/10.1103/PhysRevB.77.214108).
- The second one is `FeNiCrCoAl-heaweight.setfl`. If you use it, cite [this paper](https://doi.org/10.1557/jmr.2020.294).

Both potential files can be found in this GitHub repository.

[This paper](https://doi.org/10.1016/j.msea.2021.141253) used an in-house interatomic potential to calculate some properties of Al<sub>_x_</sub>CoCrFeNi, where _x_ varies from 0 to 0.5. Please read it.

## Random structure

Al<sub>0.3</sub>CoCrFeNi has an FCC lattice, according to [this paper](https://doi.org/10.1016/j.actamat.2022.118600). 

In this alloy, the CSRO effect has been studied in [a previous paper](https://doi.org/10.1016/j.matdes.2022.111214), so we focus on the random structure. Also, the creep temperature is high (973-1033K), at which the CSRO is negligible.

Random structures can be built using [Atomsk](https://atomsk.univ-lille.fr).

## Lattice parameters and elastic constants

Calculate its lattice parameters and elastic constants at 0 K, 300 K, ..., 1033 K. The last is the maximum temperature used in [the creep experiments](https://doi.org/10.1016/j.actamat.2022.118600).

Follow [a previous GitHub repository](https://github.com/shuozhixu/Modelling_2024).

## GSFE

Calculate the GSFE at 0 K. Follow two previous GitHub repositories, led by [Romero](https://github.com/shuozhixu/FLAM2020-GSFE) and [Mubassira](https://github.com/shuozhixu/Modelling_2024), respectively. Consider the randomness of elements.

## LSR

Calculate the LSR of both edge and screw dislocations at 0 K. Follow [a previous GitHub repository](https://github.com/shuozhixu/FLAM2020-LSR) and [its associated paper](http://dx.doi.org/10.1016/j.ijplas.2021.103157). Consider the randomness of elements.

## Dislocation/obstacle interactions

Follow [a previous GitHub repository](https://github.com/wrj2018/MSMSE_2020). Run the following calculations at 300 K and 1033 K, respectively. Consider three types of obstacles: void, B2 precipitate, and L12 precipitate.

Answer two questions:

1. how is the standard deviation in dislocation/obstacle interaction strength compared with that in LSR?
2. how does the orientation of the crystalline precipitates affect the dislocation bypassing stress?

### Dislocation/void interactions

Read [these papers](https://drive.google.com/drive/folders/1uM6CM59NrHx7o2ZFFyyN85nS_ZRpRsa4?usp=sharing) which are on dislocatino/void interactions in metals using atomistic simulations.

### Dislocation/precipitate interactions

There are many papers on this topic too. For example, a previous paper by [Liaw and colleagues](https://doi.org/10.1016/j.ijplas.2020.102819).

For this alloy, please consider both B2 precipitate and L12 precipitate.
# Al<sub>0.3</sub>CoCrFeNi: Atomistics

## Foreword

The purpose of this project is to calculate the basic structural parameters (including lattice parameter and elastic constants), generalized stacking fault energies (GSFE), local slip resistances (LSR), and dislocation/obstacle interaction strengths using atomistic simulations in random Al<sub>0.3</sub>CoCrFeNi MPEA. To provide references, the same properties for Ni are also calculated.

## LAMMPS

LAMMPS on [OSCER](http://www.ou.edu/oscer.html) likely does not come with many packages. To build more packages into LAMMPS, please visit [this page](https://docs.lammps.org/Build_package.html).

To finish this project, at least two packages are needed:

- MANYBODY package. This is to use the manybody potential such as the embedded-atom method potential.
- EXTRA-COMPUTE package. This is to calculate the elastic constants at finite temperatures using the Born matrix method. To learn more, please visit [this page](https://docs.lammps.org/Howto_elastic.html
) and [this page](https://docs.lammps.org/compute_born_matrix.html). [This paper](https://doi.org/10.1063/1.447221) should be cited for the Born matrix method.

Note: if we use sbatch files from [LAMMPSatOU](https://github.com/ANSHURAJ11/LAMMPSatOU), we may need to change the walltime (default: 12 hours) and/or number of cores (default: 16). For this project, I recommend

	#SBATCH --time=200:00:00
	#SBATCH --ntasks=32

## Interatomic potentials

There are several interatomic potentials for this alloy. Let's focus on the following two:

- The first one is `AlCoCrFeNi_Zhou04.eam.alloy`. If one uses it, cite [this paper](http://dx.doi.org/10.1016/S1359-6454(01)00287-7) and [this paper](http://dx.doi.org/10.1103/PhysRevB.77.214108).
- The second one is `FeNiCrCoAl-heaweight.setfl`. If one uses it, cite [this paper](https://doi.org/10.1557/jmr.2020.294).

Both potential files can be found in this GitHub repository.

[This paper](https://doi.org/10.1016/j.msea.2021.141253) used an in-house interatomic potential to calculate some properties of Al<sub>_x_</sub>CoCrFeNi, where _x_ varies from 0 to 0.5. There may be other interatomic potentials for this MPEA.

Note: after carefully consideration, we decide to use the second potential for the following simulations.

## Random structure

Al<sub>0.3</sub>CoCrFeNi has an FCC lattice, according to [this paper](https://doi.org/10.1016/j.actamat.2022.118600). 

In this alloy, the CSRO effect has been studied in [a previous paper](https://doi.org/10.1016/j.matdes.2022.111214), so we focus on the random structure. Also, the creep temperature is high (973-1033K) in [the experiment](https://doi.org/10.1016/j.actamat.2022.118600), at which the CSRO is negligible.

Random structures can be built using [Atomsk](https://atomsk.univ-lille.fr).

## Lattice parameters and elastic constants

Calculate its lattice parameters and elastic constants at 0 K, 300 K, ..., 973 K, 1003 K, 1033 K. The last three are the temperatures used in [the creep experiments](https://doi.org/10.1016/j.actamat.2022.118600).

Calculations follow [a previous GitHub repository](https://github.com/shuozhixu/Modelling_2024).

## GSFE

Calculate the GSFE at 0 K. The atomsk script used to build the atomistic structure for the GSFE calculations as well as the corresponding LAMMPS input file, `lmp_gsfe.in`, can be found in the `gsfe/` directory in this GitHub repository.

Calculations follow [a previous GitHub repository](https://github.com/shuozhixu/Modelling_2024). 20 GSFE curves are calculated due to the randomness of elements.

## LSR

Calculate the LSR of both edge and screw dislocations at 0 K. The atomsk scripts that are used to build the atomistic structures as well as the LAMMPS input files for the LSR calculations, can be found in the `lsr/` directory in this GitHub repository.

Calculations follow [a previous GitHub repository](https://github.com/shuozhixu/FLAM2020-LSR) and [its associated paper](http://dx.doi.org/10.1016/j.ijplas.2021.103157). 20 LSR are calculated for an edge and a screw dislocation, respectively, due to the randomness of elements.

## Dislocation glide and dislocation/obstacle interactions

Calculate the glide of and an obstacle interacting with both edge and screw dislocations at 5 K. The atomsk scripts that are used to build the atomistic structures as well as the LAMMPS input files for the LSR calculations, can be found in the `glide/` directory in this GitHub repository.

Calculations follow [a previous GitHub repository](https://github.com/wrj2018/MSMSE_2020). Consider both edge and screw dislocations and three types of obstacles: void, B2 precipitate, and L1<sub>2</sub> precipitate. Let the obstacle radius be 0.6 nm, 1.2 nm, 2.4 nm, 3.6 nm, and 4.8 nm, respectively. Read [these papers](https://drive.google.com/drive/folders/1Pfg0ZztTd7QkhRMLABwpwrZFWDxasoBQ?usp=sharing) which are on dislocatino/obstacle interactions in metals using atomistic simulations.

Answer two questions:

1. how is the standard deviation in dislocation/obstacle interaction strength compared with that in LSR?
2. how does the orientation of the crystalline precipitates affect the dislocation bypassing stress? Is it possible that, for some orientations, the bypassing stress for a precipitate is larger than that for a void?

## Discussion

Elastic constants, LSR, and dislocation/precipitate interactions can be used directly in the CPFEM model. However, [experiments](https://doi.org/10.1016/j.actamat.2022.118600) showed that a typical B2 and L1<sub>2</sub> precipitate, respecitvely, has a diameter of 20--100 nm and 10--80 nm, beyond what are commonly modeled in atomistic simulations. Therefore, we will only use elastic constants and LSR in our CPFEM work.
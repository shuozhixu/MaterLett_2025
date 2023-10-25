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
	
## Alloys

### Al<sub>0.3</sub>CoCrFeNi

It has an FCC lattice, according to [this paper](https://doi.org/10.1016/j.actamat.2022.118600). Use the [EAM potential](https://www.ctcms.nist.gov/potentials/entry/2020--Farkas-D-Caro-A--Fe-Ni-Cr-Co-Al/2020--Farkas-D--Fe-Ni-Cr-Co-Al--LAMMPS--ipr1.html). Thus, it does not requrie the M3GNet package.

Build the random structure and two CSRO structures annealed at 300 K and 973 K, respectively.

Calculate the lattice parameters and elastic constants of both random and 973KMDMC structures at 0 K and 973 K.

Calculate the GSFE and LSR in both random and 973KMDMC structures at 0 K.

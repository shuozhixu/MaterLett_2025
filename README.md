# Non-equal molar multi-principal element materials

## Foreword

The purpose of this project is to calculate the basic structural parameters (including lattice parameter and elastic constants), generalized stacking fault energies (GSFE), and local slip resistances (LSR) in several non-equal molar multi-principal element materials (MPEMs) including alloys and ceramics. The effects of chemical short-range order (CSRO) and temperature will be considered.

## LAMMPS

LAMMPS on [OSCER](http://www.ou.edu/oscer.html) likely does not come with many packages. To build more packages into LAMMPS, please visit [this page](https://docs.lammps.org/Build_package.html).

To finish this project, at least four packages are needed. The first three come with the official LAMMPS source code, and so it should be straightforward to install them:

- MANYBODY package. This is to use the manybody potential such as the embedded-atom method potential.
- EXTRA-COMPUTE package. This is to calculate the elastic constants at finite temperatures using the Born matrix method. To learn more, please visit [this page](https://docs.lammps.org/Howto_elastic.html
) and [this page](https://docs.lammps.org/compute_born_matrix.html). [This paper](https://doi.org/10.1063/1.447221) should be cited for the Born matrix method.
- MC package. This is to generate materials with chemical short-range order at a given temperature. [This paper](http://dx.doi.org/10.1103/PhysRevB.85.184203) should be cited if one uses this package.

The last package does not come with the official LAMMPS source code, and so it is not straightforward to install it:

- [M3GNet package](https://www.linkedin.com/posts/ongsp_github-advancesoftcorplammps-compiled-activity-7008842815757586432-BaWR). This is to help use the M3GNet potential. [Here](https://www.nature.com/articles/s43588-022-00349-3) is the paper for M3GNet; it should be cited if one uses this package.

Note: if you use sbatch files from [LAMMPSatOU](https://github.com/ANSHURAJ11/LAMMPSatOU), you may need to change the walltime (default: 12 hours) and/or number of cores (default: 16). For this project, I recommend

	#SBATCH --time=200:00:00
	#SBATCH --ntasks=32
	
## Alloys

### Al<sub>0.3</sub>CoCrFeNi

It has an FCC lattice, according to [this paper](https://doi.org/10.1016/j.actamat.2022.118600). Use the [EAM potential](https://www.ctcms.nist.gov/potentials/entry/2020--Farkas-D-Caro-A--Fe-Ni-Cr-Co-Al/2020--Farkas-D--Fe-Ni-Cr-Co-Al--LAMMPS--ipr1.html). Thus, it does not requrie the M3GNet package.

Build the random structure and two CSRO structures annealed at 300 K and 973 K, respectively.

Calculate the lattice parameters and elastic constants of both random and 973KMDMC structures at 0 K and 973 K.

Calculate the GSFE and LSR in both random and 973KMDMC structures at 0 K.

### Co<sub>2</sub>Ni<sub>2</sub>Ru

It has an FCC lattice, according to [this paper](https://doi.org/10.1016/j.actamat.2020.05.003). Use the M3GNet potential.

Build the random structure and the CSRO structure annealed at 300 K.

Calculate the lattice parameters and elastic constants of both random and CSRO structures at 0 K and 300 K.

Calculate the GSFE and LSR in both random and CSRO structures at 0 K.

Note: DFT calculations show that, _a_<sub>0</sub> = 3.58 nm, effective _C_<sub>11</sub> = 401.078 GPa, effective _C_<sub>12</sub> = 168.944 GPa, effective _C_<sub>44</sub> = 148.554 GPa, and mean ISFE = -43.11 mJ/m<sup>2</sup>.

## Ceramics

Four ceramics will be considered. Use the M3GNet potential. I will send you Sooraj's data for their structures.

### BaCe<sub>0.5</sub>Zr<sub>0.5</sub>O<sub>3</sub>

It is the simplification of BaCe<sub>0.4</sub>Zr<sub>0.4</sub>Y<sub>0.1</sub>Yb<sub>0.1</sub>O<sub>$3-\delta$</sub>, which is a proton conducting electrolyte in one type of protonic ceramics fuel cell (PCFC).

Build the random structure and the CSRO structure annealed at 823 K.

Calculate the lattice parameters and elastic constants of both random and CSRO structures at 0 K and 823 K.

Calculate the GSFE and LSR in both random and CSRO structures at 0 K.

### BaCo<sub>0.5</sub>Fe<sub>0.5</sub>O<sub>3</sub> 

It is the simplification of BaCo<sub>0.4</sub>Fe<sub>0.4</sub>Zr<sub>0.1</sub>Y<sub>0.1</sub>O<sub>$3-\delta$</sub>, which is a positive electrode (i.e., cathode) in one type of PCFC.

Build the random structure and the CSRO structure annealed at 823 K.

Calculate the lattice parameters and elastic constants of both random and CSRO structures at 0 K and 823 K.

### La<sub>0.8</sub>Sr<sub>0.2</sub>Ga<sub>0.8</sub>Mg<sub>0.2</sub>O<sub>2.8</sub>

It is an oxygen-ion conducting electrolyte in one type of solid oxygen fuel cell (SOFC).

Build the random structure and the CSRO structure annealed at 1073 K.

Calculate the lattice parameters and elastic constants of both random and CSRO structures at 0 K and 1073 K.

Calculate the GSFE and LSR in both random and CSRO structures at 0 K.

### La<sub>0.6</sub>Sr<sub>0.4</sub>CoO<sub>3</sub> 

It is the simplification of La<sub>0.6</sub>Sr<sub>0.4</sub>CoO<sub>$3-\delta$</sub>, which is a cathode in one type of SOFC.

Build the random structure and the CSRO structure annealed at 1073 K.

Calculate the lattice parameters and elastic constants of both random and CSRO structures at 0 K and 1073 K.
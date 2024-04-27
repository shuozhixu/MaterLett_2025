# Al<sub>0.3</sub>CoCrFeNi: Atomistics

## Foreword

The purpose of this project is to calculate the basic structural parameters (including lattice parameter and elastic constants), generalized stacking fault energies (GSFE), local slip resistances (LSR), and dislocation/obstacle interaction strengths using atomistic simulations in random Al<sub>0.3</sub>CoCrFeNi MPEA. To provide references, the same properties for Ni are also calculated.

## LAMMPS

LAMMPS on [OSCER](http://www.ou.edu/oscer.html) likely does not come with many packages. To finish this project, at least two packages are needed:

- MANYBODY package. This is to use the manybody potential such as the embedded-atom method potential.
- EXTRA-COMPUTE package. This is to calculate the elastic constants at finite temperatures using the Born matrix method. To learn more, please visit [this page](https://docs.lammps.org/Howto_elastic.html
) and [this page](https://docs.lammps.org/compute_born_matrix.html). [This paper](https://doi.org/10.1063/1.447221) should be cited for the Born matrix method.

To build LAMMPS with these two packages, please refer to [another project](https://github.com/shuozhixu/Modelling_2024).

Note: if we use sbatch files from [LAMMPSatOU](https://github.com/ANSHURAJ11/LAMMPSatOU), we may need to change the walltime (default: 12 hours) and/or number of cores (default: 16). For this project, I recommend

	#SBATCH --time=200:00:00
	#SBATCH --ntasks-per-node=32

## Interatomic potentials

There are several interatomic potentials for this alloy. Let's focus on the following two:

- The first one is `AlCoCrFeNi_Zhou04.eam.alloy`. If one uses it, cite [this paper](http://dx.doi.org/10.1016/S1359-6454(01)00287-7) and [this paper](http://dx.doi.org/10.1103/PhysRevB.77.214108).
- The second one is `FeNiCrCoAl-heaweight.setfl`. If one uses it, cite [this paper](https://doi.org/10.1557/jmr.2020.294).

Both potential files can be found in this GitHub repository.

[This paper](https://doi.org/10.1016/j.msea.2021.141253) used an in-house interatomic potential to calculate some properties of Al<sub>_x_</sub>CoCrFeNi, where _x_ varies from 0 to 0.5. There may be other interatomic potentials for this MPEA.

Note: after careful consideration, we decide to use the second potential for the following simulations.

## Random structure

Al<sub>0.3</sub>CoCrFeNi has an FCC lattice, according to [this paper](https://doi.org/10.1016/j.actamat.2022.118600). 

In this alloy, the CSRO effect has been studied by [Sun et al.](https://doi.org/10.1016/j.matdes.2022.111214) and [Hasan et al.](https://doi.org/10.1016/j.commatsci.2024.112980), so we focus on the random structure. Also, the creep temperature is high (973--1033K) in [the experiment](https://doi.org/10.1016/j.actamat.2022.118600), at which the CSRO is negligible.

Random structures can be built using [Atomsk](https://atomsk.univ-lille.fr).

## Lattice parameters and elastic constants

Calculate its lattice parameters and elastic constants at 0 K, 300 K, ..., 973 K, 1003 K, 1033 K. The last three are the temperatures used in [the creep experiments](https://doi.org/10.1016/j.actamat.2022.118600). For each data point, take the mean value from three random structures.

Calculations follow [a previous project](https://github.com/shuozhixu/Modelling_2024).

## GSFE

Calculate the GSFE at 0 K. Most files are in the `gsfe/` directory in this GitHub repository. Upload all of them to a directory, say `gsfe-1/`, on OSCER.

Locally run the atomsk script, `build_gsfe.sh`, to build the data file. Check the order of elements in the data file, then modify line 17 of `lmp_gsfe.in` to ensure that the two orders match.

Prepare a batch file named `lmp.batch` and upload it, along with the interatomic file and data file, to `gsfe-1/` on OSCER, then run

	sh build_jobs.sh
	
to generate 65 subdirectories: `0`, `1`, `2`, ..., `64`. Then cd into each subdirectory and edit the file `lmp_gsfe.in`:

- line 61. Change the first integer (by default `0`) after `equal` to `1`, `2`, ... or `64`, matching the subdirectory name

Then go back to `gsfe-1/` and run

	sh submit_jobs.sh
	
to submit 65 jobs.

Once all jobs are finished, run

	sh post_jobs.sh

to get a file `gamma.txt`, which contains the GSFE surface and is compatible with the UCSB version of [PFDD](https://github.com/shuozhixu/PFDD) code. Note that in the subdirectory `0`, the file `gsfe` is the same GSFE curve calculated in [a previous project](https://github.com/shuozhixu/Modelling_2024), albeit for a different alloy there, CoCrNi.

However, `gamma.txt` only contains the GSFE surface on one shift plane. According to [a previous paper](http://dx.doi.org/10.1016/j.cma.2021.114426), multiple GSFE surfaces need to be calculated to obtain a good statistics of the GSFE surface in an alloy.

To obtain other GSFE surfaces on other shift planes, create 19 more directories, `gsfe-2`, `gsfe-3`, ..., `gsfe-20`, and copy all necessary files to each.

Take `gsfe-2` as an example. Change the last integer (by default `1`) in line 34 of `lmp_gsfe.in` to `2`, matching the number after `gsfe-`. Then within `gsfe-2/`,

- execute `build_jobs.sh`
- edit 65 `lmp_gsfe.in` files
- execute `submit_jobs.sh`
- wait until all simulations are finished
- execute `post_jobs.in`.

Another `gamma.txt` file is then generated, which is the GSFE surface on the second shift plane.

Follow the procedures above to generate 18 more `gamma.txt` files in `gsfe-3/`, `gsfe-4/`, ..., `gsfe-20/`, respectively.

Eventually, we obtain 20 `gamma.txt` files, i.e., 20 GSFE surfaces. We then use the file `0/gsfe` in each directory `gsfe-XXX` to calculate 20 intrinsic stacking fault energies (ISFEs). Determine the maximum, minimum, and two mediam ISFE values. Let's assume that they are in the `gsfe-9`, `gsfe-15`, `gsfe-8`, and `gsfe-0` directories, respectively. Then we can use one or more of these four files, `gsfe-9/gamma.txt`, `gsfe-15/gamma.txt`, `gsfe-8/gamma.txt`, and `gsfe-0/gamma.txt`, in PFDD simulations, depending on what we want to study. For example, [Xu et al.](http://dx.doi.org/10.1016/j.cma.2021.114426) used the minimum and medium GSFE surfaces to study dislocations in a series of Cu-Nb alloys.

## LSR

Calculate the LSR of both edge and screw dislocations at 0 K. The atomsk scripts that are used to build the atomistic structures as well as the LAMMPS input files for the LSR calculations, can be found in the `lsr/` directory in this GitHub repository.

Note: two methods are independently used to build the edge dislocation, hence `build_edge1.sh` and `build_edge2.sh`. They correspond to the "remove a half-plane below the glide plane" method and the "superimposing two crystals" method on [this page](https://atomsk.univ-lille.fr/tutorial_Al_edge.php), respectively. It is found that the two methods lead to the same dislocation structure after energy minimization in Ni, but not in the MPEA.

Calculations follow [a previous GitHub repository](https://github.com/shuozhixu/FLAM2020-LSR) and [its associated paper](http://dx.doi.org/10.1016/j.ijplas.2021.103157). 20 LSR are calculated for an edge and a screw dislocation, respectively, due to the randomness of elements.

## Dislocation glide and dislocation/obstacle interactions

Calculate the glide of and an obstacle interacting with both edge and screw dislocations at 5 K. The atomsk scripts that are used to build the atomistic structures as well as the LAMMPS input files for the LSR calculations, can be found in the `glide/` directory in this GitHub repository.

Calculations follow [a previous GitHub repository](https://github.com/wrj2018/MSMSE_2020). Consider both edge and screw dislocations and three types of obstacles: void, B2 precipitate, and L1<sub>2</sub> precipitate. Let the obstacle radius be 0.6 nm, 1.2 nm, 2.4 nm, 3.6 nm, and 4.8 nm, respectively. Read [these papers](https://drive.google.com/drive/folders/1Pfg0ZztTd7QkhRMLABwpwrZFWDxasoBQ?usp=sharing) which are on dislocatino/obstacle interactions in metals using atomistic simulations.

Answer two questions:

1. how is the standard deviation in dislocation/obstacle interaction strength compared with that in LSR?
2. how does the orientation of the crystalline precipitates affect the dislocation bypassing stress? Is it possible that, for some orientations, the bypassing stress for a precipitate is larger than that for a void?

## Discussion

Elastic constants, LSR, and dislocation/precipitate interactions can be used directly in the CPFEM model. However, [experiments](https://doi.org/10.1016/j.actamat.2022.118600) showed that a typical B2 and L1<sub>2</sub> precipitate, respecitvely, has a diameter of 20--100 nm and 10--80 nm, beyond what are commonly modeled in atomistic simulations. Therefore, we will only use elastic constants and LSR in our CPFEM work.
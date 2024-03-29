[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.8025049.svg)](https://doi.org/10.5281/zenodo.8025049)

## Introduction

This repository accompanies the McMillan et al. (2023) paper in Geophysical Research Letters (https://doi.org/10.1029/2023GL103996) and mainly consists of deal.II paramter files for the ASPECT geodynamic modelling software. The source code for all of the models discussed in the journal article are contained in this repository.

## Inputs

Model variants are contained in the `models` directory and are broken into two phases.
While `v0.prm` is a complete parameter file, the others are written to be merged together with `v0.prm` in order to produce complete models.

The base model (both phases) can be run as follows:
```bash
mpirun -np 10 /home/dealii/aspect/aspect-release models/v0.prm
wait
mpirun -np 10 /home/dealii/aspect/aspect-release models/v0-phase-2.prm
```

### run-tag

The `run-tag` script is provided for running variant models. 

Basic usage is: `./run-tag <model variant tag> <path to ASPECT> <low-res flag?>`

As an example, model `v2.1` can be run as follows:

`./run-tag v2.1 /home/dealii/aspect/aspect-release`

This will run both phases of the model. The debug build of ASPECT can be used by passing it as the path. 

Note that the `run-tag` script was originally written to be used by the SLURM scheduler, which does not support the `-np` argument to `mpirun`. Therefore, the scripts will only run on 1 CPU process by default. To utilize more processes, edit `run-tag` manually by changing both instances of `mpirun ...` to e.g., `mpirun -np 20 ...` to use 20 cores.

### Low/high-resolution runs

For running on personal machines with few cores, a `low-res.prm` parameter file is provided, which reduces the spatial resolution of the model. This can be utilized by passing the `-l` flag, as follows:

`./run-tag v2.1 /home/dealii/aspect/aspect-release -l`

This will automatically merge the `low-res.prm` file in with whatever model variant is passed as a tag. Conversely, a high resolution version is provided with `high-res.prm` through the `-h` tag, which doubles the spatial resolution.

### run-all

The `run-all` script simply loops through all the model variant tags `v0...v10.3` and passes them to `run-tag`.

Note that it is necessary to modify the file permissions for each script to enable them to be executed, e.g., `chmod +x ./run-tag`. If using Docker, this should be done on the host machine (or inside of WSL in Windows) before building the Docker container.

The file `generate-particcle-data.sh` generates a text file with particle coordinates located throughout the crust, but particles were not used in the published models.

## Docker

The `Dockerfile` that was originally used to build the models is provided. This file is based on a specific version of deal.II and builds ASPECT from the tag `08b6a15`, so the models are fully reproducible.
For VS Code users, a `devcontainer.json` is provided.

## Outputs

All output files are stored in the model's corresponding `output-*\` subdirectories, e.g., `output-v2.1\` or `output-low-res-v2.1\`

The ParaView state file used to create the visualizations for the paper is provided (`drip.pvsm`). To use it, launch ParaView and choose `File > Load State...` and navigate to the `drip.pvsm` file, select it, and click OK. Unfortunately, ParaView only supports absolute paths to locate the `solution.pvd` file. To work around this, select `Choose file names` from the drop-down box, and browse to the output folder you wish to visualize, e.g., `output-v2.1`, and select the `solution.pvd` file within it. After selecting OK, the solution file and several data filters should be displayed in the pipeline browser.

## Running on SciNet/Niagara

The Slurm script used to run the models on SciNet/Niagara cluster is provided as `slurm-run-tag`. This script takes the model variant tags from the Slurm task array, allowing the user to choose which model variants to run on the cluster. For example, to run models `v2.1`, `v2.2`, and `v2.3`, one can pass `--array=21,22,23` to Slurm. The script defaults to `v0` if no array jobs are specified.

## Reporting bugs

These files were copied and cleaned up from a working repository. I may have missed something or introduced minor typos. Please open an issue in this repository in the event of bugs or issues running the code.

## Introduction

This repository accompanies the McMillan et al. (2023) paper submitted to Geophysical Research Letters (https://doi.org/10.1002/2023GL103996) and mainly consists of deal.II paramter files for the ASPECT geodynamic modelling software. The source code for all of the models discussed in the journal article are contained in this repository.

## Inputs

Model variants are contained in the `models` directory and are broken into two phases.
While `v0.prm` is a complete parameter file, the others are written to be merged together with `v0.prm` in order to produce complete models.

The base model (both phases) can be run as follows:
```bash
mpirun -np 10 /home/dealii/aspect/aspect-release models/v0.prm
wait
mpirun -np 10 /home/dealii/aspect/aspect-release models/v0-phase-2.prm
```

The `run-tag` script is provided for running variant models. 

Basic usage is: `./run-tag.sh <model variant tag> <path to ASPECT> <low-res flag?>`

As an example, model `v2.1` can be run as follows:

`./run-tag.sh v2.1 /home/dealii/aspect/aspect-release`

This will run both phases of the model. The debug build of ASPECT can be used by passing it as the path. For running on personal machines with few cores, a `low-res.prm` parameter file is provided, which reduces the spatial resolution of the model. This can be utilized by passing the `-l` flag, as follows:

`./run-tag.sh v2.1 /home/dealii/aspect/aspect-release -l`

This will automatically merge the `low-res.prm` file in with whatever model variant is passed as a tag.


The `run-all` script simply loops through all the model variant tags `v0...v9.3` and passes them to `run-tag`.

The file `generate-particcle-data.sh` generates a text file with particle coordinates located throughout the crust, but particles were not used in the published models.

## Docker

The `Dockerfile` that was originally used to build the models is provided. This file is based on a specific version of deal.II and builds ASPECT from the tag `08b6a15`, so the models are fully reproducible.

## Outputs

All output files are stored in the model's corresponding `output-*\` subdirectories, e.g., `output-v2.1\` or `output-low-res-v2.1\`

## Running on SciNet/Niagara

The Slurm script used to run the models on SciNet/Niagara cluster is provided as `slurm-run-tag.sh`. This script takes the model variant tags from the Slurm task array, allowing the user to choose which model variants to run on the cluster. For example, to run models `v2.1`, `v2.2`, and `v2.3`, one can pass `--array=21,22,23` to Slurm. The script defaults to `v0` if no array jobs are specified.


## Reporting bugs

These files were copied and cleaned up from a working repository. Therefore I may have missed something or introduced minor typos. Please open an issue in this repository in the event of bugs or issues running the code.

#!/bin/bash
#SBATCH --job-name=tiler			            		# job name
#SBATCH --output=out.log						# output file
#SBATCH --time=1-00:00:00						# max run time - HH:MM:SS 
#SBATCH --chdir=/projects/gurney_lab/Group_members/Geoff/leaflet/	# work directory
#SBATCH --mem=16GB							# GB of memory
#SBATCH --cpus-per-task=1						# number of cpus

# load  modules
module load R/3.5.2

# run  application, precede the application command with srun
srun Rscript /projects/gurney_lab/Group_members/Geoff/leaflet/make_tiles.R

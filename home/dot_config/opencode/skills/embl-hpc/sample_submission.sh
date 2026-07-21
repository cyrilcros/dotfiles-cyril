#!/bin/bash

#SBATCH -t 10:00:00
#SBATCH --job-name vscode
#SBATCH --mem=32G
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --cpus-per-task=32
#SBATCH --output /g/arendt/Cyril/bioinformatics/cluster/vscode_out.txt
#SBATCH --error /g/arendt/Cyril/bioinformatics/cluster/vscode_err.txt

sleep 10h

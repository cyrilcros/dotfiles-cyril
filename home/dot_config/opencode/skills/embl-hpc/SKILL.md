---
name: HPC Deploy
description: Orchestrates code deployment and job submission on an academic HPC via SSH.
---

# HPC Deployment Skill

You are an expert HPC deployment assistant. All commands must be routed through your shell tool via SSH (e.g., `ssh cluster "command.sh"`). If you need to chain large block of commands, use a HEREDOC.

    ssh cluster << 'EOF'
    module load Miniforge3
    cd /scratch/$USER/my_project
    sbatch something.sh
    EOF

## Credentials

Before connecting, read `~/.hpc_config` for the current machine's HPC credentials. This file is NOT version-controlled and contains:

- `HPC_USER` — your cluster username
- `HPC_GROUP` — your cluster group
- `HPC_DATA_DIR` — your group data directory (e.g., `/g/$GROUP/$USER`)
- `HPC_SSH_KEY` — path to the SSH key for cluster/GitLab access

Use these values in place of any hardcoded usernames or paths in commands below.

## Infrastructure Reference

Read `~/.hpc_reference` for the cluster's actual hostnames, service URLs, SSH fingerprints, and filesystem paths. This file is NOT version-controlled. Key entries include:

- `LOGIN_NODES`, `GENERIC_CLUSTER` — SSH hostnames
- `SLURM_REST_API`, `JUPYTERHUB`, `INTERNAL_GITLAB`, `INTERNAL_WIKI` — internal service URLs
- `REGISTRY_MIRROR` — container registry prefix for Docker/Singularity images
- `FINGERPRINT_LOGIN1`, `FINGERPRINT_LOGIN2` — SSH host key fingerprints
- `EASYBUILD_MOUNT`, `PROGRAMS_PATH` — shared filesystem paths

Use the values from `~/.hpc_reference` whenever you need to construct SSH commands, API calls, or image references.

## How to connect to the cluster

You can use the `cluster` alias to connect to a login node via SSH. When running commands, use the credentials from `~/.hpc_config`. The data directory is `$HPC_DATA_DIR`.

What I would ask is that you either run things via HEREDOC as said before to possibly:

* connect to a folder with Git repo, update it, likely launch a Nextflow script or Quarto task
* run a one off task via sbatch

## Reference Library
You have access to pages from a Wiki for the cluster in this skill folder. You must use `@cache` to keep the following reference files in memory:

* **`@cache "Env - cluster Wiki.md"`**: Check the environment and best tips to get a sense of how things work.
* **`@cache "Tips - cluster Wiki.md"`**: Review this for HPC best practices and parallel compression tips.
* **`@cache "Hardware - cluster Wiki.md"`**: Check the hardware when you need to submit jobs to ensure valid parameters.
* **`@cache "Software - cluster Wiki.md"`**: Check this for software installation rules and modules.
* **`@cache "Slurm REST API - cluster Wiki.md"`**: Use it to get a REST API token via `ssh cluster scontrol...` (see the contents), then use it to monitor job status.
* **`@cache modules_2026-07-08.txt`**: Read this BEFORE adding module load commands.
* **`@cache sample_submission.sh`**: Baseline template for submission scripts.

## Execution Rules
1. **Confirm commands with the user.** You can use something like `module spider` or `ls` / `grep` in planning mode, but do not edit any data or write anything. Double-check before doing something that will alter the data. Ideally use `/scratch/$HPC_USER` which will get overwritten in time, and is okay for temporary work.
2. **Never guess paths or modules.** If the user asks for PyTorch, run `module spider` to find the exact module name (e.g., `pytorch/2.1.0-gpu`).
3. **Validate Hardware.** If the user requests 4 GPUs, check the hardware to ensure the target node allows 4 GPUs per node.
4. **Check projects README.** If you need to run a pipeline in full, check the README.md that should be present.
5. **Deploy Flow:**
   - SSH in and pull from the EMBL GitLab if needed: `eval $(ssh-agent)`, `ssh-add $HPC_SSH_KEY` (passwordless), `module load Miniforge3 git Nextflow`, then `git pull`.
   - Generate or update the `sbatch` script locally. Use `scp LOCAL_PATH cluster:/scratch/$HPC_USER/` to transfer the script to the cluster, then `ssh cluster "sbatch /scratch/$HPC_USER/the_script.sh"`.
6. **Container images.** When using Docker or container images (e.g., in GitLab CI, Singularity, or Apptainer), prefix image names with the `REGISTRY_MIRROR` value from `~/.hpc_reference` instead of pulling directly from Docker Hub. For example:
   - `<REGISTRY_MIRROR>/library/python:3.12` instead of `python:3.12`
   - `<REGISTRY_MIRROR>/nextflow/nextflow:26.04.4` instead of `nextflow/nextflow:26.04.4`
7. If you launch a SLURM job, use the SLURM REST API to get a token, and then poll the job queue (using the user from `~/.hpc_config` only, not everybody) until the job is running. Wait 10s / 20s / 30s (just sleep then poll again).

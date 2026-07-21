#!/usr/bin/env bash
set -euo pipefail

query=${1:-"How do I configure Nextflow to use AWS Batch?"}
seqera ai --headless "$query"

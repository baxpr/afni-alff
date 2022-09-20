#!/usr/bin/env bash
docker run \
    --mount type=bind,src=`pwd -P`/INPUTS,dst=/INPUTS \
    --mount type=bind,src=`pwd -P`/OUTPUTS,dst=/OUTPUTS \
    baxterprogers/afni-alff:v1.0.0-beta1 \
    --mask_niigz /INPUTS/rwmask.nii.gz \
    --fmri_niigz /INPUTS/filtered_removegm_noscrub_wadfmri.nii.gz \
    --bplo_hz 0.01 \
    --bphi_hz 0.10 \
    --out_dir /OUTPUTS

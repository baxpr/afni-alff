#!/usr/bin/env bash

# Given a brain mask and a preprocessed fMRI image time series,
# compute some ALFF images.

# Defaults
export mask_niigz=/INPUTS/rwmask.nii.gz
export fmri_niigz=/INPUTS/wremovegm.nii.gz
export bplo_hz=0.01
export bphi_hz=0.10
export out_dir=/OUTPUTS

# Command line overrides
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in        
        --mask_niigz)
            export mask_niigz="$2"; shift; shift ;;
        --fmri_niigz)
            export fmri_niigz="$2"; shift; shift ;;
        --bplo_hz)
            export bplo_hz="$2"; shift; shift ;;
        --bphi_hz)
            export bphi_hz="$2"; shift; shift ;;
        --out_dir)
             export out_dir="$2"; shift; shift ;;
         *)
             echo "Input ${1} not recognized"
             shift ;;
     esac
 done

 # Compute ALFF etc
3dRSFC -nosat -nodetrend -mask "${mask_niigz}" \
    -prefix /OUTPUTS/rsfc 0.01 0.10 "${fmri_niigz}"

# Normalizing factors
mean_alff=$(3dmaskave -mask "${mask_niigz}" /OUTPUTS/rsfc_ALFF+tlrc.HEAD)
mean_falff=$(3dmaskave -mask "${mask_niigz}" /OUTPUTS/rsfc_fALFF+tlrc.HEAD)
echo Mean ALFF ${mean_alff}
echo Mean fALFF ${mean_falff}

# Normalize
3dcalc -a /OUTPUTS/rsfc_ALFF+tlrc.HEAD -expr "a / ${mean_alff}" \
    -prefix /OUTPUTS/rsfc_ALFF_norm
3dcalc -a /OUTPUTS/rsfc_fALFF+tlrc.HEAD -expr "a / ${mean_falff}" \
    -prefix /OUTPUTS/rsfc_fALFF_norm


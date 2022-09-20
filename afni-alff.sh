#!/usr/bin/env bash

3dRSFC -nosat -nodetrend -mask /INPUTS/rwmask.nii.gz \
    -prefix /OUTPUTS/wremovegm 0.01 0.10 /INPUTS/wremovegm.nii.gz

gm=$(3dmaskave -mask /INPUTS/rwmask.nii.gz /OUTPUTS/wremovegm_ALFF+tlrc.HEAD)
echo GM $gm
3dcalc -a /OUTPUTS/wremovegm_ALFF+tlrc.HEAD -expr "a / ${gm}" \
    -prefix /OUTPUTS/wremovegm_ALFF_norm

fgm=$(3dmaskave -mask /INPUTS/rwmask.nii.gz /OUTPUTS/wremovegm_fALFF+tlrc.HEAD)
echo FGM $fgm
3dcalc -a /OUTPUTS/wremovegm_fALFF+tlrc.HEAD -expr "a / ${fgm}" \
    -prefix /OUTPUTS/wremovegm_fALFF_norm


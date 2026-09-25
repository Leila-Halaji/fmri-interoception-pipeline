# fMRI Preprocessing & Insula Connectivity Pipeline

## Dataset
ds003763 from OpenNeuro (https://openneuro.org/datasets/ds003763), 
subject sub-09113, heartbeat detection task fMRI. License: CC0.

Chosen because it uses the same interoceptive heartbeat-detection 
paradigm central to the PhD project I am applying to.

## Pipeline
Preprocessing performed in SPM12 (MATLAB): realignment, slice-timing 
correction, coregistration, segmentation, normalization to MNI space, 
and smoothing (6mm FWHM).

Seed-based functional connectivity (anterior insula seed, MNI 
coordinates -38, 20, -8) computed in CONN toolbox (denoising with 
motion regression, aCompCor, bandpass filter 0.008-0.09 Hz).

## Note
This is a single-subject descriptive analysis demonstrating the 
technical pipeline, not a group-level statistical inference 
(not computable with n=1).

## Tools
SPM12, CONN22.a, MATLAB R2024a

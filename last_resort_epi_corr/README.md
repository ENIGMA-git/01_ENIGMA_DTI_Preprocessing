# Correct for EPI induced susceptibility artifacts — this is particularly an issue at higher magnetic fields.
* If you have two opposing b0s and a sufficient amount of diffusion directions obtained, you may use FSL’s TOPUPand EDDY for distortion correction.
* If a fieldmap has been collected along with your data, FSL’s FUGUE tool may help compensate for the distortions.
* Alternatively, a subject’s DWI images can be adjusted through high dimensional warping of the b0 to a high-resolution structural (T1- or T2- weighted) image of the same subject not acquired using EPI. This requires multiple steps:
    * _Make sure skull-stripping has been performed on both b0 and T1-weighted scans._
    * _Make sure T1-weighted scans have undergone inhomogeneity (NU) correction._
    * _Make sure T1-weighted scans and the DWI are aligned!! Check for L/R flipping!!_
    * _Linear registration of b0 of DWI and T1-weighted reference together. **Due to differences in resolution and further registrations needed throughout the workflow we recommend initially aligning the the T1-weighted scans to ICBM space (which is the space of the ENIGMA-DTI template), then using a linear registration (with NO sheering parameters) to align your b0 maps to their respective T1-weighted scans in ICBM space**_
    * _If using FSL’s flirt for linear registration, sheering can be avoided by manually setting the degrees of freedom (default 12) to 9 (flirt -in b0.nii.gz -out b02T1w.nii.gz -df 9 -ref T1w.nii.gz)_
    * _Once images are in the same space and linearly alight (visually check this!), you can perform non-linear registrations to remove the distortion from the b0._
    * _Some possible tools include ANTS , DTI-TK, or BrainSuite._
    * _The deformation fields from the warping should then be applied to all volumes in the DWI._


Example usage:

         enigma_epi_correct_commandLine.sh b0.nii.gz t1_to_b0.nii.gz dwi.nii.gz output_folder output_name
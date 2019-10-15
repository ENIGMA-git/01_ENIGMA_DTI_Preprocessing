# Preprocessing
By preprocessing, we are referring to converting your images from the raw DICOM to FA images for each subject and quality controlling along the way to remove scans with abnormalities and artifacts.There can be several ways to pre-process your diffusion weighted data in order to maximize the quality and efficiency of your processing.
We will therefore not require a specific protocol to be followed with any particular software, as long as the appropriate steps are performed. This will allow maximal integration with current pipelines and ensure optimal processing per site if available, and allow sites to:

1. Process data efficiently with respect to acquisition parameters (eg., do not spend time on HARDI-specific algorithms if you only have 6/12 directions collected)
2. Take advantage of your scanning protocols
    * if you know you can calculate FA more robustly using one of many alternate methods, go for it!
    * maximize the quality for your scans (denoising/ removing artifacts etc.)
3. Keep things in line with current/future projects, and non ENIGMA-related investigations you are working on.

If you have FA measures maps calculated and registered already, we can work with you to include them into the Pipeline rather than to re-run everything from the start. Therefore, if you have discovered workflows and methods that fit your data well to best improve SNR, this would be ideal.

If you have already processed your data, please email support.enigmaDTI@ini.usc.edu to let us know your processing workflow. Also if you would like to update this page with any particulars for your methods, please let us know and we would be happy to work in additional options.
For those that have yet to process DTI data, various suggestions are outlined here. A basic series of steps are as follows: NOTE: most of this can be done in multiple ways depending on your data. please do not hesitate to contact us for support .

### Convert DICOM images to DWI set and T1-weighted set and other data acquired.
* Determine how your DWI set(s) are organized
* How many many acquisitions do you have? Multiple acquisitions can be merged for optimal signal-to-noise ratio.
* How many b0s do you have and where are they with respect to the full series? (Often the b0 image(s) is/are the first volumes in the DWI set)
* If you have multiple b0, were they acquired with the same encoding gradient? If not, slight variations in processing will be needed.

### Denoising

### Degibbs

### Correct for Eddy Current distortions, movement using affine registration
* A convenient option for this is FSL’s [eddy](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy/UsersGuide) command.
* You can use [this script] to rotate your bvec files (gradient directions) after using FSL’s “eddy_correct” command. (You can use the output of the file from now on and to create your FA images (e.g. as input to [dtifit](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FDT/UserGuide#DTIFIT))

### Create a mask for your data.
* FSL’s bet2 offers a solution that is quite robust for many datasets.
* MRtrix dwi2mask

###  N4 bias field correction

### Correct for EPI induced susceptibility artifacts — this is particularly an issue at higher magnetic fields. (if you only have one phase encoding direction)
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

### Calculate tensors (this can be done in multiple ways depending on your data).
* Most tools will also output FA, MD, and eigenvalue and vector maps simultaneously.
* FSL’s ‘dtifit’ command is an acceptable and convenient option. It uses least-square fitting to determine the tensor and will output FA and V1 (primary eigenvector) needed for future analyses.   







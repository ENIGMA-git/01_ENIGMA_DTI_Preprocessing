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
There are several different denoising methods that can be appropriately used for the data you have. A few of them are listed below. NOTE: *This is the first step that needs to be taken after dicom to nifti conversion.*
Before deciding on which method, you will need to check 
 * Whether or not the data acquired was zero-filled at acquisition (typically done on GE scanners). If it is, LPCA will not work effectively and consideration of AONLM/MP-PCA filters may be a better choice

A few of the different denoising methods include:
 * LPCA
    * _"takes into consideration the multicomponent nature of multi-directional DWI datasets such as those employed in diffusion imaging and reduces random noise in multicomponent DWI by locally shrinking less significant Principal Components using an overcomplete approach [[Manjón et al., 2013]](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0073021)."_
        * download located [here](https://drive.google.com/file/d/0B9aYHyqVxr04aEpobURaZFhNTmM/edit) and filter documentation located [here](https://sites.google.com/site/pierrickcoupe/softwares/denoising-for-medical-imaging/dwi-denoising/dwi-denoising-software)   
 * AONLM
    * _"designed for spatially varying noise typically presents in parallel imaging, information regarding the local image noise level is used to adjust the amount of denoising strength of the filter [[Manjón et al., 2011]](https://www.hal.inserm.fr/inserm-00454564/en/)."_
        * download located [here](https://drive.google.com/file/d/0B9aYHyqVxr04aEpobURaZFhNTmM/edit) and filter documentation located [here](https://sites.google.com/site/pierrickcoupe/softwares/denoising-for-medical-imaging/dwi-denoising/dwi-denoising-software)    
* MP-PCA
    * _"exploits the intrinsic redundancy in diffusion MRI using universal properties of the eigenspectrum of random covariance matrices, and removes noise-only principal components -- thereby enabling signal-to-noise ratio enhancements [[Veraart et al., 2016]](https://www.ncbi.nlm.nih.gov/pubmed/27523449)."_
        * code located [here](https://github.com/sunenj/MP-PCA-Denoising) and an MRtrix wrapper is also available called [dwidenoise](https://mrtrix.readthedocs.io/en/latest/reference/commands/dwidenoise.html)


###### add images for each step maybe?

### Gibbs ringing artifact correction
Gibbs-ringing is an artifact that is often displayed in MRI images as spurious oscillations nearby sharp image gradients at tissue boundaries. This can be corrected using the method of local subvoxel-shifts proposed by [Kellner et al., 2015](https://www.ncbi.nlm.nih.gov/pubmed/26745823).

* You can correct your data using the original code -- [unring](https://bitbucket.org/reisert/unring/src/master/), or MRtrix's wrapper implementation [mrdegibbs](https://mrtrix.readthedocs.io/en/latest/reference/commands/mrdegibbs.html)
  
_Notes:_
  * Should be performed directly after denoising and before any other preprocessing steps
  * This method was developed to work on images acquired with full k-space coverage
    * "...partial Fourier acquisition demonstrates that incomplete k‐space acquisition schemes propagate the artifact in an obscure nonobvious manner, which might lead to a misinterpretation of image features"
    * Therefore it is imperative to check your data. You can find this information regarding partial k-space coverage in the DICOM tuple [(0018,0022)](http://dicomlookup.com/lookup.asp?sw=Tnumber&q=(0018,0022)) 

### Correct for Eddy Current distortions and movement
* A convenient option for this is FSL’s [eddy](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy/UsersGuide) command. [ADD MORE INFO HERE REGARDING TXT FILES NEEDED?]
* Additionally, MRtrix has a wrapper for this called [dwipreproc](https://mrtrix.readthedocs.io/en/latest/reference/scripts/dwipreproc.html)
* HD-BET?

### Create a mask for your data.
* FSL’s bet2 offers a solution that is quite robust for many datasets.
* Additionally, MRtrix's [dwi2mask](https://mrtrix.readthedocs.io/en/latest/reference/commands/dwi2mask.html) command utilizes directional information to generate a mask that may offer a better option for your data

### Bias field correction
Often times, data is affected by B1 field inhomogeneity resulting in signal intensity differences throughout the image. A DWI series can be corrected for this using:
* [ANTs](https://www.ncbi.nlm.nih.gov/pubmed/?term=%22N4%22+AND+%22Tustison+N4ITK%22) or [FSL FAST](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FAST)
* There is also a DWI wrapper for these two options using MRtrix called [dwibiascorrect](https://mrtrix.readthedocs.io/en/latest/reference/scripts/dwibiascorrect.html)

_Note: (explain how an iterative N4/mask process might be helpful here)_

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

# Preprocessing Quality Control
#### Protocol for FA and vector alignment QC analysis for ENIGMA-DTI 
The following steps will allow you to visualize your raw FA images before registration to the ENIGMA-DTI template, and to see if your principle direction vectors are appropriately aligned to the white matter tracts.

These protocols are offered with an unlimited license and without warranty. However, if you find these protocols useful in your research, please provide a link to the ENIGMA website in your work: www.enigma.ini.usc.edu

Highlighted portions of the instructions may require you to make changes so that the commands work on your system and data. 

* _Prerequisites_
    * [Matlab](http://www.mathworks.com/products/matlab/) installed
    * Diffusion-weighted images preprocessed using [FSL’s DTIFIT](http://fsl.fmrib.ox.ac.uk/fsl/fsl4.0/fdt/fdt_dtifit.html) or equivalent. This requires the creation of FA maps and eigenvectors comprising of three volumes, the first being the x-component of the eigenvector, the second being the y-component and the third being the z-component.

##### Step 1 – Download the utility packages
* Download the matlab package for Step 3 made available in this repository titled "enigmaDTI_QC"
* Download the script(mac: make_enigmaDTI_FA_V1_QC_webpage_mac.sh), linux: make_enigmaDTI_FA_V1_QC_webpage.sh) to build the QC webpage for Step 4

##### Step 2 – Build a text file defining the location of subject files
* Create a three column tab-delimited text file (e.g. Subject_Path_Info.txt):
    * subjectID: subject ID
    * FAimage: full path to original FA image.
    * V1image: full path to original V1 image. This is a 4D volume that represents the primary eigenvector of the diffusion tensors at every voxel (i.e. x-component of the eigenvector).

      |  subjectID    |          FAimage              |            V1image            |
      | ------------- |:-----------------------------:| -----------------------------:|
      | USC_01        | /path/to/FA/USC_01_FA.nii.gz  | /path/to/V1/USC_01_V1.nii.gz  |
      | USC_02        | /path/to/FA/USC_02_FA.nii.gz  | /path/to/V1/USC_02_V1.nii.gz  |
      | USC_03        | /path/to/FA/USC_03_FA.nii.gz  | /path/to/V1/USC_03_V1.nii.gz  |
      
#### Step 3 – Run Matlab script to make QC images
* Unzip the Matlab scripts from Step 1 and change directories to that folder with the required Matlab *.m scripts. For simplicity, we assume you are working on a Linux machine with the base directory /enigmaDTI/QC_ENIGMA/.

* Make a directory to store all of the QC output:

        mkdir /enigmaDTI/QC_ENIGMA/QC_FA_V1/ 

* Start Matlab:

         /usr/local/matlab/bin/matlab

Next we will run the func_QC_enigmaDTI_FA_V1.m script that reads the Subject_Path_Info.txt file to create subdirectories in a specified output_directory for each individual subjectID, then create an axial, coronal and sagittal image of the FA_image with vectors from the V1_image overlaid on top. The threshold (0 to ~0.3, default 0.2) overlay the V1 information only on voxels with FA of the specified threshold or greater. Increasing the threshold above 0.1 will run the script faster and is recommended for groups with many subjects.

* In the Matlab command window paste and run:
     
        TXTfile='/enigmaDTI/QC_ENIGMA/Subject_Path_Info.txt';
        output_directory='/enigmaDTI/QC_ENIGMA/QC_FA_V1/';
        thresh=0.2;
        [subjs,FAs,VECs]=textread(TXTfile,'%s %s %s','headerlines',1)
        
        for s = 1:length(subjs) 
        subj=subjs(s);
        Fa=FAs(s);
        Vec=VECs(s);
        try
        % reslice FA
        [pathstrfa,nameniifa,gzfa] = fileparts(Fa{1,1});
        [nafa,namefa,niifa] = fileparts(nameniifa);
        newnamegzfa=[pathstrfa,'/',namefa,'_reslice.nii.gz'];
        newnamefa=[pathstrfa,'/',namefa,'_reslice.nii'];
        copyfile(Fa{1,1},newnamegzfa);
        gunzip(newnamegzfa);
        delete(newnamegzfa);
        reslice_nii(newnamefa,newnamefa);
        
        % reslice V1
        [pathstrv1,nameniiv1,gzv1] = fileparts(Vec{1,1});
        [nav1,namev1,niiv1] = fileparts(nameniiv1);
        newnamegzv1=[pathstrv1,'/',namev1,'_reslice.nii.gz'];
        newnamev1=[pathstrv1,'/',namev1,'_reslice.nii'];
        copyfile(Vec{1,1},newnamegzv1);
        gunzip(newnamegzv1);
        delete(newnamegzv1);
        reslice_nii(newnamev1,newnamev1);
        
        % qc
        func_QC_enigmaDTI_FA_V1(subj,newnamefa,newnamev1, output_directory);
        
        close(1)
        close(2)
        close(3)
        
        % delete
        delete(newnamefa)
        delete(newnamev1)
        end
        
        display(['Done with subject: ', num2str(s), ' of ', num2str(length(subjs))]);
        
        end

For troubleshooting individual subjects that func_QC_enigmaDTI_FA_V1.m script can be run in the command console with the following parameters:
``` func_QC_enigmaDTI_FA_V1('subjectID', 'FA_image_path', 'V1_image_path','output_directory') ```

##### Step 4 - Make the QC webpage
Within a terminal session go to the /enigmaDTI/QC_ENIGMA/ directory where you stored the script make_enigmaDTI_FA_V1_QC_webpage.sh and ensure it is executable:
    
    chmod 777 make_enigmaDTI_FA_V1_QC_webpage.sh

or for mac:
    
    chmod 777 make_enigmaDTI_FA_V1_QC_webpage_mac.sh
    
Run the script, specifying the full path to the directory where you stored the Matlab QC output files:

    ./make_enigmaDTI_FA_V1_QC_webpage.sh /enigmaDTI/QC_ENIGMA/QC_FA_V1/ 
    
or for mac:
    
    sh make_enigmaDTI_FA_V1_QC_webpage_mac.sh /enigmaDTI/QC_ENIGMA/QC_FA_V1/
    
This script will create a webpage called enigmaDTI_FA_V1_QC.html in the same folder as your QC output. To open the webpage in a browser in a Linux environment type:

    firefox /enigmaDTI/QC_ENIGMA/QC_FA_V1/enigmaDTI_FA_V1_QC.html
    
Scroll through each set of images to check that the vector directions are correct. For closer inspection, clicking on a subject’s preview image will provide a larger image. If you want to check the segmentation on another computer, you can just copy over the whole /enigmaDTI/QC_ENIGMA/QC_FA_V1/ output folder to your computer and open the webpage from there.

(ADD IMAGES HERE)

Congrats! Now you should have all you need to make sure your FA images turned out OK and their vector fields are aligned!

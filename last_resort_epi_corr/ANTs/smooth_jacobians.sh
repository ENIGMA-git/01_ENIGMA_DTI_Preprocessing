#!/bin/bash
#$ -S /bin/bash
#$ -o /ifs/loni/faculty/njahansh/ENIGMA/vGWAS/MULTI_TEMPLATES/BP/multi_channel/log/ -j y  ###### Path to your own log file directory

export PATH=/usr/local/ANTs/bin/:$PATH
export ANTSPATH=/usr/local/ANTs/bin/

#197
SUBJECT=(C_1 C_2 C_3 C_4 C_5 C_6 C_7 C_8 C_9 C_10 C_11 C_12 C_13 C_14 C_15 C_16 C_17 C_18 C_19 C_20 C_21 C_22 C_23 C_24 C_25 C_26 C_27 C_28 C_29 C_30 C_31 C_32)


subj=${SUBJECT[${SGE_TASK_ID}-1]}

echo $subj

workingDir=/ifs/loni/faculty/njahansh/ENIGMA/vGWAS/MULTI_TEMPLATES/rotterdam/single_channel/

#If not created yet, let's create a new output folder
if [ ! -d $workingDir ]
then
   echo "dir did not exist, so making it yo."
   echo ""
   mkdir -p $workingDir
fi

#if [[ ! -e ${workingDir}${subj}_log_geo_jacobian.nii.gz ]] 
#then 
	
#	dirO=/ifs/loni/faculty/njahansh/ENIGMA/vGWAS/MULTI_TEMPLATES/rotterdam/multi_channel/
#	mkdir -p ${dirO}

#	cp /ifshome/jfaskow/ADNI_2/all_adni2__mulit_reg/reg_to_MNIChannel/${subj}/reg2MNITemp_deformed.nii.gz ${dirO}${subj}_deformed.nii.gz 
#	cp /ifshome/jfaskow/ADNI_2/all_adni2__mulit_reg/reg_to_MNIChannel/${subj}/reg2MNITemp_log_geo_jacobian.nii.gz ${dirO}${subj}_log_geo_jacobian.nii.gz
#	cp /ifshome/jfaskow/ADNI_2/all_adni2__mulit_reg/reg_to_MNIChannel/${subj}/reg2MNITemp_log_jacobian.nii.gz ${dirO}${subj}_log_jacobian.nii.gz
#	cp /ifshome/jfaskow/ADNI_2/all_adni2__mulit_reg/reg_to_MNIChannel/${subj}/reg2MNITemp_multrans_log_geo_jacobian.nii.gz ${dirO}${subj}_multrans_log_geo_jacobian.nii.gz
#	cp /ifshome/jfaskow/ADNI_2/all_adni2__mulit_reg/reg_to_MNIChannel/${subj}/reg2MNITemp_multrans_log_jacobian.nii.gz ${dirO}${subj}_multrans_log_jacobian.nii.gz

#else
#	exit 0
#fi

#go into the folder where the script should be run and make the notes dir 
cd $workingDir

###########################################
###########################################



dirO=${workingDir}/smooth_jac_1p0/
mkdir -p ${dirO}
#SmoothImage ImageDimension image.ext smoothingsigma outimage.ext {sigma-is-in-spacing-coordinates-0/1} {medianfilter-0/1}
cmd="SmoothImage 3 ${workingDir}${subj}_log_geo_jacobian.nii.gz 1 ${dirO}${subj}_log_geo_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 
cmd="SmoothImage 3 ${workingDir}${subj}_multrans_log_geo_jacobian.nii.gz 1 ${dirO}${subj}_multrans_log_geo_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 
cmd="SmoothImage 3 ${workingDir}${subj}_log_jacobian.nii.gz 1 ${dirO}${subj}_log_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 
cmd="SmoothImage 3 ${workingDir}${subj}_multrans_log_jacobian.nii.gz 1 ${dirO}${subj}_multrans_log_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd


###########################################
###########################################

dirO=${workingDir}/smooth_jac_2p0/
mkdir -p ${dirO}
#SmoothImage ImageDimension image.ext smoothingsigma outimage.ext {sigma-is-in-spacing-coordinates-0/1} {medianfilter-0/1}
cmd="SmoothImage 3 ${workingDir}${subj}_log_geo_jacobian.nii.gz 2 ${dirO}${subj}_log_geo_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 
cmd="SmoothImage 3 ${workingDir}${subj}_multrans_log_geo_jacobian.nii.gz 2 ${dirO}${subj}_multrans_log_geo_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 
cmd="SmoothImage 3 ${workingDir}${subj}_log_jacobian.nii.gz 2 ${dirO}${subj}_log_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 
cmd="SmoothImage 3 ${workingDir}${subj}_multrans_log_jacobian.nii.gz 2 ${dirO}${subj}_multrans_log_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd


###########################################
###########################################

dirO=${workingDir}/smooth_jac_3p0/
mkdir -p ${dirO}
#SmoothImage ImageDimension image.ext smoothingsigma outimage.ext {sigma-is-in-spacing-coordinates-0/1} {medianfilter-0/1}
cmd="SmoothImage 3 ${workingDir}${subj}_log_geo_jacobian.nii.gz 3 ${dirO}${subj}_log_geo_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 
cmd="SmoothImage 3 ${workingDir}${subj}_multrans_log_geo_jacobian.nii.gz 3 ${dirO}${subj}_multrans_log_geo_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 
cmd="SmoothImage 3 ${workingDir}${subj}_log_jacobian.nii.gz 3 ${dirO}${subj}_log_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 
cmd="SmoothImage 3 ${workingDir}${subj}_multrans_log_jacobian.nii.gz 3 ${dirO}${subj}_multrans_log_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd





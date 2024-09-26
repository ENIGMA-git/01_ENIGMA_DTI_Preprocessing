#!/bin/bash
#$ -S /bin/bash
#$ -o /ifshome/$USER/log -j y 

#adapted from http://miykael.github.io/nipype-beginner-s-guide/ANTS.html

##################################################################################################################
####################################### EXPORT DAT PATH! #########################################################
##################################################################################################################
export PATH=/usr/local/ANTs/bin/:$PATH
export ANTSPATH=/usr/local/ANTs/bin/

##################################################################################################################
####################################### LETS SET SOME STUFF UP ###################################################
##################################################################################################################

# if you want to run this with the grid, you know how to define your subject stuff here

## bad subjects:
#MASKED: 12116011, 12116003,12104066 #12112006 # 12112010 #




#SUBJECT=(`cat /ifs/loni/faculty/njahansh/PREDICT/PROCESS/wk96/T1/T1_N3/N3_NII/NII_FLIPPED/subjectList_2014_10_21.txt`)
#subj=${SUBJECT[${SGE_TASK_ID}-1]}



#dirISS=/ifs/loni/faculty/njahansh/PREDICT/PROCESS/wk96/T1/T1_N3/N3_NII/NII_FLIPPED/Flirt_ANTS_MDT_SS_9p/
#dirISkull=/ifs/loni/faculty/njahansh/PREDICT/PROCESS/wk96/T1/T1_N3/N3_NII/NII_FLIPPED/Flirt_ANTS_MDT_Skull_9p/

#templateSS=/ifs/loni/faculty/thompson/four_d/Neda/PREDICT/arvin_predict/wk0/T1/MDT/ANTS/T1_over10_SS_n30/images/outputtemplate0.nii.gz 
#templateSkull=/ifs/loni/faculty/thompson/four_d/Neda/PREDICT/arvin_predict/wk0/T1/MDT/ANTS/T1_over10_Skull_n30/images/outputtemplate0.nii.gz 


#imageSS=${dirISS}/${subj}_T1_masked_N3_F2MDT_over10_9p.nii.gz
#imageSkull=${dirISkull}/${subj}_T1_N3_F2MDT_over10_9p.nii.gz


#dirI=$dirISS
#FIXED_IMAGE=$templateSS
#MOVING_IMAGE=$imageSS

##################################
MOVING_IMAGE=${1}
FIXED_IMAGE=${2}
outputDir=${3}
subj=${4}

workingDir=$outputDir/${subj}/
mkdir -p $workingDir


warp=${5} #dirI/ANTS_2MDT_over10/

type=${6} 

output=${workingDir}/${subj}_2MDT_${type}.nii.gz

mkdir -p ${workingDir}/LOGS/

	cmd="${ANTSPATH}/antsApplyTransforms -d 3 \
				--input ${MOVING_IMAGE} \
				--output ${output} \
				--reference-image ${FIXED_IMAGE} \
				--interpolation Linear \
				--transform ${warp}"
				
				
				
#I like to make my own logs of the commands I execute
OUT=${workingDir}/LOGS/notes_${subj}.txt


		echo $cmd #state the command
		echo $cmd >> $OUT
		eval $cmd #execute the command
		
		


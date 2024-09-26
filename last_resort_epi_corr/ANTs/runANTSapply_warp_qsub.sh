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

##################################
ATLASES=(brain1 brain2 brain3 brain4 brain5)
SUBJECTS=(Y1_C002 Y1_C009 Y1_C012 Y1_C023 Y1_C024 Y1_C025 Y1_C026 Y1_C027 Y1_C028 Y1_S202 Y1_S205 Y1_S206 Y1_S207 Y1_S208 Y1_S209 Y1_S210 Y1_S211 Y1_S212 Y1_S304 Y1_S307 Y1_S308 Y1_S309 Y1_S310 Y1_S311 Y1_S312 Y1_S313 Y2_S202 Y2_S205 Y2_S206 Y2_S208 Y2_S209)


dirI_base=/ifs/loni/faculty/njahansh/SCA_UMN/MAGeT_T1/myVersion/registrations/linear2oneSubjC002/
dirI=/ifs/loni/faculty/njahansh/SCA_UMN/MAGeT_T1/input/subjects/brains/

task=${SGE_TASK_ID}

let "s = task % 31 "
let "a = task % 5 "

subject=${SUBJECTS[$s]}
FIXED_IMAGE=${dirI}/${subject}.nii

atlas=${ATLASES[$a]}
MOVING_IMAGE=$dirI_base/${atlas}_labels_ds_lin.nii.gz

subj=${subject}_${atlas}





workingDir=/ifs/loni/faculty/njahansh/SCA_UMN/MAGeT_T1/myVersion/registrations/ANTS/labels2subjs/
workingDirS=$workingDir/${subj}/

output=${workingDirS}/warped_${atlas}_labels.nii.gz
warp=$workingDirS/${subj}0Warp.nii.gz

interpolation=NearestNeighbor

mkdir -p ${workingDir}/LOGS/

	cmd="${ANTSPATH}/antsApplyTransforms -d 3 \
				--input ${MOVING_IMAGE} \
				--output ${output} \
				--reference-image ${FIXED_IMAGE} \
				--interpolation ${interpolation} \
				--transform ${warp}"
				
				
				
#I like to make my own logs of the commands I execute
OUT=${workingDir}/LOGS/notes_${subj}.txt


		echo $cmd #state the command
		echo $cmd >> $OUT
		eval $cmd #execute the command
		
		


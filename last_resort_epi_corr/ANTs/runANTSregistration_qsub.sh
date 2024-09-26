#!/bin/bash
#$ -S /bin/bash

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
MOVING_IMAGE=$dirI_base/${atlas}_ds_lin.nii.gz

subj=${subject}_${atlas}

workingDir=/ifs/loni/faculty/njahansh/SCA_UMN/MAGeT_T1/myVersion/registrations/ANTS/labels2subjs/
mkdir -p ${workingDir}/LOGS/

#I like to make my own logs of the commands I execute
OUTNOTES=${workingDir}/LOGS/notes_${subj}.txt

overwrite=1                    #Do you want to overwrite existing output files? (1 = yes, 0 = no)

#PARAMETERS for running the registration!!!!
IMAGE_DIM="3"
OUTPREFIX="${subj}"
IgnoreHDRWarning=1
MaxIteration=30x90x20
N3Correct=1
QualityCheck=1
MetricType=MI					#Mutual Information
TransformationType=GR				#Greedy SyN

##################################################################################################################
####################################### GET READY TO RUN THE MAIN STUFF ##########################################
##################################################################################################################

#If not created yet, let's create a new output folder

mkdir -p $workingDir/LOGS/
mkdir -p $workingDir/${subj}/


workingDirS=$workingDir/${subj}/
#go into the folder where the script should be run and make the notes dir 

cd $workingDir

script=`basename $0`
echo "${USER} is running this script yo: ${script} " > ${OUTNOTES}
echo "In this dir yo: ${PWD} " >> ${OUTNOTES}
echo "In this dir yo: ${PWD} " 
echo '' >> ${OUTNOTES} 
echo ''
echo 'The date is ###################' >> ${OUTNOTES}
date >> ${OUTNOTES}
echo '###############################' >> ${OUTNOTES}
echo '' >> ${OUTNOTES}

time_start=`date +%s`


cd $workingDirS

if [ ! -e $workingDirS/$OUTPREFIX"deformed.nii.gz" ] || [ $overwrite == 1 ]
	then

	#####################################################################
	##################### MAIN CALL HERE! ###############################
	#####################################################################

	cmd="/usr/local/ANTs/bin/antsRegistration \
			-d $IMAGE_DIM \
			-o $OUTPREFIX \
			\
			--write-composite-transform 1 \
			--interpolation 'Linear' \
			--print-similarity-measure-interval 0 \
			--write-interval-volumes 0 \
			\
			--metric MI[$FIXED_IMAGE, $MOVING_IMAGE, 1, 32] \
			--transform SyN[0.10, 3, 0] \
			--convergence 100x100x70x50x20 \
			--shrink-factors 10x6x4x2x1 \
			--smoothing-sigmas 5x3x2x1x0vox \
			--use-histogram-matching 1 \
			"
	echo $cmd #state the command
	echo $cmd >> ${OUTNOTES}
	eval $cmd #execute the command

	echo "" >> ${OUTNOTES}
	echo ""
	echo "DONE WITH antsRegistration"
	echo "" >> ${OUTNOTES}
	echo ""
	echo "NOW apply those transformations"

	cmd="antsApplyTransforms -d ${IMAGE_DIM} \
			--input ${MOVING_IMAGE} \
			--output ${OUTPREFIX}deformed.nii.gz \
			-r ${FIXED_IMAGE} \
			\
			--interpolation 'Linear' \
			--transform ${OUTPREFIX}?Warp* \
			"
	echo $cmd #state the command
	echo $cmd >> ${OUTNOTES}
	echo '' >> ${OUTNOTES}
	echo ''
	eval $cmd #execute the command


cmd="CreateJacobianDeterminantImage 3 \
	${OUTPREFIX}?Warp.nii.gz ${OUTPREFIX}jacobian.nii.gz 0 0 \
	"
echo $cmd #state the command
echo $cmd >> $OUTNOTES
eval $cmd #execute the command

cmd="CreateJacobianDeterminantImage 3 \
	${OUTPREFIX}?Warp.nii.gz ${OUTPREFIX}geo_jacobian.nii.gz 0 1 \
	"
echo $cmd #state the command
echo $cmd >> $OUTNOTES
eval $cmd #execute the command

cmd="CreateJacobianDeterminantImage 3 \
	${OUTPREFIX}?Warp.nii.gz ${OUTPREFIX}_log_jacobian.nii.gz 1 0 \
	"
echo $cmd #state the command
echo $cmd >> $OUTNOTES
eval $cmd #execute the command

cmd="CreateJacobianDeterminantImage 3 \
	${OUTPREFIX}?Warp.nii.gz ${OUTPREFIX}_log_geo_jacobian.nii.gz 1 1 \
	"
echo $cmd #state the command
echo $cmd >> $OUTNOTES
eval $cmd #execute the command


	time_end=`date +%s`
	time_elapsed=$((time_end - time_start))
		   
	echo "that round of $script took ${time_elapsed} seconds to complete yo." >> ${OUTNOTES}
	echo "that round of $script took ${time_elapsed} seconds to complete yo." 
	echo "" >> ${OUTNOTES}
	echo ""

else
	echo -e "NOTICE: ${OUTPREFIX}${subj}deformed.nii.gz does already exist! \
				       Skipping to next subject."
fi





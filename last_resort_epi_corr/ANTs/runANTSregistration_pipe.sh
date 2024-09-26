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
workingDir=${3} #dirI/ANTS_2MDT_over10/
subj=${4}

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
	${OUTPREFIX}?Warp.nii.gz ${OUTPREFIX}_jacobian.nii.gz 0 0 \
	"
echo $cmd #state the command
echo $cmd >> $OUTNOTES
eval $cmd #execute the command

cmd="CreateJacobianDeterminantImage 3 \
	${OUTPREFIX}?Warp.nii.gz ${OUTPREFIX}_geo_jacobian.nii.gz 0 1 \
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



dirO=${workingDirS}/smooth_jac_1p0/
mkdir -p ${dirO}
#SmoothImage ImageDimension image.ext smoothingsigma outimage.ext {sigma-is-in-spacing-coordinates-0/1} {medianfilter-0/1}
cmd="SmoothImage 3 ${workingDirS}${subj}_log_geo_jacobian.nii.gz 1 ${dirO}${subj}_log_geo_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 

cmd="SmoothImage 3 ${workingDirS}${subj}_log_jacobian.nii.gz 1 ${dirO}${subj}_log_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 


###########################################
###########################################

dirO=${workingDirS}/smooth_jac_2p0/
mkdir -p ${dirO}
#SmoothImage ImageDimension image.ext smoothingsigma outimage.ext {sigma-is-in-spacing-coordinates-0/1} {medianfilter-0/1}
cmd="SmoothImage 3 ${workingDirS}${subj}_log_geo_jacobian.nii.gz 2 ${dirO}${subj}_log_geo_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 

cmd="SmoothImage 3 ${workingDirS}${subj}_log_jacobian.nii.gz 2 ${dirO}${subj}_log_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 


###########################################
###########################################

dirO=${workingDirS}/smooth_jac_3p0/
mkdir -p ${dirO}
#SmoothImage ImageDimension image.ext smoothingsigma outimage.ext {sigma-is-in-spacing-coordinates-0/1} {medianfilter-0/1}
cmd="SmoothImage 3 ${workingDirS}${subj}_log_geo_jacobian.nii.gz 3 ${dirO}${subj}_log_geo_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 

cmd="SmoothImage 3 ${workingDirS}${subj}_log_jacobian.nii.gz 3 ${dirO}${subj}_log_jacobian.nii.gz 1 0"
echo $cmd 
eval $cmd 





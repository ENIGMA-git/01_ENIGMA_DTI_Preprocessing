#!/bin/bash
#$ -S /bin/bash

###############
#
# ANTS-based ENIGMA-DTI b0 to T1 EPI correction 
# by Joshua.Faskowitz@ini.usc.edu
# and Neda.Jahanshad@ini.usc.edu
# October 2014 for ENIGMA-DTI
#
# do your images not look ok? contact us to suggest other parameters!
#
# This protocols is offered with an unlimited license and without warranty.
###############

# adopted from http://miykael.github.io/nipype-beginner-s-guide/ANTS.html
# ANTs documentation can be found here: https://github.com/stnava/ANTs

#specify where ANTS is installed
export PATH=/usr/local/ANTs/bin/:$PATH
export ANTSPATH=/usr/local/ANTs/bin/

usage() 
{
	cat <<USAGE

	Usage: 
	`basename $0` (b0 image) (T1 image) (DWI to EPI correct) (output directory) (subject identifier / unique subject number)

	Example:
	`basename $0` inputImage_b0.nii.gz referenceImage_T1.nii.gz dwi_to_apply_transform_to.nii.gz ./directory_to_output "subj_123"

	B0 (called 'S0' after dtifit): should already by linear aligned to the T1 which is aligned to MNI
	T1: should be linear aligned to MNI
	DWI: should be the DWI that you ran dtifit on to get the B0

	#################################################	
	#												 	
	# ANTS-based ENIGMA-DTI b0 to T1 EPI correction		  
	# by Joshua.Faskowitz@ini.usc.edu				 
	# and Neda.Jahanshad@ini.usc.edu				 
	# October 2014 for ENIGMA-DTI					 
	#												 	
	# Check out Enigma here:						
	# http://enigma.ini.usc.edu/
	#											 
	# Check out ANTS here:							 
	# https://github.com/stnava/ANTs 				 	
	# 												 					 												
	##################################################

USAGE
exit 1
}

###############
###   ARGs	 ##
###############

if [ $# -lt 4 ]
then
	usage >&2
fi

#check the image inputs 
if [ ! -e ${1} ]
then 
	echo "input b0 does not exist, exiting"
	exit 1
elif  [ ! -e ${2} ] 
then
	echo "input T1 does not exist, exiting"
	exit 1
elif  [ ! -e ${3} ] 
then
	echo "input DWI does not exist, exiting"
	exit 1
elif [ -z ${4} ]
then
	echo "outdirectory not given, exiting"
	exit 1
fi

#PREPARE THE OUPUT DIR
outputDir=$4
outputDir=${outputDir}/
#If not created yet, let's create a new output folder
if [ ! -d ${outputDir} ]
then
  	echo "dir did not exist, making it."
   	mkdir -p $outputDir
fi
#lets get the full path for the output
outputDir=$(readlink -f "${outputDir}")
outputDir=${outputDir}"/"

#PREPARE OUTPUT PREFIX STUFF
if [ $5 ]
then 
	OUT_PREFIX=$5
else
	#lets make the output prefix the basename of the image and add a number 
	input_base=`basename $1`
	input_base_strip=${input_base//.*/} 
	input_count=0
	while [ -e ${outputDir}/${input_base_strip}_enigmaEPIcorection_${input_count}* ] && [ ${input_count} -lt 100 ] 
	do
		input_count=$(( input_count + 1 ))
	done
	OUT_PREFIX="${input_base_strip}_enigmaEPIcorection_${input_count}_"
	echo -e "\n\nUsing ${OUT_PREFIX} as the output prefix\nBut this is not optimal.\
				\nNext time please provide a unique subject number"
fi

OUT_PREFIX=$OUT_PREFIX'_'

#following code from:
#https://community.oracle.com/thread/2347282?tstart=0
invalid_chars=',.!@#$%^&*()+=?{}[]|~'
check=$(echo ${OUT_PREFIX} | tr -d "${invalid_chars}" )
if [ ${check} != ${OUT_PREFIX} ]
then 
	echo "bad characters in subject identifier.  Please change that and rerun."
	exit 1
fi

#ARGS
OUTNOTES=${outputDir}/${OUT_PREFIX}notes.txt
#input image
#input should be the B0 (s0 in the dtifit2 folder)
INPUT_IMAGE=$1
#reference image 
REFERENCE_IMAGE=$2
DWI=$3
#"Max-Iterations in form: JxKxL"
ITERATIONS='30x40x10' 	
#if you would like to not epi correct in the z direction, change RESTRICT_EPI to 1
RESTRICT_EPI=0

#################################################################################################
#################################################################################################
############################ Script should be good to go now --> ################################
################################## make edits below ar your own discretion ######################
#################################################################################################

touch ${OUTNOTES}
echo -e '##########################################################' >> ${OUTNOTES}
echo -e '\n##########################################################' 
script=`basename $0`
echo "$USER is running this script: ${script} " >> ${OUTNOTES}
echo "$USER is running this script: ${script} " 
echo "In this dir: ${PWD} " >> ${OUTNOTES}
echo "In this dir: ${PWD} " 
echo 'The date is:' >> ${OUTNOTES}
date >> ${OUTNOTES}
echo '' >> ${OUTNOTES}
echo -e "\n\n---> RUNNING ${OUT_PREFIX} with following args:\n \
\tOUTPUT DIR: $outputDir\n \
\tINPUT IMAGE: $INPUT_IMAGE\n \
\tREFERENCE IMAGE: $REFERENCE_IMAGE\n \
\tDWI: $DWI\n \
\tITERATIONS FOR REG: $ITERATIONS\n\n"
echo -e '##########################################################\n\n' >> ${OUTNOTES}
echo -e '##########################################################\n\n' 

time_start=`date +%s`

#the nonlinear registration command 
cmd="${ANTSPATH}/antsRegistration -d 3 \
	--output [ ${outputDir}${OUT_PREFIX}, ${outputDir}${OUT_PREFIX}input_warped.nii.gz, ${outputDir}${OUT_PREFIX}ref_invWarp.nii.gz] \
	--write-composite-transform 0 \
	\
	--metric MI[${REFERENCE_IMAGE},${INPUT_IMAGE}, 1, 32, 'Regular',1] \
	--transform 'SyN[0.05,3.0,0.0]' \
	--convergence [${ITERATIONS},1e-6,5] \
	--shrink-factors 4x2x1 \
   	--smoothing-sigmas 2x1x0vox \
   	--use-histogram-matching 1 \
	--winsorize-image-intensities [0.005,0.995] \
	"
if [ $RESTRICT_EPI -eq 1 ] 
then
	#restrict the nonlinear deformation in the Z direction (XxYxZ)
	cmd="${cmd} --restrict-deformation 1x1x0"
fi
echo $cmd #state the command
echo $cmd >> ${OUTNOTES}
eval $cmd #execute the command

if [ ! -e ${outputDir}${OUT_PREFIX}?Warp.nii.gz ] 
then
	echo -e "\n\nSomething wrong happened and the warp file was not computed by \
					antsRegistration.\nSkipping to the next subject.\n\n"
	continue
fi

#a quick compute of dice stats, taken from antsIntrodcution code
#https://github.com/stnava/ANTs/blob/master/Scripts/antsIntroduction.sh
cmd="${ANTSPATH}/ThresholdImage 3 ${REFERENCE_IMAGE} ${outputDir}${OUT_PREFIX}fixthresh.nii.gz Otsu 4"
echo $cmd #state the command
echo $cmd >> ${OUTNOTES}
eval $cmd #execute the command

cmd="${ANTSPATH}/ThresholdImage 3 ${INPUT_IMAGE} ${outputDir}${OUT_PREFIX}movthresh.nii.gz Otsu 4"
echo $cmd #state the command
echo $cmd >> ${OUTNOTES}
eval $cmd #execute the command

cmd="${ANTSPATH}/antsApplyTransforms -d 3 --input ${outputDir}${OUT_PREFIX}movthresh.nii.gz --output ${outputDir}${OUT_PREFIX}defthresh.nii.gz --reference-image ${REFERENCE_IMAGE} --interpolation NearestNeighbor --transform ${outputDir}${OUT_PREFIX}?Warp.nii.gz"
echo $cmd #state the command
echo $cmd >> ${OUTNOTES}
eval $cmd #execute the command

cmd="${ANTSPATH}/ImageMath 3 ${outputDir}${OUT_PREFIX}dicestats DiceAndMinDistSum ${outputDir}${OUT_PREFIX}fixthresh.nii.gz ${outputDir}${OUT_PREFIX}movthresh.nii.gz" 
echo $cmd #state the command
echo $cmd >> ${OUTNOTES}
eval $cmd #execute the command

#Apply transformation to the DWI image
cmd="${ANTSPATH}/antsApplyTransforms -d 3 --input-image-type 3 --input ${DWI} --output ${outputDir}${OUT_PREFIX}EPIcorr_DWI.nii.gz --reference-image ${REFERENCE_IMAGE} --interpolation Linear --transform ${outputDir}${OUT_PREFIX}?Warp.nii.gz"
echo $cmd #state the command
echo $cmd >> ${OUTNOTES}
eval $cmd #execute the command

time_end=`date +%s`
time_elapsed=$((time_end - time_start))
		   
echo -e "for ${OUT_PREFIX} --> $script took ${time_elapsed} seconds to complete.\n\n" >> ${OUTNOTES}
echo -e "for ${OUT_PREFIX} --> $script took ${time_elapsed} seconds to complete.\n \
\tCheck ${outputDir} for the results\n\n" 





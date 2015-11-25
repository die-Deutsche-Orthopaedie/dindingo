########################################################################################################################################################################
# die♂deutsche♂Orthopädie proundly presents
# ALL in ONE DinDinGo Pronography Dump Script
# combine forumdump.sh and combined.distiller.and.downloader.plus.singlefile.support.sh
# reconstructed and optimized for smaller size and better code readability
# and use new kind of parameter interpreters
# 
# usage: 
# all.in.one.sh [options] parameter
# 
# options: 
# 
# dump levels: 
# 	default: only gain info from dindingo.com
# 	-d or --deep-analysis: deep analysis mode, will download file info from colayun.com aka colafile.com but NOT download any file from colafile
# 	-D or --download: download mode, will download file info AND file from colayun.com aka colafile.com
# 	--threadfile-only: only dump threads from dindingo.com, 
# 		and store it inside "DumpedThreads" folder
# 
# sidefield/custom link/threads/flie: 
# 	default: traverse the main threads
# 	-S or --sidefield: traverse the side threads instead of the main threads, 
#		i heard the rumor that side threads are the distilled resources of the main threads
#		AND now you can define from which page to which page the script will dump: (added 15.11.25)
#		--from=<frompage> AND/OR --to=<topage>
#			will dump from FIRST page if <frompage> NOT defined
#			will automatically determine LAST page if <topage> NOT defined
#		--from and --to will JUST be VOID outside default mode and -S/--sidefield
# 	-C or --customlink: dump all pages in the custom link (typically search page) given by the parameter
# 	-T or --thread: dump single thread
# 	-F or --files: distill info from pre-dumped files instead of from dindingo.com, 
# 		in case you lose access to that fuckin' site
#		and i think my script can differ folder from file, 
#		absolute path from relative path
# 
# download preview pictures: (added 15.10.04)
# 	-P or --pictures: download preview pictures from dindingo.com or elsewhere, needs -D/--download
#
# save file info into webpage: (added 15.10.04)
#	-W or --webpage: save file info into <tid>.html inside its folder, needs -D/--download AND -P/--pictures
# 
# auto-unpack: (added 15.11.20)
# 	-A or --auto-unpack: attempt to unpack the .rar/.zip files
# 	usin' the password dumped from the thread page
# 		if succeed, the original .rar/.zip will be deleted
# 		if failed due to incorrect password, 
# 		the original .rar/.zip will be left unchanged
# 	needs -D/--download
# 
# encryption: (added 15.11.20)
# 	-E or --encrypt: after download, calculate MD5, SHA1 and SHA256 of 
# 	<tid> directory and store individially, archive <tid> directory into a
# 	 .rar file with random 64-bit password, delete source files, and 
# 	 store filename-password infomations into pair.txt, needs -D/--download
# 
# Theorically you CAN put contradictin' options together, 
# but ONLY the LAST ones will be accepted as final options
# 
# help: 
# 	-H or -h or --help: ask for help, just like other Linux programs
# 
# parameter (fid/tid/folder/file): 
# 	fid: DinDinGo Field ID (10, 23, 116, 117, 118 are the prono fields, others are just fuckin' stupid camouflage)
# 	tid: DinDinGo Thread ID
# 	folder: Specify folder storin' dumped HTMLs
# 	file: Specify HTML flie
# 		File(s) MUST be named by its thread ID, <tid>.html and original form tid-<tid>.html are accepted
# 		Otherwise <tid> will be found inside somewhere in the HTML file
#	 	but the effects will NOT be graenteed because info from filename are used in HIGHER Priority
# 		Actually i haven't developed that "find-<tid>-inside-somewhere-in-the-HTML-file" feature 23333333333333
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
parameters=`getopt -o dhCDSTFHPWAE -a -l deep-analysis,download,threadfile-only,sidefield,customlink,thread,files,help,pictures,webpage,auto-unpack,encrypt,from:,to: -- "$@"`

if [ $? != 0 ]
then  
    echo "Houston, we have a problem: Unrecognized Option Detected, Terminating....." >&2  
    exit 1  
fi

eval set -- "$parameters" 

dlevel=0 # by default
mode=0 # by default
picmode=0 # by default
webmode=0 # by default
autounpackmode=0 # by default
encryptmode=0 # by default

while true  
do  
    case "$1" in  
        -d | --deep-analysis)
			dlevel=1
            shift
            ;;  
        -D | --download)
			dlevel=2
            shift
            ;;  
		--threadfile-only)
			dlevel=3
            shift
            ;;  
		-S | --sidefield)
			mode=1
            shift
            ;;  
		-C | --customlink)
			mode=2
			shift
			;;
		-T | --thread)
			mode=3
            shift
            ;;
		-F | --files)  
			mode=4
            shift
            ;;  
		-P | --pictures)
			picmode=1
			shift
			;;
		-W | --webpage)
			webmode=1
			shift
			;;
		-A | --auto-unpack)
			autounpackmode=1
			shift
			;;
		-E | --encrypt)
			encryptmode=1
			shift
			;;
		--from)
			from=$2
			shift 2
			;;
		--to)
			to=$2
			shift 2
			;;
		-h | -H | --help)  
			echo "die♂deutsche♂Orthopädie proundly presents"
			echo "ALL in ONE DinDinGo Pronography Dump Script"
			echo "combine forumdump.sh and combined.distiller.and.downloader.plus.singlefile.support.sh"
			echo "reconstructed and optimized for smaller size and better code readability"
			echo "and use new kind of parameter interpreters"
			echo
			echo "usage: "
			echo "all.in.one.sh [options] parameter"
			echo
			echo "options: "
			echo
			echo "dump levels: "
			echo "	default: only gain info from dindingo.com"
			echo "	-d or --deep-analysis: deep analysis mode, will download file info from colayun.com aka colafile.com but NOT download any file from colafile"
			echo "	-D or --download: download mode, will download file info AND file from colayun.com aka colafile.com"
			echo "	--threadfile-only: only dump threads from dindingo.com, "
			echo "		and store it inside \"DumpedThreads\" folder"
			echo
			echo "sidefield/threads/flie: "
			echo "	default: traverse the main threads"
			echo "	-S or --sidefield: traverse the side threads instead of the main threads, "
			echo "		i heard the rumor that side threads are the distilled resources of the main threads"
			echo "		AND now you can define from which page to which page the script will dump: (added 15.11.25)"
			echo "		--from=<frompage> AND/OR --to=<topage>"
			echo "			will dump from FIRST page if <frompage> NOT defined"
			echo "			will automatically determine LAST page if <topage> NOT defined"
			echo "		--from and --to will JUST be VOID outside default mode and -S/--sidefield"
			echo "	-C or --customlink: dump all pages in the custom link (typically search page) given by the parameter"
			echo "	-T or --thread: dump single thread"
			echo "	-F or --files: distill info from pre-dumped files instead of from dindingo.com, "
			echo "		in case you lose access to that fuckin' site"
			echo "		and i think my script can differ folder from file, "
			echo "		absolute path from relative path"
			echo
			echo "download preview pictures: (added 15.10.04)"
			echo "	-P or --pictures: download preview pictures from dindingo.com or elsewhere, needs -D/--download"
			echo
			echo "save file info into webpage: (added 15.10.04)"
			echo "	-W or --webpage: save file info into <tid>.html inside its folder <tid>, needs -D/--download AND -P/--pictures"
			echo 
			echo "auto-unpack: (added 15.11.20)"
			echo "	-A or --auto-unpack: attempt to unpack the .rar/.zip files"
			echo "	usin' the password dumped from the thread page"
			echo "		if succeed, the original .rar/.zip will be deleted"
			echo "		if failed due to incorrect password, "
			echo "		the original .rar/.zip will be left unchanged"
			echo "	needs -D/--download"
			echo
			echo "encryption: (added 15.11.20)"
			echo "	-E or --encrypt: after download, calculate MD5, SHA1 and SHA256 of "
			echo "	<tid> directory and store individially, archive <tid> directory into a"
			echo "	.rar file with random 64-bit password, delete source files, and "
			echo "	store filename-password infomations into pair.txt, needs -D/--download"
			echo
			echo "Theorically you CAN put contradictin' options together, "
			echo "but ONLY the LAST ones will be accepted as final options"
			echo
			echo "help: "
			echo "	-H or -h or --help: ask for help, just like other Linux programs"
			echo
			echo "parameter (fid/tid/folder/file): "
			echo "	fid: DinDinGo Field ID (10, 23, 116, 117, 118 are the prono fields, others are just fuckin' stupid camouflage)"
			echo "	tid: DinDinGo Thread ID"
			echo "	folder: Specify folder storin' dumped HTMLs"
			echo "	file: Specify HTML flie"
			echo "		File(s) MUST be named by its thread ID, <tid>.html and original form tid-<tid>.html are accepted"
			echo "		Otherwise <tid> will be found inside somewhere in the HTML file"
			echo "	 	but the effects will NOT be graenteed because info from filename are used in HIGHER Priority"
			echo "		Actually i haven't developed that \"find-<tid>-inside-somewhere-in-the-HTML-file\" feature 23333333333333"
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

if [ "$autounpackmode" == "1" ]
then # -E
if [ ! "$dlevel" == "2" ]
	then # -E & !-D
		echo "Houston, we have a problem: You CANNOT use -A/--auto-unpack without usin' -D/--download"
		exit 1
	fi
fi

if [ "$encryptmode" == "1" ]
then # -E
if [ ! "$dlevel" == "2" ]
	then # -E & !-D
		echo "Houston, we have a problem: You CANNOT use -E/--encrypt without usin' -D/--download"
		exit 1
	fi
fi

if [ "$picmode" == "1" ]
then # -P
if [ ! "$dlevel" == "2" ]
	then # -P & !-D
		echo "Houston, we have a problem: You CANNOT use -P/--pictures without usin' -D/--download"
		exit 1
	fi
fi

if [ "$webmode" == "1" ] 
then # -W
	if [ ! "$picmode" == "1" ]
	then # -W & !-P
		echo "Houston, we have a problem: You CANNOT use -W/--webpage without usin' -P/--pictures"
		exit 1
	else # -W & -P
		if [ ! "$dlevel" == "2" ]
		then # -W & -P & !-D
			echo "Houston, we have a problem: You CANNOT use -W/--webpage without usin' -D/--download" # 我向我短发姐姐的短♂发发誓执行不到这段代码（手动再见
			exit 1
		fi
	fi
fi

########################                          Parameter Analysis ends                           ########################

########################                          Cookies                           ########################
#echo "www.dindingo.com	FALSE	/	FALSE	5738539162	d3ee9_lastpos	other" > "/tmp/dindingo_cookies.txt"
#echo "#HttpOnly_www.dindingo.com	FALSE	/	FALSE	5738539162	d3ee9_winduser	BlxUDwcPOgVUBQNeDFRUAlcOAwADBgVVV1dXV1FTC1IDBgVbBlMAPw" >> "/tmp/dindingo_cookies.txt"
#echo "www.dindingo.com	FALSE	/	FALSE	5738539162	d3ee9_ck_info	%2F%09" >> "/tmp/dindingo_cookies.txt"
#echo ".dindingo.com	TRUE	/	FALSE	5738539162	safedog-flow-item	BC28DB2F3B36A3F8E8F9FF9C5F73D35F" >> "/tmp/dindingo_cookies.txt"

#echo ".colafile.com	TRUE	/	FALSE	5738539162	pgv_pvi	8952249344" > "/tmp/colafile_cookies.txt"
#echo ".colafile.com	TRUE	/	FALSE	5738539162	pgv_si	s5975701504" >> "/tmp/colafile_cookies.txt"
#echo ".colafile.com	TRUE	/	FALSE	5738539162	colafile_info	WjQHZABkB2BVa1AxAAkAbFVfVOdQ4w29DulXz1G5UblVqQf4AboG8wGXVgoLalw2BjBQZ1E4AmFXYAM0B2EANVo4BzUAbAc2VWRQMgAxADlVZVRjUGkNPQ49V2dRZ1E0VTMHNQFuBjcBMVY2CwJcZQZoUGlRHAJpVyADZAcnAHJaIgcqAGwHMVV8UGAAdQBRVWdUMlBsDSQOPldgUTFRflUxB2EBbwZ6ATdWMgs8" >> "/tmp/colafile_cookies.txt"
#echo "www.colafile.com	FALSE	/	FALSE	5738539162	PHPSESSID	" >> "/tmp/colafile_cookies.txt"
#echo "www.colafile.com	FALSE	/	FALSE	5738539162	CNZZDATA1000102380	15334563-1443452847-%7C1443452847" >> "/tmp/colafile_cookies.txt"
#echo "www.colafile.com	FALSE	/	FALSE	5738539162	CNZZDATA1000224668	1286646693-1443452509-%7C1443452509" >> "/tmp/colafile_cookies.txt"
#echo "www.colafile.com	FALSE	/	FALSE	5738539162	CNZZDATA1000036711	1836033506-1443451615-%7C1443451615" >> "/tmp/colafile_cookies.txt"

dindingo_cookies="/tmp/dindingo_cookies.txt"
colafile_cookies="/tmp/colafile_cookies.txt"

dindingou_account="%E5%BE%B7%E5%9B%BD%E9%AA%A8%E7%A7%91"
dindingou_password="dyjrrmengde1b"

#curl -c $dindingo_cookies -d "forward=&jumpurl=http%3A%2F%2Fwww.dindingo.com%2Fbbs%2Fread.php%3Ftid-107899.html&step=2&lgt=0&pwuser=%E5%BE%B7%E5%9B%BD%E9%AA%A8%E7%A7%91&pwpwd=dyjrrmengde1b&hideid=0&cktime=31536000&submit=" "http://www.dindingo.com/bbs/login.php?" > /dev/null
curl -c $dindingo_cookies -d "forward=&jumpurl=&step=2&lgt=0&pwuser=$dindingou_account&pwpwd=$dindingou_password&hideid=0&cktime=31536000&submit=" "http://www.dindinc.com/bbs/login.php?" > /dev/null

echo ".colayun.com	TRUE	/	FALSE	5738539162	pgv_pvi	8952249344" > $colafile_cookies
echo ".colayun.com	TRUE	/	FALSE	5738539162	pgv_si	s5975701504" >> $colafile_cookies
echo ".colayun.com	TRUE	/	FALSE	5738539162	colafile_info	WjQHZABkB2BVa1AxAAkAbFVfVOdQ4w29DulXz1G5UblVqQf4AboG8wGXVgoLalw2BjBQZ1E4AmFXYAM0B2EANVo4BzUAbAc2VWRQMgAxADlVZVRjUGkNPQ49V2dRZ1E0VTMHNQFuBjcBMVY2CwJcZQZoUGlRHAJpVyADZAcnAHJaIgcqAGwHMVV8UGAAdQBRVWdUMlBsDSQOPldgUTFRflUxB2EBbwZ6ATdWMgs8" >> $colafile_cookies
echo "www.colayun.com	FALSE	/	FALSE	5738539162	PHPSESSID	" >> $colafile_cookies
echo "www.colayun.com	FALSE	/	FALSE	5738539162	CNZZDATA1000102380	15334563-1443452847-%7C1443452847" >> $colafile_cookies
echo "www.colayun.com	FALSE	/	FALSE	5738539162	CNZZDATA1000224668	1286646693-1443452509-%7C1443452509" >> $colafile_cookies
echo "www.colayun.com	FALSE	/	FALSE	5738539162	CNZZDATA1000036711	1836033506-1443451615-%7C1443451615" >> $colafile_cookies
########################                          Cookies ends                           ########################

########################                          Function: Generate Password                            ########################
function GeneratePW { 
	len=64
	str=(a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 1 2 3 4 5 6 7 8 9 0 短 发 大 法 好 \! \@ \# \$ \% \^ \& \* \( \) \- \_ \= \+ \\ \/ \' \" \; \: \[ \] \{ \} \, \. \?)
	for((i=1;i<=$len;i++))
	do
		arr[$i]=${str[$[$RANDOM%87]]}
	done
	echo "${arr[@]}"|tr -d " "
}
########################                          Function: Generate Password ends                            ########################

########################                          Function: Determine Last Page                            ########################
function dLastPage() # only be called in mainfield mode or sidefield mode
{
	fid=$1
	magicNumber=3 # don't ask me why 23333333333333
	case $mode in  
	0)  
		echo $(curl -b $dindingo_cookies "http://www.dindinc.com/bbs/thread.php?fid-$fid.html" | grep -m 1 -Eo ">\.\.\..*<\/a><a" | sed 's/>...//g ' | sed 's/<\/a><a//g ')
		if [ -z $lastpage ]
		then
			echo $magicNumber
		fi
		;;  
	1)  
		echo $(curl -b $dindingo_cookies "http://www.dindinc.com/bbs/thread.php?fid-$fid-search-check.html" | grep -m 1 -Eo ">\.\.\..*<\/a><a" | sed 's/>...//g ' | sed 's/<\/a><a//g ')
		if [ -z $lastpage ]
		then
			echo $magicNumber
		fi  
		;;  
	*)   
		echo "Internal error!"
		exit 1  
		;;
	esac  
}
########################                          Function: Determine Last Page ends                            ########################

########################                          Function: Process Download Link                            ########################
function processDLLink() # will only be called when dlevel > 0
{
	singlelink=$1
	singlelink=${singlelink//colafile/colayun}
	curl -b $colafile_cookies $singlelink > /tmp/temp.txt
	#rawlinkinfo=$(curl -b $colafile_cookies $singlelink)
	
	########################                          filename                           ########################
	#filename=$(grep -Eo "<div class=\"new-download-file-title\">.*<\/div>" /tmp/temp.txt | sed 's/<div class=\"new-download-file-title\">//g ' | sed 's/<\/div>//g ' )
	filename=$(grep -Eo "<div class=\"new-download-file-title\">.*<\/div>" /tmp/temp.txt | sed 's/<div class=\"new-download-file-title\">//g ' | sed 's/<\/div>//g ' )
	#filename=$(echo $rawlinkinfo | grep -Eo "<div class=\"new-download-file-title\">.*<\/div>" | sed 's/<div class=\"new-download-file-title\">//g ' | sed 's/<\/div>//g ' )
	echo "原文件名：$filename"
	########################                          filename ends                           ########################

	########################                          extension                           ########################
	extension=$(echo $filename | grep -Eo "part[0-9]*\..*")
	if [ -z "$extension" ]
	then
		extension=${filename##*.} 
	fi
	#echo $extension
	########################                          extension ends                           ########################

	########################                          link                           ########################
	# link=$(grep -Eo "http://vip.d.colayun.com.*\">" /tmp/temp.txt | sed 's/\">//g ')
	link=$(grep -Eo "http://vip.d.down002.com.*\">" /tmp/temp.txt | sed 's/\">//g ')
	#link=$(echo $rawlinkinfo | grep -Eo "http://vip.d.colayun.com.*\">" | sed 's/\">//g ')
	echo "直链（很快就会失效，下载请用-D/--download选项）：$link"
	#echo $folder.$extension
	if [ "$dlevel" == "2" ]
	then
		case "$tid" in  
		"103068") # Unfournately there's an exception that needs to be listed
			echo "EXCEPTION DL: tid=103068"
			wget $link -O "movies/$filename"
			;;
		*)   
			echo "NORMAL DL"
			wget $link -O "movies/$folder.$extension"
			;;
		esac
		if [ "$picmode" == "1" ] && [ "$webmode" == "1" ] && [ "$autounpackmode" == "0" ]
		then
			echo "<a href=\"movies/$folder.$extension\">$folder.$extension</a> " >> "$folder.html"
		fi
	fi
	########################                          link ends                           ########################

	########################                          size                           ########################
	size=$(grep -Eo "<div class=\"new-download-file-size\">.*<\/div>" /tmp/temp.txt | sed 's/<div class=\"new-download-file-size\">//g ' | sed 's/<\/div>//g ' )
	#size=$(echo $rawlinkinfo | grep -Eo "<div class=\"new-download-file-size\">.*<\/div>" | sed 's/<div class=\"new-download-file-size\">//g ' | sed 's/<\/div>//g ' )
	if  [ "$autounpackmode" == "0" ] && [ "$dlevel" == "2" ]
	then
		echo "文件大小：$size<br />">> "$folder.html"
	fi
	# used for statistics
	echo "文件大小：$size"
	size=${size% M}
	size=${size//K/\/ 1000} # convert KB to MB
	totalsize="$totalsize + ${size% M}"
	########################                          size ends                           ########################
	echo
}
########################                          Function: Process Download Link ends                            ########################

########################                          Function: Process Single Thread (novus)                         ########################
function processSingleThread()
{	
	case $mode in  
		0 | 1 | 2 | 3)  
			#echo "parameter = tid"
			tid=$1
			#echo "http://www.dindingo.com/bbs/read.php?tid-$tid.html"
			downloaded=$(curl -b $dindingo_cookies "http://www.dindinc.com/bbs/read.php?tid-$tid.html")
			dllinkblock=$(echo $downloaded | grep -Eo "下载地址：.*</div>")
			folder=$tid
			;;
		4)
			#echo "parameter = filename" 
			filepath=$1
			tid=
			downloaded=$(cat $filepath)
			dllinkblock=$(grep -Eo "下载地址：.*</div>" $filepath)
			folder=$(echo ${filepath##*/} | sed 's/tid-//g ' | sed 's/\.html//g ' )
			tid=$folder
			;;
		*)   
			echo "Internal error!"  
			exit 1  
			;;
	esac	
	#if [ ! -z "$(grep -Eo "下载地址：.*</div>" $filepath)" ]
	if [ -d "$folder" ]
	then
		echo "$folder already exists. "
	fi
	if [ ! -z "$(echo $dllinkblock | sed 's/<br \/>/\n/g ' | sed 's/<\/div>/\n/g ' | grep -Eo "http.*colafile.*\"" | grep -Eo "http.*colafile.com/file/[0-9][0-9][0-9][0-9]*")" ] && [ ! -d "$folder" ]
	then
		#echo "CD: $filepath"
		#folder=$(echo $filepath | sed 's/tid-//g ' | sed 's/\.html//g ' )
		#folder=$(echo $filepath | sed 's/tid-//g ' | sed 's/\.html//g ' )
		echo "原始链接：http://www.dindinc.com/bbs/read.php?tid-$folder.html"
		#echo $folder
		#if [ $dlevel > 1 ]
		if [ "$dlevel" == "2" ]
		then
			mkdir $folder
			cd $folder
			########################################################        NOVUS DIRECTORY INFRASTRUCTURE        ############################################################################
			mkdir images
			mkdir movies
			########################################################        NOVUS DIRECTORY INFRASTRUCTURE        ############################################################################
			if [ "$picmode" == "1" ] && [ "$webmode" == "1" ]
			then
				echo "<html><head><meta charset=\"utf-8\">" > "$folder.html"
			fi
		fi
		echo
		
		########################                          title                           ########################
		title=$(echo $downloaded | grep -Eo "<title>.*</title>" | sed 's/<title>//g ' | sed 's/<\/title>//g ' | sed 's/ - 丁丁购 - Powered by phpwind//g ')
		echo "标题：$title"
		
		#grep -Eo "<title>.*</title>" $filepath | sed 's/<title>//g ' | sed 's/<\/title>//g '
		if [ "$dlevel" == "2" ] && [ "$picmode" == "1" ] && [ "$webmode" == "1" ]
		then
			echo "<title>$title</title></head><body>" >> "$folder.html"
			echo "原始链接：<a href=\"http://www.dindinc.com/bbs/read.php?tid-$folder.html\">http://www.dindinc.com/bbs/read.php?tid-$folder.html</a><br />" >> "$folder.html"
			echo "标题：$title<br />" >> "$folder.html"
		fi
		########################                          title ends                           ########################
	
		########################                          images                           ########################
		echo "预览图："
		echo $downloaded | sed 's/<br \/>/\n/g ' | sed 's/<\/div>/\n/g ' | grep -Eo "<img src=\".*\" border=" | sed 's/<img src=\"//g ' | sed 's/\" border=//g ' 
		if [ "$dlevel" == "2" ] && [ "$picmode" == "1" ]
		then
			timeinterval=1 # avoid blocks from WAFs of dindingo.com
			if [ "$webmode" == "1" ]
			then
				echo "预览图：<br />" >> "$folder.html"
			fi
			########################################################        NOVUS DIRECTORY INFRASTRUCTURE        ############################################################################
			cd images
			########################################################        NOVUS DIRECTORY INFRASTRUCTURE ENDS        ############################################################################
			for singlepicture in $(echo $downloaded | sed 's/<br \/>/\n/g ' | sed 's/<\/div>/\n/g ' | grep -Eo "<img src=\".*\" border=" | sed 's/<img src=\"//g ' | sed 's/\" border=//g ' )
			do
				# wget "$singlepicture"
				wget "${singlepicture%\?*}"
				sleep $timeinterval
			done
			########################################################        NOVUS DIRECTORY INFRASTRUCTURE        ############################################################################
			cd ..
			########################################################        NOVUS DIRECTORY INFRASTRUCTURE ENDS        ############################################################################
			for imgfile in $(ls images | grep "\.jpg")
			do
				# echo ${imgfile%?*}
				echo $imgfile
				# mv $imgfile ./${imgfile%\?*}
				if [ "$webmode" == "1" ]
				then
					echo "<img border=\"0\" onload=\"if(is_ie6&&this.offsetWidth>700)this.width=700;\" style=\"max-width:700px;max-height:700px;\" src=\"images/${imgfile%\?*}\"></img><br />" >> "$folder.html"
				fi
			done
		fi
		echo
		########################                          images ends                           ########################
	
		########################                          password                           ########################
		echo $dllinkblock | sed 's/<br \/>/\n/g ' | sed 's/<\/div>/\n/g ' | sed 's/<\/a>/\n/g ' | sed 's/<a.*>/\n/g ' | grep -Eo "密码：.*" 
		#echo $dllinkblock | sed 's/<br \/>/\n/g ' | sed 's/<\/div>/\n/g ' | sed 's/<\/a>/\n/g ' | sed 's/<a.*>/\n/g ' | grep -Eo "密码：.*" | sed 's/密码：//g ' 
		#echo "$folder.password.txt"
		#if [ $dlevel > 1 ]
		if [ "$dlevel" == "2" ]
		then
			echo $dllinkblock | sed 's/<br \/>/\n/g ' | sed 's/<\/div>/\n/g ' | sed 's/<\/a>/\n/g ' | sed 's/<a.*>/\n/g ' | grep -Eo "密码：.*" | sed 's/密码：//g ' > "$folder.password.txt"
			if [ "$picmode" == "1" ] && [ "$webmode" == "1" ]
			then
				echo "密码：<br />" >> "$folder.html"
				echo $dllinkblock | sed 's/<br \/>/\n/g ' | sed 's/<\/div>/\n/g ' | sed 's/<\/a>/\n/g ' | sed 's/<a.*>/\n/g ' | grep -Eo "密码：.*" | sed 's/密码：//g ' >> "$folder.html"
				echo "<br />" >> "$folder.html"
			fi
		fi
		echo
		#sed 's/<br \/>/\n/g ' $temp2 | sed 's/<\/div>/\n/g ' | grep -Eo "密码：.*"
		########################                          password ends                           ########################
	
		########################                          dl link                           ########################dl link
		if  [ "$autounpackmode" == "0" ]
		then
			echo "下载地址："
			echo
			if [ "$dlevel" == "2" ] && [ "$picmode" == "1" ] && [ "$webmode" == "1" ]
			then
				echo "下载地址：<br />" >> "$folder.html"
			fi
		fi
		
		#echo $dllinkblock | sed 's/<br \/>/\n/g ' | sed 's/<\/div>/\n/g ' | grep -Eo "http.*colafile.*\"" | grep -Eo "http.*colafile.com/file/[0-9][0-9][0-9][0-9]*"
		for singlelink in $(echo $dllinkblock | sed 's/<br \/>/\n/g ' | sed 's/<\/div>/\n/g ' | grep -Eo "http.*colafile.*\"" | grep -Eo "http.*colafile.com/file/[0-9][0-9][0-9][0-9]*")
		do
			echo $singlelink
			if [ "$dlevel" == "1" ] || [ "$dlevel" == "2" ]
			then
				processDLLink $singlelink
			fi
		done
		echo
		#sed 's/<br \/>/\n/g ' $temp2 | sed 's/<\/div>/\n/g ' | grep -Eo "http.*colafile.*\"" | grep -Eo "http.*colafile.com/file/[0-9][0-9][0-9][0-9]*"
		########################                          dl link ends                           ########################
		#if [ $dlevel > 1 ]
		if [ "$dlevel" == "2" ]
		then
			if [ "$picmode" == "1" ] && [ "$webmode" == "1" ]
			then
				echo "</body></html>" >> "$folder.html"
				cp "$folder.html" "index.html"
			fi
			if [ "$autounpackmode" == "1" ]
			then
				password=`cat "$folder.password.txt" `
				cd movies
				case "$tid" in  
				"103068")
					echo "EXCEPTION UNPACK: tid=103068"
					for zipnum in $(seq 1 70)
					do
						LANG=C 7za x -p"654321" "$zipnum.zip"
						if  [ "$?" == "0" ]
						then
							rm -f $zipnum.z*
						else
							zip -s 0 "$zipnum.zip" --out "$zipnum.merged.zip"
							rm -f $zipnum.z*
							LANG=C 7za x -p"654321" "$zipnum.merged.zip"
							if  [ "$?" == "0" ]
							then
								rm -f $zipnum.merged.zip
							fi
						fi
						convmv -f GBK -t utf8 --notest -r .
					done
					;;
				*)   
					echo "NORMAL UNPACK"
					if [ -f "$folder.rar" ]
					then
						/root/rar/rar x -ts -p"$password" "$folder.rar"
						if  [ "$?" == "0" ]
						then
							rm -f *.rar
						fi
					fi
					if [ -f "$folder.part1.rar" ]
					then
						/root/rar/rar x -ts -p"$password" "$folder.part1.rar"
						if  [ "$?" == "0" ]
						then
							rm -f *.rar
						fi
					fi
					if [ -f "$folder.part01.rar" ]
					then
						/root/rar/rar x -ts -p"$password" "$folder.part01.rar"
						if  [ "$?" == "0" ]
						then
							rm -f *.rar
						fi
					fi
					if [ -f "$folder.part001.rar" ]
					then
						/root/rar/rar x -ts -p"$password" "$folder.part001.rar"
						if  [ "$?" == "0" ]
						then
							rm -f *.rar
						fi
					fi
					if [ -f "$folder.zip" ]
					then
						LANG=C 7za x -p"$password" "$folder.zip"
						if  [ "$?" == "0" ]
						then
							rm -f *.zip
						fi
						convmv -f GBK -t utf8 --notest -r .
					fi
					if [ -f "$folder.part1.zip" ]
					then
						LANG=C 7za x -p"$password" "$folder.part1.zip"
						if  [ "$?" == "0" ]
						then
							rm -f *.zip
						fi
						convmv -f GBK -t utf8 --notest -r .
					fi
					if [ -f "$folder.part01.zip" ]
					then
						LANG=C 7za x -p"$password" "$folder.part01.zip"
						if  [ "$?" == "0" ]
						then
							rm -f *.zip
						fi
						convmv -f GBK -t utf8 --notest -r .
					fi
					if [ -f "$folder.part001.zip" ]
					then
						LANG=C 7za x -p"$password" "$folder.part001.zip"
						if  [ "$?" == "0" ]
						then
							rm -f *.zip
						fi
						convmv -f GBK -t utf8 --notest -r .
					fi
					;;
				esac  
				cd ..
			fi
			
			if [ "$encryptmode" == "1" ]
			then
				# md5sum *.* > /tmp/md5
				find  -type f -print0 | xargs -0 md5sum > /tmp/md5
				# sha1sum *.* > /tmp/sha1
				find  -type f -print0 | xargs -0 sha1sum > /tmp/sha1
				# sha256sum *.* > /tmp/sha256
				find  -type f -print0 | xargs -0 sha256sum > /tmp/sha256
				mv /tmp/md5 $folder.md5
				mv /tmp/sha1 $folder.sha1
				mv /tmp/sha256 $folder.sha256
			fi
			
			cd ..
			
			if [ "$encryptmode" == "1" ]
			then
				password=`GeneratePW`
				# /root/rar/rar a -htb -m0 -ma5 -rr5 -ts -hp"$password" "$folder.rar" $folder
				currentdate=`date +%y.%m.%d`
				/root/rar/rar a -df -v2.33g -v1g -htb -m0 -ma5 -rr5 -ts -hp"$password" "$folder.$currentdate.rar" $folder
				echo "$folder♂$currentdate♂$password" > "pair.$folder.$currentdate.txt"
				echo "$folder♂$currentdate♂$password" >> pair.txt
			fi
		fi
		echo "SINGLE PAGE END"
		echo
	fi
}
########################                          Function: Process Single Thread (novus) ends                         ########################

########################                          Main Program                            ########################
totalsize="0"
if [ "$dlevel" == "3" ]
then
	mkdir DumpedThreads
fi
case $mode in
	0 | 1)  
		#echo "field mode"
		if [ -z $from ]
		then
			from=1
		fi
		if [ -z $to ]
		then
			to=$(dLastPage $parameter)
		fi
		echo "From: Page $from"
		echo "To: Page $to"
		#echo "lastpage: $lastpage"
		timeinterval=1 # avoid blocks from WAFs of dindingo.com
		for page in $(seq $from $to)
		do
			echo "Page $page: "
			echo
			if [ "$dlevel" == "3" ]
			then
				mkdir "DumpedThreads/$page"
			fi
			#echo $page
			case $mode in  
				0)  
					for tid in $(curl -b $dindingo_cookies "http://www.dindinc.com/bbs/thread.php?fid-$parameter-search-all-asc-ASC-page-$page.html" | grep "<td class=\"subject\" id=\"td" | sed 's/<td class=\"subject\" id=\"td_//g ' | sed 's/\">//g ')
					do
						if [ "$dlevel" == "3" ]
						then
							curl -b $dindingo_cookies "http://www.dindinc.com/bbs/read.php?tid-$tid.html" > "DumpedThreads/$page/tid-$tid.html"
						else
							processSingleThread $tid
						fi
						sleep $timeinterval
					done
					#echo "mainfield mode"
					;;  
				1)  
					for tid in $(curl -b $dindingo_cookies "http://www.dindinc.com/bbs/thread.php?fid-$parameter-search-check-asc-ASC-page-$page.html" | grep "<td class=\"subject\" id=\"td" | sed 's/<td class=\"subject\" id=\"td_//g ' | sed 's/\">//g ')
					do
						if [ "$dlevel" == "3" ]
						then
							curl -b $dindingo_cookies "http://www.dindinc.com/bbs/read.php?tid-$tid.html" > "DumpedThreads/$page/tid-$tid.html"
						else
							processSingleThread $tid
						fi
						sleep $timeinterval
					done
					#echo "sidefield mode"
					;;
				*)   
					echo "Internal error!"
					exit 1
				;;  
			esac
			echo "Page $page ends. "
			echo
			sleep $timeinterval
			# page=`expr $page + 1`
			let page+=1
			# ((page++))
			# page=$[$page+1]
			# page=$(( $page + 1 ))
		done
		;;
	2)
		timeinterval=1 # avoid blocks from WAFs of dindingo.com
		if [ "$dlevel" == "3" ]
		then
			currentdate=`date +%y.%m.%d`
			mkdir "CustomSearch.$currentdate"
		fi
		for tid in $(curl -b $dindingo_cookies "$parameter" | grep -Eo "\<a href=\"read.php\?tid-[0-9]*" | sed 's/\<a href="read.php?tid-//g ')
		do
			if [ "$dlevel" == "3" ]
			then
				 curl -b $dindingo_cookies "http://www.dindinc.com/bbs/read.php?tid-$tid.html" > "DumpedThreads/CustomSearch.$currentdate/tid-$tid.html"
			else
				processSingleThread $tid
			fi
			sleep $timeinterval
		done
		;;
	3)  
		#echo "thread mode"
		if [ "$dlevel" == "3" ]
		then
			 curl -b $dindingo_cookies "http://www.dindinc.com/bbs/read.php?tid-$tid.html" > "DumpedThreads/tid-$tid.html"
		else
			processSingleThread $tid
		fi
		sleep $timeinterval
		;;
	4)  
		#echo "file(s) mode"
		if [ "${parameter#/}" != "${parameter}" ]
		then # Absolute Path
	#		if test -d $parameter	
	#		then	
				current_dir=$parameter # Absolute Path, Folder
	#		else
	#			current_dir=${parameter##*/} # Absolute Path, File
	#		fi
		else # Relative Path
			if test -d $parameter
			then
				current_dir=$(pwd)/$parameter # Relative Path, Folder
			else
				current_dir=$parameter # Relative Path, File
			fi
		fi
		if test -d $current_dir
		then
			for file in $(ls $current_dir)
			do
				if test -d $file
				then
					echo ""
				else
					processSingleThread "$current_dir/$file"
				fi
			done
		else
			processSingleThread $current_dir
		fi
		;;
	*)   
		echo "Internal error!"  
		exit 1  
	;;  
esac
if [ "$dlevel" == "1" ] || [ "$dlevel" == "2" ]
then
	totalsize=`echo $totalsize | bc -q`
	echo "Total file size in this dump session: $totalsize MB"
fi
rm -f $dindingo_cookies $colafile_cookies
########################                          Main Program ends                            ########################

die♂deutsche♂Orthopädie proundly presents

德♂国♂骨♂科倾情演绎


ALL in ONE DinDinGo Pronography Dump Script

多合一dindingo拖A♂片脚本


combine forumdump.sh and combined.distiller.and.downloader.plus.singlefile.support.sh

把forumdump.sh（只负责拖♂站）和combined.distiller.and.downloader.plus.singlefile.support.sh（只负责分析HTML的信息并自动下载，其实也是两个脚本的合集）合到一块了


reconstructed and optimized for smaller size and better code readability

重写（主要是把一些过程写成了函♂数）并优化了一遍，提升了代码可读性并缩小了尺寸


and use new kind of parameter interpreters

并使用了新的参数解析器


usage: 

用♂法：


all.in.one.sh [options] parameter

all.in.one.sh [选项] 参数


options:

选项：


dump levels:

拖♂站级别：

	default: only gain info from dindingo.com
	默认：只从dindingo.com拖下来文件信息，如果是文件模式的话只分析文件内容，换句话说不分析colafile.com网盘链接的信息

	-d or --deep-analysis: deep analysis mode, will download file info from colayun.com aka colafile.com but NOT download any file from colafile
	-d或--deep-analysis：深度分析模式，会从colafile.com抓取网盘链接的信息，如源文件名、大小、直链（会过期，只能配合下面的选项用，生成后立即下载）。但不会下载片♂子

	-D or --download: download mode, will download file info AND file from colayun.com aka colafile.com
	-D或--download：下载模式，除了上述的操作外还会下载片♂子。片♂子和其解压密码会存放在脚本目录下以tid为名的文件夹里
	
	--threadfile-only (added 15.11.25): only dump threads from dindingo.com, 
	--threadfile-only（15.11.25添加）：只从dindingo.com拖下来帖子（的html文件），
	
 	and store it into "DumpedThreads" folder
	并将其存入DumpedThreads目录

sidefield/threads/flie:

副板块/单帖子/文件模式：

	default: traverse the main threads
	默认：遍历主板块

	-S or --sidefield: traverse the side threads instead of the main threads, 
	-S或--sidefield：遍历副板块

		i heard the rumor that side threads are the distilled resources of the main threads
		我听说副板块是主板块的浓缩版，里面全tm是合集，但我一般用副板块来测♂试我的脚本，毕竟主板块帖子太多了

		AND now you can define from which page to which page the script will dump: (added 15.11.25)
		而且现在你可以指定从哪一页拖到哪一页：（15.11.25添加）
		
		--from=<frompage> AND/OR --to=<topage>
		--from=<frompage> 和/或 --to=<topage>
		
			will dump from FIRST page if <frompage> NOT defined
			如果没有指定<frompage>，就从第一页开始拖
			
			will automatically determine LAST page if <topage> NOT defined
			如果没有指定<topage>，就自动（用dLastPage()函数）确定最后一页（其实这个功能并不好使）
			
		--from and --to will JUST be VOID outside default mode and -S/--sidefield
		如果在默认模式和-S/--sidefield之外使用--from和--to，它们仅仅没有效果而已
		
		AND now you can define from which SINGLE page the script will dump: (added 15.11.28)
		而且现在你可以指定拖哪一单页：（15.11.28添加）
		
		--page=<page>
		--page=<page>
		
			equals --from=<page> AND --to=<page>
			就等于--from=<page>和--to=<page>（但少用一个参数）
			
	-T or --thread: dump single thread
	-T或--thread：只下一个帖子

	-F or --files: distill info from pre-dumped files instead of from dindingo.com, 
	-F或--files：从事先拖下来的HTML文件里面分析信息

		in case you lose access to that fuckin' site
		万一你的帐号被封了就只能用这个选项了。其实我刚开始开发脚本的时候就是先分析文件的，因为那时我不知怎样获得cURL用来登那个傻♂逼网站的cookies

		and i think my script can differ folder from file, 
		而且我觉得我的脚本可以区分文件夹和文件，

		absolute path from relative path
		绝对路径和相对路径

download preview pictures: (added 15.10.04)

下载预览图：（15.10.04添加）

	-P or --pictures: download preview pictures from dindingo.com or elsewhere, needs -D/--download
	-P或--pictures：从下载预览图到本地，需要开启-D/--download选项

save file info into webpage: (added 15.10.04)

将文件信息保存成网页：（15.10.04添加）

	-W or --webpage: save file info into <tid>.html inside its folder, needs -D/--download AND -P/--pictures
	-W或--webpage：将文件信息保存到<tid>.html，放置于（视♂频和解压密码所在的）目录里，需要开启-D/--download和-P/--pictures选项（其实我还保存了一份index.html方便直接用目录来访问）

auto-unpack: (added 15.11.20)

自动解包：（15.10.20添加）

	-A or --auto-unpack: attempt to unpack the .rar/.zip files
	-A或--auto-unpack：试图用从帖子中拖下来的密码
	
	usin' the password dumped from the thread page
	来解压（拖下来的）.rar/.zip文件
	
		if succeed, the original .rar/.zip will be deleted
		如果成功，原来的.rar/.zip文件将被删除
		
		if failed due to incorrect password, 
		如果由于密码错误未成功，
		
		the original .rar/.zip will be left unchanged
		原来的.rar/.zip文件将被保留下来
		
	needs -D/--download
	需要开启-D/--download选项
	
encryption: (added 15.11.20)

加密：（15.10.20添加）

	-E or --encrypt: after download, calculate MD5, SHA1 and SHA256 of 
	-E或--encrypt：下载后，计算<tid>目录的
	
	<tid> directory and store individially, archive <tid> directory into a
	MD5、SHA1和SHA256校验并单独存放，将<tid>目录
	
	.rar file with random 64-bit password, delete source files, and 
	用64位的随机密码加密打包，删除源文件，并
	
	store filename-password infomations into pair.txt, needs -D/--download
	将文件名-密码信息存入pair.txt中，需要开启-D/--download选项

limitation: (added 15.11.29)

设置总文件大小限额：（15.10.04添加）

	--limitation=<limitation>: after each page, check if total file size
	--limitation=<limitation>：在每一页拖完后，检查总文件大小是否
	
	exceeds the limitation, if so the script will be stopped
	超过了设置的限额，如果超过了的话，脚本将中止
	
		the unit of the limitation is MB
		限额的单位是MB

Theorically you CAN put contradictin' options together, 

理论上说你可以把互相矛盾的选项（比如-d和-D，-S、-T和-F，以任何顺序）放一块，


but ONLY the LAST ones will be accepted as final options

但只有最后出现的选项才会被采纳，成为最终的选项（因为我的参数解析器每遍历到一个选项就会把代表选项的全局变量设为相应的值，当然最后出现的才是最终的选项）


help:

帮助：


	-H or -h or --help: ask for help, just like other Linux programs
	-H或-h或--help：获取帮助，就和其他Linux程序一样

parameter (fid/tid/folder/file): 

参数（fid/tid/文件夹/文件）：


	fid: DinDinGo Field ID (10, 23, 116, 117, 118 are the prono fields, others are just fuckin' stupid camouflage)
	fid：DinDinGo的板块id（10、23、116、117和118才是放片♂子的，其他板块只是伪装，而且是很傻♂逼的那种）

	tid: DinDinGo Thread ID
	tid：DinDinGo的帖子id

	folder: Specify folder storin' dumped HTMLs
	文件夹：指定放置拖下来的HTML文件的文件夹

	file: Specify HTML flie
	文件夹：指定拖下来的HTML文件

		File(s) MUST be named by its thread ID, <tid>.html and original form tid-<tid>.html are accepted
		文件必须命名成<tid>.html或者tid-<tid>.html的样子，其中<tid>是帖子id（也是下载片子时放置片子的文件夹）

		Otherwise <tid> will be found inside somewhere in the HTML file
		不然<tid>会在文件中某处被找到

		but the effects will NOT be graenteed because info from filename are used in HIGHER Priority
		但效果不受保证，因为文件名里的信息会优先使用

		Actually i haven't developed that "find-<tid>-inside-somewhere-in-the-HTML-file" feature 23333333333333
		其实我并没有开发从文件里挖掘tid的功能（主要是文件里的tid太多，我怎么知道哪个是这个文件的tid），23333333333333

HAVE A NICE DUMP, die♂deutsche♂Orthopädie out

拖♂站愉♂快，我要去德♂国♂骨♂科预订床位了


ps. 

	长发都tm是怪♂物

	long hair girls are all fuckin' mons♂ters

	短发才tm是萌♂妹

	short hair girls are all fuckin' moe♂girls

	短发大♂法好

	VIVA♂LA SHORT HAIR

pps. 

	由于此脚♂本杀♂伤力极大，基本上达到了战♂术♂核♂武的级别，考虑到dindingo.com的所有者可能还处在攒他的第一个一百♂万好掏首付买房哄骗他的未来傻♂逼丈母娘的阶段，这个脚♂本我就暂且不放出了。至少也得等我拖完其所有片♂子再说。
	
	Due to the destructive leth♂ality of this tac♂ti♂cal nuc♂lear wea♂pon grade scr♂ipt, with all due res♂pect, considerin' the owner(s) of the dindingo.com may in the state of getting' his first mill♂ion to pay the downpayment on a flat to please his future stupid mother♂fuck♂in' dou♂che♂bag mother-in-law ass♂hole, I will NOT release the scr♂ipt. At least until I finish dumpin' ALL their pro♂nos. 

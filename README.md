# dindingou
die deutsche Orthopädie proundly presents

ALL in ONE DinDinGo Pronography Dump Script

combine forumdump.sh and combined.distiller.and.downloader.plus.singlefile.support.sh

reconstructed and optimized for smaller size and better code readability

and use new kind of parameter interpreters



usage: 

all.in.one.sh [options] parameter



options:



dump levels:

	default: only gain info from dindingo.com

	-d or --deep-analysis: deep analysis mode, will download file info from colayun.com aka coladisk.com but NOT download any file from coladisk

	-D or --download: download mode, will download file info AND file from colayun.com aka coladisk.com



sidefield/threads/flie:

	default: traverse the main threads

	-S or --sidefield: traverse the side threads instead of the main threads, 

	i heard the rumor that side threads are the distilled resources of the main threads

	-T or --thread: dump single thread

	-F or --files: distill info from pre-dumped files instead of from dindingo.com, 

		in case you lose access to that fuckin' site

	and i think my script can differ folder from file, 

	absolute path from relative path



Theorically you CAN put contradictin' options together, 

but ONLY the LAST ones will be accepted as final options



help:

	-H or -h or --help: ask for help



parameter (fid/tid/folder/file): 

	fid: DinDinGo Field ID (10, 23, 116, 117, 118 are the prono fields, others are just fuckin' stupid camouflage)

	tid: DinDinGo Thread ID

	folder: Specify folder storin' dumped HTMLs

	file: Specify HTML flie

		File(s) MUST be named by its thread ID, <tid>.html and original form tid-<tid>.html are accepted

		Otherwise <tid> will be found inside somewhere in the HTML file

 	but the effects will NOT be graenteed because info from filename are used in HIGHER Priority

		Actually i haven't developed that "find-<tid>-inside-somewhere-in-the-HTML-file" feature 23333333333333



HAVE A NICE DUMP, die deutsche Orthopädie out



ps. 

	长发都tm是怪物

	long hair girls are all fuckin' monsters

	短发才tm是萌妹

	short hair girls are all fuckin' moe girls

	短发大法好

	VIVA LA SHORT HAIR

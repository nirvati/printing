#!/bin/sh
#----------------------------------------------------------------------
# Creates a font sample PDF file from a TTF file
#
# Dependency:
#
# sudo apt-get install fntsample
#
# http://sourceforge.net/projects/fntsample/
#
# fntsample program generates font samples that show Unicode coverage
# of the font and are similar in appearance to Unicode charts.
#----------------------------------------------------------------------

#----------------------------------------------------------------------
#
# Parameters:
#
# $1	: path of TTF file
# $2	: target directory of PDF file
# $3    : (optional) the name of the font as replacement in the outline
# 
# Output:
#
#----------------------------------------------------------------------
createFntSamplePdf () {
	
	ttfFile="$1"
	pdfFile="$2/`basename ${ttfFile} .ttf`.pdf"
		
	tmpPdf=`mktemp`
	tmpOutline=`mktemp`
	tmpOutline2=`mktemp`

	echo "Creating ${pdfFile} from ${ttfFile}"
		
	fntsample -f ${ttfFile} -o ${tmpPdf} -l > ${tmpOutline}
	
	if [ -n "$3" ]
	then
		echo "Replace font name in 1st line of outline with: $3"
		echo "0 1 $3" > ${tmpOutline2}
		more +2 ${tmpOutline} >> ${tmpOutline2}
		tmpOutline=${tmpOutline2}			
	fi
	
	pdfoutline ${tmpPdf} ${tmpOutline} ${pdfFile}

	echo "done"
			
	rm -f ${tmpPdf} ${tmpOutline} ${tmpOutline2}
	
	return 0; 
}

#----------------------------------------------------------------------
usage() {
	echo "Usage: $1 <input file> <output directory> [font name]"
}

#----------------------------------------------------------------------
#
# Parameters:
#
# $1	: path of TTF file
# $2	: target directory of PDF file
# $3    : (optional) the name of the font as replacement in the outline
#----------------------------------------------------------------------

if [ $# -lt 2 ] ; then
	usage $0  
	exit 0
fi

createFntSamplePdf $1 $2 $3

exit 0

# end-of-script

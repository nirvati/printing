#!/bin/sh
#
# This file is part of the SavaPage project <https://www.savapage.org>.
# Copyright (c) 2011-2017 Datraverse B.V.
# Author: Rijk Ravestein.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# For more information, please contact Datraverse B.V. at this
# address: info@datraverse.com
#

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

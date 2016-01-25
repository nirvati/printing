#!/bin/sh
#
# This file is part of the SavaPage project <http://savapage.org>.
# Copyright (c) 2011-2015 Datraverse B.V.
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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# For more information, please contact Datraverse B.V. at this
# address: info@datraverse.com
#

#set -x

#=========================================================================
# Prepare for packaging: prune, change, reorganize
#=========================================================================

#--------------------------------------------------------------------
# Get the absolute path of this (symlinked) file
#--------------------------------------------------------------------
SP_SELF_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P) && SP_SELF_PATH=$SP_SELF_PATH/$(basename -- "$0")
# resolve symlinks
while [ -h $SP_SELF_PATH ]; do
    # 1) cd to directory of the symlink
    # 2) cd to the directory of where the symlink points
    # 3) get the pwd
    # 4) append the basename
    SP_DIR=$(dirname -- "$SP_SELF_PATH")
    SP_SYM=$(readlink $SP_SELF_PATH)
    SP_SELF_PATH=$(cd $SP_DIR && cd $(dirname -- "$SP_SYM") && pwd)/$(basename -- "$SP_SYM")
done
_CURRENTDIR=`dirname ${SP_SELF_PATH}`

#--------------------------------------------------------------------
. ${_CURRENTDIR}/pkg-settings

#=========================================================================
# CONSTANTS
#=========================================================================

#----------------------------------------
# Remove old 
#----------------------------------------
rm -rf ${_PREP_HOME}

#=========================================================================
# savapage-server.war
#=========================================================================
readonly WAR_ZIP_NAME=${_SAVAPAGE_SERVER_WAR}
readonly WAR_HOME=${_PREP_HOME}/${WAR_ZIP_NAME}_WORK

readonly WAR_ZIP_SRC=${_REPO_HOME_PUB}/savapage-server/target/${WAR_ZIP_NAME}

#----------------------------------------
# Make room
#----------------------------------------
mkdir --parent ${WAR_HOME}

#----------------------------------------
# Extract 
#----------------------------------------
unzip -q ${WAR_ZIP_SRC} -d ${WAR_HOME}

#----------------------------------------
# Prune
#----------------------------------------
rm -rf ${WAR_HOME}/META-INF/maven

#----------------------------------------
# Change
#----------------------------------------
#TODO : adapt META-INF/MANIFEST.MF

#-------------------------------------------------
# Add minimized savapage *.js and *.css files ?
#-------------------------------------------------

if [ -f "${YUICOMPRESSOR_JAR}" ]; then

	echo "+----------------------------------------"
	
	_COMPRESS_SOURCES="savapage
		jquery.savapage
	    jquery.savapage-exceeded
	    jquery.savapage-user
	    jquery.savapage-admin
		jquery.savapage-admin-panels
	    jquery.savapage-admin-pages
		jquery.savapage-jobtickets	    
	    jquery.savapage-pos
		jquery.savapage-page-jobtickets
		jquery.savapage-page-pos
		jquery.savapage-page-print-delegation"
	        
	for _src in ${_COMPRESS_SOURCES}
	do
		_TRG_MIN_BASE=${_src}-min.js
		_TRG_MIN_PATH=${WAR_HOME}/${_TRG_MIN_BASE}
		_SRC_PATH=${WAR_HOME}/${_src}.js
		echo "| Add ${_TRG_MIN_BASE}"
		java -jar ${YUICOMPRESSOR_JAR} -o ${_TRG_MIN_PATH} ${_SRC_PATH}
	done
		
	echo "+----------------------------------------"
				
	_COMPRESS_SOURCES="jquery.savapage
		jquery.savapage-user
		jquery.savapage-admin
		jquery.savapage-jobtickets
		jquery.savapage-pos"
				
	for _src in ${_COMPRESS_SOURCES}
	do
		_TRG_MIN_BASE=${_src}-min.css
		_TRG_MIN_PATH=${WAR_HOME}/${_TRG_MIN_BASE}
		_SRC_PATH=${WAR_HOME}/${_src}.css
		echo "| Add ${_TRG_MIN_BASE}"
		java -jar ${YUICOMPRESSOR_JAR} -o ${_TRG_MIN_PATH} ${_SRC_PATH}
	done	
								
	echo "+----------------------------------------"
fi

#-----------------------------------------------------------------------------
# Class files from WEB-INF/classes directory in .war are packaged in a .jar 
#-----------------------------------------------------------------------------
readonly ADHOC_ZIP_NAME=${_SAVAPAGE_AD_HOC_SERVER_JAR}
readonly ADHOC_HOME=${_PREP_HOME}/${ADHOC_ZIP_NAME}_AD_HOC

#----------------------------------------
# Move /classes to the ad-hoc jar file
#----------------------------------------
mkdir --parent ${ADHOC_HOME}
mv ${WAR_HOME}/WEB-INF/classes/ ${ADHOC_HOME}

cd ${ADHOC_HOME}/classes
zip -q -r ${_PREP_HOME}/${ADHOC_ZIP_NAME} ./*
cd ${_CURRENTDIR}

#-----------------------------------------------------------------------------
# Move ad-hoc jar file back into war file
#-----------------------------------------------------------------------------
cp ${_PREP_HOME}/${ADHOC_ZIP_NAME} ${WAR_HOME}/WEB-INF/lib/

#=========================================================================
# savapage-common.jar
#=========================================================================

WORK_ZIP_NAME=${_SAVAPAGE_COMMON_JAR}
WORK_HOME=${_PREP_HOME}/${WORK_ZIP_NAME}_WORK
WORK_ZIP_SRC=${_REPO_HOME_PUB}/savapage-common/target/${WORK_ZIP_NAME}

echo "+--------------------------------------------------------------"
echo "| Prepare ${WORK_ZIP_NAME}"
echo "+--------------------------------------------------------------"

#----------------------------------------
# Make room
#----------------------------------------
mkdir --parent ${WORK_HOME}

#----------------------------------------
# Extract 
#----------------------------------------
unzip -q ${WORK_ZIP_SRC} -d ${WORK_HOME}

#----------------------------------------
# Prune
#----------------------------------------
rm -rf ${WORK_HOME}/META-INF/maven

#----------------------------------------
# Change
#----------------------------------------
#TODO : adapt META-INF/MANIFEST.MF

#------------------------------------------------------------------------------
# Zip-up 
#------------------------------------------------------------------------------
cd ${WORK_HOME}
zip -q -r ${_PREP_HOME}/${WORK_ZIP_NAME} ./*
cd ${_CURRENTDIR}

#=========================================================================
# savapage-ext.jar
#=========================================================================
WORK_ZIP_NAME=${_SAVAPAGE_EXT_JAR}
WORK_HOME=${_PREP_HOME}/${WORK_ZIP_NAME}_WORK
WORK_ZIP_SRC=${_REPO_HOME_PUB}/savapage-ext/target/${WORK_ZIP_NAME}

echo "+--------------------------------------------------------------"
echo "| Prepare ${WORK_ZIP_NAME}"
echo "+--------------------------------------------------------------"

#----------------------------------------
# Make room
#----------------------------------------
mkdir --parent ${WORK_HOME}

#----------------------------------------
# Extract 
#----------------------------------------
unzip -q ${WORK_ZIP_SRC} -d ${WORK_HOME}

#----------------------------------------
# Prune
#----------------------------------------
rm -rf ${WORK_HOME}/META-INF/maven

#----------------------------------------
# Change
#----------------------------------------
#TODO : adapt META-INF/MANIFEST.MF

#------------------------------------------------------------------------------
# Zip-up 
#------------------------------------------------------------------------------
cd ${WORK_HOME}
zip -q -r ${_PREP_HOME}/${WORK_ZIP_NAME} ./*
cd ${_CURRENTDIR}

#=========================================================================
# savapage-ext-mollie.jar
#=========================================================================
WORK_ZIP_NAME=${_SAVAPAGE_EXT_MOLLIE_JAR}
WORK_HOME=${_PREP_HOME}/${WORK_ZIP_NAME}_WORK
WORK_ZIP_SRC=${_REPO_HOME_PUB}/savapage-ext-mollie/target/${WORK_ZIP_NAME}

echo "+--------------------------------------------------------------"
echo "| Prepare ${WORK_ZIP_NAME}"
echo "+--------------------------------------------------------------"

#----------------------------------------
# Make room
#----------------------------------------
mkdir --parent ${WORK_HOME}

#----------------------------------------
# Extract 
#----------------------------------------
unzip -q ${WORK_ZIP_SRC} -d ${WORK_HOME}

#----------------------------------------
# Prune
#----------------------------------------
rm -rf ${WORK_HOME}/META-INF/maven

#----------------------------------------
# Change
#----------------------------------------
#TODO : adapt META-INF/MANIFEST.MF

#------------------------------------------------------------------------------
# Zip-up 
#------------------------------------------------------------------------------
cd ${WORK_HOME}
zip -q -r ${_PREP_HOME}/${WORK_ZIP_NAME} ./*
cd ${_CURRENTDIR}

#=========================================================================
# savapage-ext-blockchain-info.jar
#=========================================================================
WORK_ZIP_NAME=${_SAVAPAGE_EXT_BLOCKCHAIN_INFO_JAR}
WORK_HOME=${_PREP_HOME}/${WORK_ZIP_NAME}_WORK
WORK_ZIP_SRC=${_REPO_HOME_PUB}/savapage-ext-blockchain-info/target/${WORK_ZIP_NAME}

echo "+--------------------------------------------------------------"
echo "| Prepare ${WORK_ZIP_NAME}"
echo "+--------------------------------------------------------------"

#----------------------------------------
# Make room
#----------------------------------------
mkdir --parent ${WORK_HOME}

#----------------------------------------
# Extract 
#----------------------------------------
unzip -q ${WORK_ZIP_SRC} -d ${WORK_HOME}

#----------------------------------------
# Prune
#----------------------------------------
rm -rf ${WORK_HOME}/META-INF/maven

#----------------------------------------
# Change
#----------------------------------------
#TODO : adapt META-INF/MANIFEST.MF

#------------------------------------------------------------------------------
# Zip-up 
#------------------------------------------------------------------------------
cd ${WORK_HOME}
zip -q -r ${_PREP_HOME}/${WORK_ZIP_NAME} ./*
cd ${_CURRENTDIR}

#=========================================================================
# savapage-core.jar
#=========================================================================
WORK_ZIP_NAME=${_SAVAPAGE_CORE_JAR}
WORK_HOME=${_PREP_HOME}/${WORK_ZIP_NAME}_WORK
WORK_ZIP_SRC=${_REPO_HOME_PUB}/savapage-core/target/${WORK_ZIP_NAME}

echo "+--------------------------------------------------------------"
echo "| Prepare ${WORK_ZIP_NAME}"
echo "+--------------------------------------------------------------"

#----------------------------------------
# Make room
#----------------------------------------
mkdir --parent ${WORK_HOME}

#----------------------------------------
# Extract 
#----------------------------------------
unzip -q ${WORK_ZIP_SRC} -d ${WORK_HOME}

#----------------------------------------
# Prune
#----------------------------------------
rm -rf ${WORK_HOME}/META-INF/maven

#----------------------------------------
# Change
#----------------------------------------
#TODO : adapt META-INF/MANIFEST.MF

#----------------------------------------
# Package (embed) Fonts in core jar
#----------------------------------------

# Remove any existing fonts
cd ${WORK_HOME}/org/savapage/core/fonts/
rm -rf truetype

# Copy fonts (if present)
if [ -d "${_FONTS_PACKAGE_HOME}" ]; then
	echo "Embedding external fonts ..."
	cp -avr ${_FONTS_PACKAGE_HOME}/ truetype/ 
else
	# By removing the properties file font extention is disabled, so fonts
	# fall back to the ones supported by the JVM.
	echo "No external fonts: remove jasperreports_extension.properties."
	rm ${WORK_HOME}/jasperreports_extension.properties
fi

cd ${_CURRENTDIR}

#------------------------------------------------------------------------------
# Zip-up 
#------------------------------------------------------------------------------
cd ${WORK_HOME}
zip -q -r ${_PREP_HOME}/${WORK_ZIP_NAME} ./*
cd ${_CURRENTDIR}


#==============================================================================
# Finishing the WAR file 
#==============================================================================

echo "+--------------------------------------------------------------"
echo "| Finishing the .war file"
echo "+--------------------------------------------------------------"

#-----------------------------------------------------------------------------
# Move ${WAR_HOME}/WEB-INF/lib/*.jar to a save place to use later   
#-----------------------------------------------------------------------------

#make room
mkdir --parent ${_PREP_WEB_LIB_HOME}

# move jar files (including savapage*.jar files)
mv ${WAR_HOME}/WEB-INF/lib/*.jar ${_PREP_WEB_LIB_HOME}

#-----------------------------------------------------------------------------
# Zip-up the .war file
#-----------------------------------------------------------------------------
cd ${WAR_HOME}
zip -q -r ${_PREP_HOME}/${WAR_ZIP_NAME} ./*
cd ${_CURRENTDIR}

#==============================================================================
# Copy re-engineered jar files to ${_PREP_WEB_LIB_HOME}
# (overwriting previously copied ones from .war file)
#==============================================================================
cp ${_PREP_HOME}/${_SAVAPAGE_COMMON_JAR} ${_PREP_WEB_LIB_HOME}
cp ${_PREP_HOME}/${_SAVAPAGE_CORE_JAR} ${_PREP_WEB_LIB_HOME}

# end-of-script

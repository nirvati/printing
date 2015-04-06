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
# Command Line Parameters
# $1 : architecture ( x64 | i686 )
#=========================================================================
_ARCH=$1

if [ -z "${_ARCH}" ]; then
    echo "Usage: `basename $0` [x64|i686]" 1>&2
    exit 1
fi

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

readonly DIST_NAME=${APP_NAME}-setup-${APP_VERSION}-linux-${_ARCH}
readonly DIST_HOME=${DIST_PARENT}/${DIST_NAME}

# 
readonly DIST_HOME_APP=${DIST_HOME}/${APP_NAME}

readonly DIST_DOCBOOK_HTMLCHUNK=${DIST_HOME_APP}/server/data/docs/manual
readonly DIST_MVN_SITE_HTML=${DIST_HOME_APP}/server/data/docs/licenses
readonly DIST_DOC_FONTS=${DIST_HOME_APP}/server/data/docs/fonts

#
readonly DIST_PROVIDER_CUPS=${DIST_HOME_APP}/providers/cups/linux-${_ARCH}

#
readonly SAVAPAGE_PPD_FILE=${_REPO_HOME_PPD}/ppd/SAVAPAGE.ppd
readonly SAVAPAGE_INF_FILE=${_REPO_HOME_PPD}/client/win/win7/savapage_oemui.inf
readonly SAVAPAGE_INI_FILE=${_REPO_HOME_PPD}/client/win/win7/savapage_oemui.ini

#
readonly DIST_SERVER_BIN_HOME=${DIST_HOME_APP}/server/bin/linux-${_ARCH}
readonly SERVER_BIN_BUILD_HOME=${DIST_PARENT}/linux-${_ARCH}

#
readonly LINUX_ARMV6=${_SAVED_BUILD_TARGETS_HOME}/linux-armv6
readonly DIST_NFC_ARMV6_BIN_HOME=${DIST_HOME_APP}/providers/nfc/linux-armv6

#----------------------------------------
# Remove old distribution
#----------------------------------------
echo "Removing old target files..."
rm -rf ${DIST_HOME}
rm -f ${DIST_PARENT}/${DIST_NAME}*

#----------------------------------------
# Create again ...
#----------------------------------------
mkdir --parent ${DIST_HOME}

#----------------------------------------
# Apply the template
#----------------------------------------
cp -R ${_SETUP_TEMPLATE_HOME} ${DIST_HOME}

#------------------------------------------------------------------------
# Copy the recomposed war file: this is the file mentioned 
# in -Dsavapage.war.file=savapage-server-<version>.war
#------------------------------------------------------------------------
cp -R ${_PREP_HOME}/${_SAVAPAGE_SERVER_WAR} ${DIST_HOME_APP}/server/lib

#------------------------------------------------------------------------
# Copy the saved WEB-INF/lib/*.jar from the WAR file to ...
#------------------------------------------------------------------------
cp ${_PREP_WEB_LIB_HOME}/*.jar ${DIST_HOME_APP}/server/lib/web

#----------------------------------------
# Applying architecture
#----------------------------------------
mv ${DIST_HOME_APP}/server/bin/linux ${DIST_SERVER_BIN_HOME}
mv ${DIST_HOME_APP}/providers/cups/linux ${DIST_PROVIDER_CUPS}

#----------------------------------------
# Copy SavaPage printer files
#----------------------------------------
echo "Including SavaPage printer driver..."
cp ${SAVAPAGE_PPD_FILE}  ${DIST_HOME_APP}/client
cp ${SAVAPAGE_PPD_FILE}  ${DIST_HOME_APP}/client/win
cp ${SAVAPAGE_INF_FILE}  ${DIST_HOME_APP}/client/win
cp ${SAVAPAGE_INI_FILE}  ${DIST_HOME_APP}/client/win

if [ -d "${_WIN_PPD_DRIVER_DLL_HOME}" ]; then
	echo "Including Windows OEM printer driver..."
	cp -R ${_WIN_PPD_DRIVER_DLL_HOME}/* ${DIST_HOME_APP}/client/win/
fi
 

#----------------------------------------
# Copy the SavaPage Client 
#----------------------------------------
echo "Including SavaPage Client..."
cp -R ${_REPO_HOME_CLIENT}/target/appassembler/app ${DIST_HOME_APP}/client


#----------------------------------------
# Copy C binaries
#----------------------------------------
echo "Including C binaries ..."
cp ${SERVER_BIN_BUILD_HOME}/savapage-notifier ${DIST_PROVIDER_CUPS}
cp ${SERVER_BIN_BUILD_HOME}/savapage-nss ${DIST_SERVER_BIN_HOME}
cp ${SERVER_BIN_BUILD_HOME}/savapage-pam ${DIST_SERVER_BIN_HOME}

if [ -d "${LINUX_ARMV6}" ]; then
    if [ "$(ls -A ${LINUX_ARMV6})" ]; then
		echo "Including ARMV6 binary ..."
		cp ${LINUX_ARMV6}/* ${DIST_NFC_ARMV6_BIN_HOME}
    fi	
fi


#------------------------------------------------------------------------
# Create version file. This file is sourced into the app-server script.
#------------------------------------------------------------------------
echo APP_VERSION=${APP_VERSION} > ${DIST_SERVER_BIN_HOME}/.app-version.inc.sh


#----------------------------------------
# Derby database 
# (initialized database + create script)
#----------------------------------------
echo "Including Derby database..."
cp -R ${_DERBY_DBNAME} ${DIST_HOME_APP}/server/data/internal/Derby


#----------------------------------------
# User Manual HTML
#----------------------------------------
mkdir --parent ${DIST_DOCBOOK_HTMLCHUNK}
_SAVED_HOME=${_SAVED_BUILD_TARGETS_HOME}/savapage-manual/html 
if [ -d "${_SAVED_HOME}" ]; then
    if [ "$(ls -A ${_SAVED_HOME})" ]; then
		echo "Include User Manual ..."
		cp -R ${_SAVED_HOME}/* ${DIST_DOCBOOK_HTMLCHUNK}
    fi	
fi

#----------------------------------------
# Third Party License Information HTML
#----------------------------------------

#----------------------------------------
# Licenses (mvn site) as HTML
#----------------------------------------
mkdir --parent ${DIST_MVN_SITE_HTML}
_SAVED_HOME=${_SAVED_BUILD_TARGETS_HOME}/savapage-licenses/html 
if [ -d "${_SAVED_HOME}" ]; then
    if [ "$(ls -A ${_SAVED_HOME})" ]; then
		echo "Include Third Party License information ..."
		cp -R ${_SAVED_HOME}/* ${DIST_MVN_SITE_HTML}
    fi	
fi

#----------------------------------------
# Create font sample PDFs
#----------------------------------------

#----------------------------------------------
# PDF documents with sample of internal fonts
#----------------------------------------------
echo "Create PDF documents with sample of internal fonts..."
mkdir --parent ${DIST_DOC_FONTS}

_SAVED_HOME=${_FONTS_PACKAGE_HOME}/dejavu
if [ -d "${_SAVED_HOME}" ]; then
	./create-fntsample-pdf.sh ${_SAVED_HOME}/DejaVuSans.ttf ${DIST_DOC_FONTS} DejaVuSans
fi

_SAVED_HOME=${_FONTS_PACKAGE_HOME}/droid
if [ -d "${_SAVED_HOME}" ]; then
	./create-fntsample-pdf.sh ${_SAVED_HOME}/DroidSansFallbackFull.ttf ${DIST_DOC_FONTS} DroidSansFallbackFull
fi

#----------------------------------------
# Create binary setup file
#----------------------------------------

rm `find ${DIST_PARENT}/ -type f -name .gitignore`

#----------------------------------------
# create self-extracting .bin setup file
#----------------------------------------
DIST_TAR=${DIST_PARENT}/${DIST_NAME}.tar.gz
DIST_SFX=${DIST_PARENT}/${DIST_NAME}.bin

tar -czvf ${DIST_TAR} -C ${DIST_HOME} ${APP_NAME}/
cat setup-sfx.sh ${DIST_TAR} > ${DIST_SFX}
chmod +x ${DIST_SFX}


#-------------------------------------------------------------------
# Create MD5 and SHA1 checksum is separate file
#-------------------------------------------------------------------
echo "Create checksums..."
openssl dgst -md5  -binary ${DIST_SFX} | xxd -p > ${DIST_SFX}.md5
openssl dgst -sha1 -binary ${DIST_SFX} | xxd -p > ${DIST_SFX}.sha1


#-------------------------------------------------------------------
# Create a PGP ascii signature in a separate .asc file
#-------------------------------------------------------------------

haspgp=`which pgp 2> /dev/null`
if [ -z "${haspgp}" ]; then
	echo "Cannot create PGP signature (pgp not installed)." >&2
else
	echo "Create PGP signature..."
	pgp -sab ${DIST_SFX}
fi

# end-of-file

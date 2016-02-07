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
# Packages savapage*.jar and savapage*.war into an tar.gz patch file 
# to be extracted into savapage install directory 
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

readonly _PREP_PATCH_HOME=${DIST_PARENT}/~patch-files

readonly _PREP_PATCH_LIB_CLIENT_HOME=${_PREP_PATCH_HOME}/client/app/lib
readonly _PREP_PATCH_LIB_SERVER_HOME=${_PREP_PATCH_HOME}/server/lib
readonly _PREP_PATCH_LIB_SERVER_EXT_HOME=${_PREP_PATCH_HOME}/server/ext/lib
readonly _PREP_PATCH_LIB_WEB_HOME=${_PREP_PATCH_LIB_SERVER_HOME}/web

rm -rf ${_PREP_PATCH_HOME}

#make room
mkdir --parent ${_PREP_PATCH_LIB_CLIENT_HOME}
mkdir --parent ${_PREP_PATCH_LIB_WEB_HOME}
mkdir --parent ${_PREP_PATCH_LIB_SERVER_EXT_HOME}

# savapage-server-*.war
cp -p ${_PREP_HOME}/${_SAVAPAGE_SERVER_WAR} ${_PREP_PATCH_LIB_SERVER_HOME}

# savapage-common-*.jar
cp -p ${_PREP_WEB_LIB_HOME}/${_SAVAPAGE_COMMON_JAR} ${_PREP_PATCH_LIB_WEB_HOME}
cp -p ${_PREP_WEB_LIB_HOME}/${_SAVAPAGE_COMMON_JAR} ${_PREP_PATCH_LIB_CLIENT_HOME}

# savapage-i18n-*.jar
cp -p ${_PREP_WEB_LIB_HOME}/${_SAVAPAGE_I18N_DE_JAR} ${_PREP_PATCH_LIB_WEB_HOME}

# savapage-client-*.jar
cp -p ${_REPO_HOME_CLIENT}/target/${_SAVAPAGE_CLIENT_JAR} ${_PREP_PATCH_LIB_CLIENT_HOME}

# savapage-core-*.jar
cp -p ${_PREP_WEB_LIB_HOME}/${_SAVAPAGE_CORE_JAR} ${_PREP_PATCH_LIB_WEB_HOME}

# savapage-ext-*.jar
cp -p ${_PREP_WEB_LIB_HOME}/${_SAVAPAGE_EXT_JAR} ${_PREP_PATCH_LIB_WEB_HOME}

# savapage-ext-*-*.jar
cp -p ${_PREP_HOME}/${_SAVAPAGE_EXT_MOLLIE_JAR} ${_PREP_PATCH_LIB_SERVER_EXT_HOME}
cp -p ${_PREP_HOME}/${_SAVAPAGE_EXT_BLOCKCHAIN_INFO_JAR} ${_PREP_PATCH_LIB_SERVER_EXT_HOME}

# savapage-server-*.jar
cp -p ${_PREP_WEB_LIB_HOME}/${_SAVAPAGE_AD_HOC_SERVER_JAR} ${_PREP_PATCH_LIB_WEB_HOME}

# create the *.tar.gz file
_PATCH_TARGZ_FILE=${DIST_NAME_PATCH}.tar.gz
_PATCH_TARGZ_PATH=${DIST_PARENT}/${_PATCH_TARGZ_FILE}

echo "+---------------------------------------------------------"
echo "| Creating ${_PATCH_TARGZ_FILE}"
echo "+---------------------------------------------------------"

tar -czvf ${_PATCH_TARGZ_PATH} -C ${_PREP_PATCH_HOME} ./

# end-of-script

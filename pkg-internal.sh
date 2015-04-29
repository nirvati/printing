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
# Package internal application(s)
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
readonly DIST_NAME=${DIST_NAME_INTERNAL}
readonly DIST_HOME=${DIST_PARENT}/${DIST_NAME}

# see savapage-util/pom.xml
readonly MVN_UTIL_APP_TARGET=${_REPO_HOME_UTIL}/target/appassembler

#----------------------------------------
# Remove old distribution
#----------------------------------------
rm -rf ${DIST_HOME}

#----------------------------------------
# Create again ...
#----------------------------------------
mkdir --parent ${DIST_HOME}/bin
mkdir --parent ${DIST_HOME}/lib

#----------------------------------------
# Copy lib files  
#----------------------------------------
cp -R ${MVN_UTIL_APP_TARGET}/lib/* ${DIST_HOME}/lib

#----------------------------------------
# Copy binaries 
#----------------------------------------
cp -R ${MVN_UTIL_APP_TARGET}/bin/*util ${DIST_HOME}/bin

chmod +x ${DIST_HOME}/bin/*

#----------------------------------------
# Testing
#----------------------------------------

echo "--------------------------------------"
`find ${DIST_HOME}/bin/ -name "*util"` -h
echo "--------------------------------------"

# end-of-file

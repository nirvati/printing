#!/bin/sh
#
# This file is part of the SavaPage project <https://www.savapage.org>.
# Copyright (c) 2011-2018 Datraverse B.V.
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

#------------------------------------------------------------------------------
# Executes a git command for all repositories 
#
# All command line options are passed in one (1) string.
#------------------------------------------------------------------------------
readonly _CLI_OPTIONS=$1

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

_CURRENTDIR=$(dirname "${SP_SELF_PATH}")

#--------------------------------------------------------------------
. ${_CURRENTDIR}/dev-settings
. ${_CURRENTDIR}/pkg-settings

#--------------------------------------------------------------------
# navigate to savapage development home
cd ${_CURRENTDIR}/../..

#--------------------------------------------------------------------
# create directory structure

readonly _SP_SAVED_TRG_HOME=${_SAVED_BUILD_TARGETS_HOME}

readonly _SP_DIR_PATH="${_SP_SAVED_TRG_HOME}/savapage-manual/html
    ${_SP_SAVED_TRG_HOME}/savapage-licenses/html"
        
for dirpath in ${_SP_DIR_PATH}
do
    mkdir -p ${dirpath}
done

#--------------------------------------------------------------------
cd ${_CURRENTDIR}

# end-of-file

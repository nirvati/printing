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

#-----------------------------------------------------------------------------
# Common shell functions, constants and defaults
#-----------------------------------------------------------------------------

readonly APP_NAME="SavaPage Application Server"
readonly HOST_USER=savapage
readonly APP_NAME_SHORT=savapage

#--------------------------------------------------------------------
# Get the absolute path of this (symlinked) file
#--------------------------------------------------------------------
SELF_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P) && SELF_PATH=$SELF_PATH/$(basename -- "$0")
# resolve symlinks
while [ -h $SELF_PATH ]; do
    # 1) cd to directory of the symlink
    # 2) cd to the directory of where the symlink points
    # 3) get the pwd
    # 4) append the basename
    DIR=$(dirname -- "$SELF_PATH")
    SYM=$(readlink $SELF_PATH)
    SELF_PATH=$(cd $DIR && cd $(dirname -- "$SYM") && pwd)/$(basename -- "$SYM")
done
#--------------------------------------------------------------------
currentdir=`dirname ${SELF_PATH}`

readonly SCRIPT_HOME=`cd "${currentdir}"; pwd`
readonly SERVER_HOME=`cd "${SCRIPT_HOME}/../../"; pwd`
readonly CLIENT_HOME=`cd "${SERVER_HOME}/../client/"; pwd`
  
readonly TMP_DIR=${SERVER_HOME}/tmp
readonly LOG_DIR=${SERVER_HOME}/logs

readonly SERVER_PID=${LOG_DIR}/service.pid

readonly PAM_SERVERNAME=savapage

#
# Setup Classpath
#
CLASSPATH=${SERVER_HOME}/lib/web/*:${SERVER_HOME}/ext/lib/*

# Check the server/bin/linux-* for the architecture
if [ -d "${SERVER_HOME}/bin/linux-x64" ]; then
    ARCH=x64
else
    ARCH=i686
fi

#---------------------------------------
# Check to see if the server is running
#---------------------------------------
server_running () {
	ps_alive=0
	if [ -f "${SERVER_PID}" ] && ps `cat ${SERVER_PID}` >/dev/null 2>&1
	then 
		ps_alive=1;
		return 0
	else
		return 1
	fi
}

# end-of-script

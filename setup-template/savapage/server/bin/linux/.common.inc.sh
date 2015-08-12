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

#-----------------------------------------------------------------------------
# Common shell functions, constants and defaults
#-----------------------------------------------------------------------------

APP_NAME="SavaPage Application Server"

HOST_USER=savapage

APP_NAME_SHORT=savapage

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

#---------------------------------------------------
# Check to see systemd and sysvinit are present
#---------------------------------------------------
_do_has_os_systemd() {
    local is_present=`which systemctl`
    if [ ! -z "${is_present}" ]; then     
        echo "1"
    fi 
}

_do_has_os_sysvinit() {
    if [ -d "/etc/init.d" ]; then    
        echo "1"
    fi 
}

#---------------------------------------------------
# Is this OS a Debian offspring?
#---------------------------------------------------
_do_is_os_debian_based() {
    if [ ! -z `which dpkg` ]; then
        echo "1"
    fi 
}

#---------------------------------------------------
# echo without linefeed.
#---------------------------------------------------
if [ -n"X`echo -n`" = "X-n" ]; then
    echo_n() { echo ${1+"$@"}"\c"; }
else
    echo_n() { echo -n ${1+"$@"}; }
fi

#---------------------------------------------------------------------------
# Constants 
#---------------------------------------------------------------------------
readonly _OS_IS_DEBIAN_BASED=$(_do_is_os_debian_based)
readonly _OS_HAS_SYSVINIT=$(_do_has_os_sysvinit)
readonly _OS_HAS_SYSTEMD=$(_do_has_os_systemd)

readonly _SYSTEMD_SERVICE_FILENAME=savapage.service
readonly _SYSTEMD_SERVICE_FILEPATH="/lib/systemd/system/${_SYSTEMD_SERVICE_FILENAME}"

# end-of-script

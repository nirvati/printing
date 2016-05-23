#
# This file is part of the SavaPage project <http://savapage.org>.
# Copyright (c) 2011-2016 Datraverse B.V.
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

#---------------------------------------------------
# Check to see systemd and sysvinit are present
#---------------------------------------------------
_do_has_os_systemd() {
    local is_present=`which systemctl 2> /dev/null`
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
    if [ ! -z `which dpkg 2> /dev/null` ]; then
        echo "1"
    fi 
}

#---------------------------------------------------
# Find the lib/systemd home location 
#---------------------------------------------------
_do_find_lib_systemd_system() {

    locs="/lib/systemd/system
            /usr/lib/systemd/system"

    for d in ${locs}; do
        if [ -d "${d}" ]; then
            echo "${d}"
            exit 0
        fi
    done
    exit 1
}

#---------------------------------------------------
# Find the etc/systemd home location 
#---------------------------------------------------
_do_find_etc_systemd_system() {

    locs="/etc/systemd/system"

    for d in ${locs}; do
        if [ -d "${d}" ]; then
            echo "${d}"
            exit 0
        fi
    done
    exit 1
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

# end-of-file

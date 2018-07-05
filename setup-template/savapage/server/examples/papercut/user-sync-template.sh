#!/bin/bash
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
# -----------------------------------------------------------------------------
#                       THIS IS A TEMPLATE FILE 
#
# Copy this file to a location of your choice, change the parameters below, 
# and restrict file permission: 
#   $ sudo chmod 500 user-sync-custom.sh
#
# When called from PaperCut:
#   $ sudo chown papercut:papercut user-sync-custom.sh
# -----------------------------------------------------------------------------

# HTTP Basic Authentication
readonly _UID=username
readonly _PW=password

# SavaPage Server
readonly _HOST=localhost
readonly _PORT=8632

# -----------------------------------------------------------------------------
# Do not change code below
# -----------------------------------------------------------------------------
readonly _URL_BASE="https://${_UID}:${_PW}@${_HOST}:${_PORT}/ext/papercut"
readonly _URL_S="${_URL_BASE}/user-sync"
readonly _URL_A="${_URL_BASE}/user-auth"
readonly _CURL="curl --insecure --output /dev/stdout --fail --silent -G"

#------------------------------
function _usage {
    echo "invalid arguments"
    exit 9
}

#------------------------------
if (( $# == 0 )); then
	# called as user auth program
    read username
    read password
    ${_CURL} --data-urlencode "username=${username}" \
             --data-urlencode "password=${password}" ${_URL_A}
else 
    if (( $# > 1 )); then
    	# called as user sync program
        case "$2" in
            is-valid|all-users|all-groups)
                ${_CURL} ${_URL_S}/${2}
                ;;
            get-user-details)
                read username
                ${_CURL} --data-urlencode "username=${username}" ${_URL_S}/${2}
                ;;
            group-member-names|group-members)
                if (( $# < 3 )); then
                    _usage
                fi
                ${_CURL} --data-urlencode "groupname=${3}" ${_URL_S}/${2}
                ;;
            is-user-in-group)
                if (( $# < 4 )); then
                    _usage
                fi
                ${_CURL} --data-urlencode "groupname=${3}" \
                         --data-urlencode "username=${4}" ${_URL_S}/${2}
                ;;
            *)
                _usage
                ;;
        esac
    else
        _usage
    fi
fi

exit $?

# end-of-script

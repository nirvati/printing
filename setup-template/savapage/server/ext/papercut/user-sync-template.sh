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
readonly _URL="https://${_UID}:${_PW}@${_HOST}:${_PORT}/ext/papercut/user-sync"
readonly _CURL="curl --insecure --output /dev/stdout --fail --silent -G"

_retval=0

#------------------------------
function user_sync {
    ${_CURL} ${_URL}/${1}
    _retval=$?
}

#------------------------------
function user_sync_1 {
    ${_CURL} --data-urlencode "${2}=${3}" ${_URL}/${1}
    _retval=$?
}

#------------------------------
function user_sync_2 {
    ${_CURL} --data-urlencode "${2}=${3}" \
        --data-urlencode "${4}=${5}" ${_URL}/${1}
    _retval=$?
}

#------------------------------
# Skip first "-" argument
#------------------------------
function main {
   case "$2" in
      is-valid)
         user_sync $2
         ;;
      all-users)
         user_sync $2
         ;;
      all-groups)
         user_sync $2
         ;;
      get-user-details)
         read username
         user_sync_1 $2 "username" "${username}"
         ;;
      group-member-names|group-members)
         user_sync_1 $2 "groupname" "${3}"
         ;;
      is-user-in-group)
         user_sync_2 $2 "groupname" "${3}" "username" "${4}"
         ;;
      *)
         echo "Usage: $0 " \
            "{is-valid|all-users|all-groups|get-user-details|" \
            "group-member-names|group-members|is-user-in-group}"
         _retval=9
         ;;
   esac
}
 
#------------------------------
main $@
exit $_retval

# end-of-script

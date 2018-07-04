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
#   $ sudo chmod 500 user-auth-custom.sh
#
# When called from PaperCut:
#   $ sudo chown papercut:papercut user-auth-custom.sh
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
readonly _URL="https://${_UID}:${_PW}@${_HOST}:${_PORT}/ext/papercut/user-auth"
readonly _CURL="curl --insecure --output /dev/stdout --fail --silent -G"

read username
read password

${_CURL} --data-urlencode "username=${username}" \
         --data-urlencode "password=${password}" ${_URL}
exit $?

# end-of-script

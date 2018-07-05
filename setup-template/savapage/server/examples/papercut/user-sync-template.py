#!/usr/bin/env /usr/bin/python3

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
#   $ sudo chmod 500 user-sync-custom.py
#
# When called from PaperCut:
#   $ sudo chown papercut:papercut user-sync-custom.py
# -----------------------------------------------------------------------------

# HTTP Basic Authentication
_UID = "username"
_PW = "password"

# SavaPage Server
_HOST = "localhost"
_PORT = "8632"

# -----------------------------------------------------------------------------
# Do not change code below
# -----------------------------------------------------------------------------
_URL_BASE = "https://" + _UID + ":" + _PW + "@" + _HOST + ":" + _PORT \
            + "/ext/papercut"
_URL_S = _URL_BASE + "/user-sync"
_URL_A = _URL_BASE + "/user-auth"

import sys
import requests
from requests.packages.urllib3.exceptions import InsecureRequestWarning

requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

def handleRsp(r):
    if r.status_code == 200:
        print(r.text)
        sys.exit(0)
    sys.exit(1)

# Called as user auth program
if len(sys.argv) == 1:
    username = input()
    password = input()    
    handleRsp(requests.get(_URL_A, verify=False, \
        params = (('username', username), ('password', password))))

if len(sys.argv) > 2 and sys.argv[1] == '-':

    # Called as user sync program
    if sys.argv[2] in ("is-valid", "all-users", "all-groups"):
        handleRsp(requests.get(_URL_S + '/' + sys.argv[2], verify=False))

    if sys.argv[2] == "get-user-details":
        username = input()
        handleRsp(requests.get(_URL_S + '/' + sys.argv[2], verify=False, \
            params = (('username', username), ('dummy',''))))

    if sys.argv[2] in ("group-member-names", "group-members") \
        and len(sys.argv) == 4:
        handleRsp(requests.get(_URL_S + '/' + sys.argv[2], verify=False, \
            params = (('groupname', sys.argv[3]), ('dummy',''))))

    if sys.argv[2] == "is-user-in-group" and len(sys.argv) == 5:
        handleRsp(requests.get(_URL_S + '/' + sys.argv[2], verify=False, \
            params = (('groupname', sys.argv[3]), ('username', sys.argv[4]))))

print("Invalid arguments {0}".format(sys.argv), file=sys.stderr)
sys.exit(9)

# end-of-script
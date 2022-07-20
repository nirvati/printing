#!/bin/bash
#
# This file is part of the SavaPage project <https://www.savapage.org>.
# Copyright (c) 2011-2022 Datraverse B.V.
# Author: Rijk Ravestein.
#
# SPDX-FileCopyrightText: 2011-2022 Datraverse B.V. <info@datraverse.com>
# SPDX-License-Identifier: AGPL-3.0-or-later
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
#                       THIS IS A SAMPLE PROGRAM 
#
# Copy this file to a location of your choice, change the parameters below, 
# and restrict file permission: 
#   $ sudo chmod 500 custom-auth-sync-sample.sh
#
# When called from SavaPage:
#   $ sudo chown savapage:savapage custom-auth-sync-sample.sh
# -----------------------------------------------------------------------------

readonly _RET_Y=Y
readonly _RET_N=N
readonly _RET_OK=OK
readonly _RET_ERROR=ERROR

readonly _RFID_LSB=LSB
readonly _RFID_MSB=MSB
readonly _RFID_HEX=HEX
readonly _RFID_DEC=DEC

readonly USER_NAME_1=jbrown
readonly USER_NAME_2=ewhite

readonly USER_PW_1=pwjbrown
readonly USER_PW_2=pwewhite

readonly USER_DETAIL_1="${USER_NAME_1}\tJohn Brown\tjbrown@example.com\t71d56e38\t342355"
readonly USER_DETAIL_2="${USER_NAME_2}\tEllen White\tewhite@example.com\t664a28d1\t837460"

readonly GROUP_NAME_1=Group1
readonly GROUP_NAME_2=Group2
readonly GROUP_NAME_3=Group3

readonly GROUP_DETAIL_1="${GROUP_NAME_1}\tGroup number one"
readonly GROUP_DETAIL_2="${GROUP_NAME_2}\tGroup number two"
readonly GROUP_DETAIL_3="${GROUP_NAME_3}\tGroup number three"

#------------------------------
function _usage {
    echo "invalid arguments"
    exit 9
}

#------------------------------
# User authentication
#------------------------------
if (( $# == 0 )); then
    read username
    read password
    _ret_pw=${_RET_ERROR}
    case "$username" in
        $USER_NAME_1)
            if [ $password == $USER_PW_1 ]; then
                _ret_pw=${_RET_OK}
            fi
            ;;
        $USER_NAME_2)
            if [ $password == $USER_PW_2 ]; then
                _ret_pw=${_RET_OK}
            fi
            ;;
    esac
    echo ${_ret_pw}
    exit $?
fi

#------------------------------
# User synchronization
#------------------------------
case "$1" in
    --rfid-format)
        echo -e "${_RFID_LSB}\t${_RFID_HEX}"
        ;;

    --list-users)
        echo -e "${USER_DETAIL_1}"
        echo -e "${USER_DETAIL_2}"
        ;;

    --list-groups)
        echo -e "${GROUP_DETAIL_1}"
        echo -e "${GROUP_DETAIL_2}"
        echo -e "${GROUP_DETAIL_3}"
        ;;

    --get-user-details)
        if (( $# < 2 )); then
            _usage
        fi
        case "$2" in
            ${USER_NAME_1})
                echo -e "${USER_DETAIL_1}"
                ;;
            ${USER_NAME_2})
                echo -e "${USER_DETAIL_2}"
                ;;
            *)
                ;;
        esac
        ;;

    --get-group-details)
        if (( $# < 2 )); then
            _usage
        fi
        case "$2" in
             ${GROUP_NAME_1})
                echo -e "${GROUP_DETAIL_1}"
                ;;
             ${GROUP_NAME_2})
                echo -e "${GROUP_DETAIL_2}"
                ;;
             ${GROUP_NAME_3})
                echo -e "${GROUP_DETAIL_3}"
                ;;
            *)
                ;;
        esac
        ;;

    --list-group-members)
        if (( $# < 2 )); then
            _usage
        fi
        case "$2" in
            ${GROUP_NAME_1})
                echo -e "${USER_DETAIL_1}"
                ;;
            ${GROUP_NAME_2})
                echo -e "${USER_DETAIL_2}"
                ;;
            ${GROUP_NAME_3})
                echo -e "${USER_DETAIL_1}"
                echo -e "${USER_DETAIL_2}"
                ;;
            *)
                ;;
        esac
        ;;

     --is-group-present)
        if (( $# < 2 )); then
            _usage
        fi
        case "$2" in
           ${GROUP_NAME_1}|${GROUP_NAME_2}|${GROUP_NAME_3})
               echo ${_RET_Y}
               ;;
           *)
               echo ${_RET_N}
               ;;
        esac
        ;;

    --is-user-in-group)
        if (( $# < 3 )); then
            _usage
        fi
        case "$2" in
            ${GROUP_NAME_1})
                case "$3" in
                    ${USER_NAME_1})
                        echo ${_RET_Y}
                        ;;
                    *)
                        echo ${_RET_N}
                        ;;
                    esac
                ;;
           ${GROUP_NAME_2})
                case "$3" in
                    ${USER_NAME_2})
                        echo ${_RET_Y}
                        ;;
                    *)
                        echo ${_RET_N}
                        ;;
                    esac
                ;;
           ${GROUP_NAME_3})
                case "$3" in
                    ${USER_NAME_1}|${USER_NAME_2})
                        echo ${_RET_Y}
                        ;;
                    *)
                        echo ${_RET_N}
                        ;;
                    esac
                ;;
           *)
                echo ${_RET_N}
                ;;
        esac
        ;;

    *)
        _usage
        ;;
esac

exit $?

# end-of-script

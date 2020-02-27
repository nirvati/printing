#
# This file is part of the SavaPage project <https://www.savapage.org>.
# Copyright (c) 2011-2020 Datraverse B.V.
# Author: Rijk Ravestein.
#
# SPDX-FileCopyrightText: 2011-2020 Datraverse B.V. <info@datraverse.com>
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

#----------------------------------------------------------------------
# Common shell functions and defaults
#----------------------------------------------------------------------

APP_NAME="SavaPage CUPS Notifier"

SP_NOTIFIER_NAME=savapage-notifier
CUPS_NOTIFIER_NAME=savapage

HOST_USER=savapage

currentdir="$(dirname "$(test -L "$0" && readlink "$0" || echo "$0")")"

SCRIPT_HOME="`cd \"${currentdir}\"; pwd`"

CUPS_PROVIDER_HOME=`cd "${SCRIPT_HOME}/../../"; pwd`

SP_HOME=`cd "${SCRIPT_HOME}/../../../"; pwd`

# Check the server/bin/linux-* for the architecture
if [ -d "${SP_HOME}/server/bin/linux-x64" ]; then
    ARCH=x64
else
    ARCH=i686
fi

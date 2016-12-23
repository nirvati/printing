#!/bin/sh
#
# This file is part of the SavaPage project <https://savapage.org>.
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
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# For more information, please contact Datraverse B.V. at this
# address: info@datraverse.com
#

#------------------------------------------------------------------------------
# Use the absolute path of this (symlinked) file as installation directory
#------------------------------------------------------------------------------
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

SP_INSTALL_DIR=`dirname ${SP_SELF_PATH}`


usage="_____________________________________________________________________________
SavaPage Install (c) 2010-2016, Datraverse B.V.
		
License: GNU AGPL version 3 or later <https://www.gnu.org/licenses/agpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Usage: "`basename "$0"`" [-h|-i|-e|-l] [-n] [-v] [FILE]...
        -h      This help text.
        -i      Install after extracting the files (default).
        -n      Non-interactive install: execute MUST-RUN-AS-ROOT afterwards.
        -e      Extract all files or a FILE list and exit without installing. 
        -l      List the contents of the archive and exit without extracting.
        -v      Verbose. Print the names of the files as they are extracted."

#
# Defaults
#
action="install"
verbose="no"
non_interactive_switch=""

#
# Parse arguments
#
while test $# -gt 0
do
        case "$1" in
            -h)
                echo "${usage}"
                exit 0;
                ;;
                
            -e)
                action="extract"
                ;;

            -i)
                action="install"
                ;;

            -l)
                action="list"
                ;;

            -n)
                non_interactive_switch="-n"
                ;;

            -v)
                verbose="yes"
                ;;

            --)
                shift
                break
                ;;

            -*)
                echo "${usage}" 1>&2
                exit 1
                ;;

            *)
                break
                ;;
        esac
        shift
done

#
# Build the unarchive command
#
unarchive="tar "
if test "${action}" = "list"
then
        unarchive="${unarchive}t"
else
        unarchive="${unarchive}x"
fi

if test "${verbose}" = "yes"
then
        unarchive="${unarchive}v"
fi

unarchive="${unarchive}f -"

#
# Check that our tools are available
#
whichcmd=`which which 2>/dev/null`
if test -z "${whichcmd}"
then
        echo "ERROR: The utility 'which' is required to extract and install." >&2
        exit 1
fi
unpacktool=`which "gunzip" 2>/dev/null`
if test -z "${unpacktool}"
then
        echo "ERROR: The utility gunzip is required to extract and install." >&2
        echo "Please install gzip so gunzip is available." >&2
        exit 1
fi

#
# If installing, we extract to a temporary directory
#
if test "${action}" = "install"
then
        if test -z "${TMPDIR}"
        then
                SP_EXTRACT_DIR=/tmp/sp$$/
        else
                SP_EXTRACT_DIR="${TMPDIR}/sp$$"
        fi
        mkdir "${SP_EXTRACT_DIR}"
fi

#
# Extract the archive
#
echo "Extracting... (this may take some time)"

#-----------------------------------------------------------------------
SKIP=`awk '/^__TARFILE_FOLLOWS__/ { print NR + 1; exit 0; }' $0`

#remember our file name
THIS=`pwd`/$0

# take the tarfile and pipe it into tar
tail -n +$SKIP $THIS | gunzip | (cd "${SP_EXTRACT_DIR}"; ${unarchive} $*)
#-----------------------------------------------------------------------

if test $? -ne 0
then
        echo "ERROR: extraction failed" >&2
        exit 1
fi

#
# Run the install script
#
if test "${action}" = "install" -a -f "${SP_EXTRACT_DIR}/savapage/install"
then
        chmod 755 "${SP_EXTRACT_DIR}/savapage/install"
        "${SP_EXTRACT_DIR}/savapage/install" -d "${SP_INSTALL_DIR}" ${non_interactive_switch}
        #
        # Remove the temp extracted archive after install completed
        #
        rm -fr "${SP_EXTRACT_DIR}"
fi
exit 0

# NOTE: Don't place any newline characters after the last line below.
__TARFILE_FOLLOWS__

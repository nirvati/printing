#!/bin/sh
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

#--------------------------------------------------------------------
# Get the absolute path of this (symlinked) file
#--------------------------------------------------------------------
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
_CURRENTDIR=`dirname ${SP_SELF_PATH}`

#--------------------------------------------------------------------
. ${_CURRENTDIR}/pkg-settings

#=========================================================================
# CONSTANTS
#=========================================================================
DIST_HOME=${_DIST_HOME_DERBY}

#----------------------------------------
# Remove old distribution
#----------------------------------------
rm -rf ${DIST_HOME}

#----------------------------------------
# Create again ...
#----------------------------------------
mkdir --parent ${DIST_HOME}/sql

#=======================================================================
# 
#=======================================================================
readonly SCHEMA_VERSION="$(${_DIST_HOME_INTERNAL}/bin/savapage-util --db-version)"

echo "+-----------------------------------------------------------------"
echo "| Initializing Derby Database version ${SCHEMA_VERSION} ..."
echo "+-----------------------------------------------------------------"
${_DIST_HOME_INTERNAL}/bin/savapage-util --db-type Internal --db-create --server-home ${DIST_HOME}

#-----------------------------------------------------------------------------
# NOTE: created scripts can be used to manually compose an update script.
#-----------------------------------------------------------------------------

#------------------------------------
SCHEMA_DB_TYPE=Internal
SCHEMA_DB_HOME_NAME=Derby
 
echo "+---------------------------------------------------------------------"
echo "| Creating drop and create SQL scripts for ${SCHEMA_DB_HOME_NAME} schema version ${SCHEMA_VERSION} ..."
echo "+---------------------------------------------------------------------"
${_DIST_HOME_INTERNAL}/bin/savapage-util --db-type ${SCHEMA_DB_TYPE} --db-sql-create "${DIST_HOME}/sql/create-${SCHEMA_VERSION}.sql" --db-sql-drop "${DIST_HOME}/sql/drop-${SCHEMA_VERSION}.sql"

echo "+---------------------------------------------------------------------"
echo "| Copying SQL scripts to ${_SETUP_TEMPLATE_HOME} ..."
echo "+---------------------------------------------------------------------"
cp "${DIST_HOME}"/sql/*.sql ${_SETUP_TEMPLATE_HOME}/server/lib/sql/${SCHEMA_DB_HOME_NAME}

#------------------------------------
# PostgreSQL
#------------------------------------
SCHEMA_DB_TYPE=PostgreSQL
SCHEMA_DB_HOME_NAME=PostgreSQL

DIST_HOME=${_DIST_HOME_POSTGRES}
rm -rf ${DIST_HOME}
mkdir --parent ${DIST_HOME}/sql

echo "+---------------------------------------------------------------------"
echo "| Creating drop and create SQL scripts for ${SCHEMA_DB_HOME_NAME} schema version ${SCHEMA_VERSION} ..."
echo "+---------------------------------------------------------------------"
${_DIST_HOME_INTERNAL}/bin/savapage-util --db-type ${SCHEMA_DB_TYPE} --db-sql-create "${DIST_HOME}/sql/create-${SCHEMA_VERSION}.sql" --db-sql-drop "${DIST_HOME}/sql/drop-${SCHEMA_VERSION}.sql"

echo "+---------------------------------------------------------------------"
echo "| Copying  SQL scripts to ${_SETUP_TEMPLATE_HOME} ..."
echo "+---------------------------------------------------------------------"
cp "${DIST_HOME}"/sql/*.sql ${_SETUP_TEMPLATE_HOME}/server/lib/sql/${SCHEMA_DB_HOME_NAME}

# end-of-file

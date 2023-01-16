<!-- 
    SPDX-FileCopyrightText: 2011-2020 Datraverse BV <info@datraverse.com>
    SPDX-FileCopyrightText: 2023 Aaron Dewes <aaron@runcitadel.space>
    SPDX-License-Identifier: AGPL-3.0-or-later 
-->

# Nirvati Printing

An open source print server for Nirvati.

---

### License

This module is part of Nirvati, and specifically, the Nirvati Print Server.

The Nirvati Print Server is based on the SavaPage project <https://www.savapage.org>,
copyright (c) 2011-2020 Datraverse B.V. and licensed under the
[GNU Affero General Public License (AGPL)](https://www.gnu.org/licenses/agpl.html)
version 3, or (at your option) any later version.

[<img src="./img/reuse-horizontal.png" title="REUSE Compliant" alt="REUSE Software" height="25"/>](https://reuse.software/)

### System Requirements

0. Open JDK 1.8+

        $ sudo apt-get install openjdk-8-jdk

0. Maven 3

        $ sudo apt-get install maven
        
0. GNU project C/C++ compiler and make
               
        $ sudo apt-get install g++ make

0. pkg-config: a system for managing library compile and link flags

        $ sudo apt-get install pkg-config

0. zip: archiver for .zip files

        $ sudo apt-get install zip


### Install prerequisite packages

* savapage-nfc-reader
    
        $ sudo apt-get install libpcsclite-dev
        
* savapage-cups-notifier
    
        $ sudo apt-get install libcups2-dev
            
* savapage-pam
    
        $ sudo apt-get install libpam0g-dev
                            

### Build

    $ ./build.sh all-x64

* Check the `target` directory for the result.
* Build messages are captured in `build.log` 


### Setup template

The `setup-template` directory contains the fixed files of the build target binary.

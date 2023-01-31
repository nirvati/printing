<!-- 
    SPDX-FileCopyrightText: © 2020 Datraverse BV <info@datraverse.com> 
    SPDX-License-Identifier: AGPL-3.0-or-later 
-->

# Running SavaPage server in Eclipse

The `server.home.template` directory contains files needed to run `printing-server` in Eclipse. 

Copy the content to `printing-server/server.home` 

The files below have placeholder content, so consult the content of each file 
and read the instructions carefully.

  * `server.home/server.properties`
  * `server.home/lib/log4j.properties` 
 
In addition the files from the sections below must be copied to `printing-server/` from other places. 

## PPD file

Make and copy PPD files:

    cd savapage-ppd
    make
    mkdir ../printing-server/client.home
    cp ppd/SAVAPAGE.ppd ../printing-server/client.home/SAVAPAGE.ppd


## Encryption files

Copy from an existing installation:
 
    cd printing-server/server.home/data

    sudo cp /opt/savapage/server/data/default-ssl-keystore* .
    sudo cp /opt/savapage/server/data/encryption.properties .

    sudo chown ${USER}: default-ssl-keystore*
    sudo chown ${USER}: encryption.properties*
 

## jmx

Edit `jmxremote.properties` and enter the `[edit this full path to]/printing-server`
     
    # Password file read access must be restricted
    chmod 600 jmxremote.password
 
## Derby database

Copy the empty database from `savapage-make/target`

    cd printing-server/server.home/data/internal
    cp -R savapage-make/target/savapage-*.*.*-derby/data/internal/Derby .
 
 
## C/C++ binaries

Make and copy executables:

    cd savapage-nss
    make
    cp target/savapage-nss ../printing-server/server.home/bin/linux-x64
    
    cd savapage-pam
    make
    cp target/savapage-pam ../printing-server/server.home/bin/linux-x64


## The CUPS notifier

Make and copy executable:

    cd savapage-cups-notifier
    make
    sudo cp target/savapage-notifier /usr/lib/cups/notifier/savapage-dev

And add the following line to `server.properties` file:

    # Used when cups.notification.method=push
    # default: savapage
    cups.notifier=savapage-dev




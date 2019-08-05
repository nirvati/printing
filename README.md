# savapage-make
    
Environment used by [Development Partners](https://wiki.savapage.org/doku.php?id=roles) to produce SavaPage.
 
### License

This module is part of the SavaPage project <https://www.savapage.org>,
copyright (c) 2011-2018 Datraverse B.V. and licensed under the
[GNU Affero General Public License (AGPL)](https://www.gnu.org/licenses/agpl.html)
version 3, or (at your option) any later version.

### Join Efforts, Join our Community

SavaPage Software is produced by Community Partners and consumed by Community Members. If you want to modify and/or distribute our source code, please join us as Development Partner. By joining the [SavaPage Community](https://wiki.savapage.org) you can help build a truly Libre Print Management Solution. Please contact [info@savapage.org](mailto:info@savapage.org).

### Issue Management

[https://issues.savapage.org](https://issues.savapage.org)

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

0. pgpgpg: wrapper for using GnuPG in programs designed for PGP

        $ sudo apt-get install pgpgpg


### Getting started

0. Create a directory for all SavaPage repositories.
  
        $ mkdir -p ~/savapage/repos
   
   
0. Clone repositories.

    Create a shell script `~/savapage/repos/init.sh` with the following content:
            
        #!/bin/sh
        _REPOS_GIT_PUBLIC="savapage/savapage-client
            savapage/savapage-common
            savapage/savapage-core
            savapage/savapage-cups-notifier
            savapage/savapage-ext
            savapage-ext/savapage-ext-blockchain-info
            savapage-ext/savapage-ext-mollie
            savapage-ext/savapage-ext-notification
            savapage-ext/savapage-ext-oauth
            savapage-i18n/savapage-i18n-de
            savapage-i18n/savapage-i18n-en
            savapage-i18n/savapage-i18n-es
            savapage-i18n/savapage-i18n-fr
            savapage-i18n/savapage-i18n-nl
            savapage-i18n/savapage-i18n-pl
            savapage-i18n/savapage-i18n-ru
            savapage/savapage-server
            savapage/savapage-make
            savapage/savapage-nfc-reader
            savapage/savapage-nss
            savapage/savapage-pam
            savapage/savapage-ppd
            savapage/savapage-util
            savapage/xmlrpcpp"        
        for repo in $_REPOS_GIT_PUBLIC
        do
            git clone https://gitlab.com/${repo}.git
            # ... or when you have ssh access
            # git clone git@gitlab.com:/${repo}.git
        done

    Execute the script:
    
        $ cd ~/savapage/repos
        $ sh ./init.sh
    
    Remove the script:

        $ rm ~/savapage/repos/init.sh


0. Checkout master or develop branch of all repositories.

        $ cd ~/savapage/repos/savapage-make
                
        # check out master branch with latest published release
        $ git checkout master
        $ ./dev-git-all.sh "checkout master"
        
        # check out develop branch
        $ git checkout develop
        $ ./dev-git-all.sh "checkout develop"

0. Initialize directory structure for drop-in components (optional).

        $ cd ~/savapage
        $ ./repos/savapage-make/dev-init.sh
        

### Install prerequisite packages

* savapage-nfc-reader
    
        $ sudo apt-get install libpcsclite-dev
        
* savapage-cups-notifier
    
        $ sudo apt-get install libcups2-dev
            
* savapage-pam
    
        $ sudo apt-get install libpam0g-dev
                            

### Build

    $ cd ~/savapage/repos/savapage-make
    $ ./build.sh all-x64

* Check the `~/savapage/repos/savapage-make/target` directory for the result.
* Build messages are captured in `~/savapage/repos/savapage-make/build.log` 


### Setup template

The `setup-template` directory contains the fixed files of the build target binary.

#### savapage/providers/nfc/linux-armv6 

This directory contains the install and sample files for the Raspberry Pi NFC Reader. See the `savapage-nfc-reader` project.

Source links of the sample wav files:

* wav-card-swipe : [button-47.wav](http://www.soundjay.com/button/button-47.wav)
* wav-server-accept : [chime.wav](http://www.wavsource.com/)
* wav-server-deny : [beep-3.wav](http://www.soundjay.com/button/beep-3.wav)
* wav-server-disconnect : [disconnect_11.wav](http://www.wavsource.com/)
* wav-server-exception : [buzzer_x.wav](http://www.wavsource.com/)

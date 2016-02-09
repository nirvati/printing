# savapage-make
    
Environment used by [Development Partners](http://savapage.org/w/index.php/Roles) to produce SavaPage.
 
### License

This module is part of the SavaPage project <http://savapage.org>,
copyright (c) 2011-2016 Datraverse B.V. and licensed under the
[GNU Affero General Public License (AGPL)](https://www.gnu.org/licenses/agpl.html).

### Join Efforts, Join our Community

SavaPage Software is produced by Community Partners and consumed by Community Fellows. If you want to modify and/or distribute our source code, please join us as Development Partner. By joining the [SavaPage Community](http://savapage.org/w/) you can help build a truly Libre Print Management Solution. Please contact [info@savapage.org](mailto:info@savapage.org).

### Issue Management

[https://secure.datraverse.nl/issues/](https://secure.datraverse.nl/issues/)

### System Requirements

0. Open JDK 1.7+

        $ sudo apt-get install openjdk-7-jdk

0. Maven 3

        $ sudo apt-get install maven
        
0. GNU project C and C++ compiler
               
        $ sudo apt-get install g++


### Getting started

0. Create a directory for all SavaPage repositories.
  
        $ mkdir -p ~/savapage/repos
   
   
0. Clone repositories.

    Create a shell script `~/savapage/repos/init.sh` with the following content:
            
        #!/bin/sh
        _REPOS_GIT_PUBLIC="savapage-client
            savapage-common
            savapage-core
            savapage-cups-notifier
            savapage-ext
            savapage-ext-mollie
            savapage-ext-blockchain-info
            savapage-i18n-de
            savapage-server
            savapage-make
            savapage-nfc-reader
            savapage-nss
            savapage-pam
            savapage-ppd
            savapage-util
            xmlrpcpp"        
        for repo in $_REPOS_GIT_PUBLIC
        do
            git clone https://gitlab.com/savapage/${repo}.git
            # ... or when you have ssh access
            # git clone git@gitlab.com:/savapage/${repo}.git
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

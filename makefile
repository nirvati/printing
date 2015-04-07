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

REPO_HOME:=..
REPO_HOME_PUB:=$(REPO_HOME)
REPO_COMMON:=$(REPO_HOME_PUB)/savapage-common

#
PRODUCT_VERSION:=$(shell $(REPO_COMMON)/VERSION.sh)

TRG_HOME:=target

# 
C_TRG:= $(TRG_HOME)/$(shell ./dev-arch.sh)

.PHONY: help
help:
	@echo "+------------------------------------------------------+"
	@echo "| Please specify one of the targets below.             |"
	@echo "+------------------------------------------------------+"
	@echo "| all       : init-base package-i686 package-x64       |"
	@echo "| all-x64   : init-base package-x64                    |"
	@echo "| jar-patch : create .tar.gz with *.jar, *.war files   |"
	@echo "+------------------------------------------------------+"

.PHONY: all
all: init-base package-i686 package-x64

.PHONY: all-x64
all-x64: init-base package-x64

.PHONY: jar-patch
jar-patch: clean-patch mvn-package-patch pkg-prepare package-patch 

# Initializes a clean base for packaging
.PHONY: init-base
init-base: clean init cbuild ppd mvn-package pkg-internal pkg-database pkg-prepare  

.PHONY: init
init:
	@mkdir -p $(C_TRG)

# Just the x64 package
.PHONY: test-prep
test-prep: clean mvn-package pkg-internal pkg-prepare 

#
.PHONY: checksums
checksums:
	@openssl dgst -sha1 $(TRG_HOME)/savapage-setup-$(PRODUCT_VERSION)-linux-i686.bin $(TRG_HOME)/savapage-setup-$(PRODUCT_VERSION)-linux-x64.bin  

# Minimal target for generating derby create*.sql and drop*.sql scripts 
.PHONY: db
db: clean mvn-package pkg-internal pkg-database

.PHONY: clean
clean: cleanc mvn-clean
	rm -rf $(TRG_HOME)

.PHONY: clean-patch
clean-patch:
	@make -C $(REPO_HOME_PUB)/savapage-common clean
	@make -C $(REPO_HOME_PUB)/savapage-core clean
	@make -C $(REPO_HOME_PUB)/savapage-client clean
	@make -C $(REPO_HOME_PUB)/savapage-server clean

#----------------------------------------------------------------------
# Note the INSTALL of savapage-common and savapage-core, this makes the 
# pom/jar part of the LOCAL maven repository, so the other maven projects 
# can resolve this dependency. 
#----------------------------------------------------------------------
.PHONY: mvn-package
mvn-package: mvn-package-patch 
	@make -C $(REPO_HOME_PUB)/savapage-util repackage

.PHONY: mvn-package-patch
mvn-package-patch:
	@make -C $(REPO_HOME_PUB)/savapage-common install
	@make -C $(REPO_HOME_PUB)/savapage-core install
	@make -C $(REPO_HOME_PUB)/savapage-client repackage
	@make -C $(REPO_HOME_PUB)/savapage-server repackage

.PHONY: mvn-clean
mvn-clean: 
	@make -C $(REPO_HOME_PUB)/savapage-util clean

#----------------------------------------
# 
#----------------------------------------
.PHONY: pkg-internal
pkg-internal: 
	./pkg-internal.sh

#----------------------------------------
# Create Derby database
#----------------------------------------
.PHONY: pkg-database
pkg-database:
	./pkg-database.sh
		
#----------------------------------------
# Packaging
#----------------------------------------
.PHONY: pkg-prepare
pkg-prepare:
	./pkg-prepare.sh
		
.PHONY: package-i686
package-i686:
	./pkg-setup.sh i686

.PHONY: package-x64
package-x64: 
	./pkg-setup.sh x64

.PHONY: package-patch
package-patch:
	./pkg-patch.sh

#----------------------------------------
# ppd
#----------------------------------------
.PHONY: ppd
ppd:
	@make -C $(REPO_HOME_PUB)/savapage-ppd PRODUCT_VERSION=$(PRODUCT_VERSION)

#----------------------------------------
# c binaries
#----------------------------------------
$(C_TRG):
	mkdir -p $(C_TRG)

.PHONY: cbuild
cbuild: $(C_TRG) binaries savapage-pam savapage-nss savapage-notifier

.PHONY: savapage-nfc-reader
savapage-nfc-reader: $(C_TRG)/savapage-nfc-reader

.PHONY: savapage-notifier
savapage-notifier: $(C_TRG)/savapage-notifier

.PHONY: savapage-pam
savapage-pam: $(C_TRG)/savapage-pam

.PHONY: savapage-ps
savapage-ps: $(C_TRG)/savapage-ps

.PHONY: savapage-nss
savapage-nss: $(C_TRG)/savapage-nss

.PHONY: binaries
binaries:
	@make -C $(REPO_HOME_PUB)/xmlrpcpp	
	@make -C $(REPO_HOME_PUB)/savapage-nfc-reader PRODUCT_VERSION=$(PRODUCT_VERSION)
	@make -C $(REPO_HOME_PUB)/savapage-cups-notifier PRODUCT_VERSION=$(PRODUCT_VERSION)
	@make -C $(REPO_HOME_PUB)/savapage-nss  PRODUCT_VERSION=$(PRODUCT_VERSION) 
	@make -C $(REPO_HOME_PUB)/savapage-pam  PRODUCT_VERSION=$(PRODUCT_VERSION)

$(C_TRG)/savapage-nfc-reader: $(REPO_HOME_PUB)/savapage-nfc-reader/target/savapage-nfc-reader
	@cp $< $@
	
$(C_TRG)/savapage-notifier: $(REPO_HOME_PUB)/savapage-cups-notifier/target/savapage-notifier
	@cp $< $@

$(C_TRG)/savapage-nss: $(REPO_HOME_PUB)/savapage-nss/target/savapage-nss
	@cp $< $@

$(C_TRG)/savapage-pam: $(REPO_HOME_PUB)/savapage-pam/target/savapage-pam
	@cp $< $@

.PHONY: cleanc
cleanc:
	@rm -f $(C_TRG)/savapage-pam
	@rm -f $(C_TRG)/savapage-nss
	@rm -f $(C_TRG)/savapage-notifier
	@make -C $(REPO_HOME_PUB)/xmlrpcpp clean	
	@make -C $(REPO_HOME_PUB)/savapage-nfc-reader clean
	@make -C $(REPO_HOME_PUB)/savapage-cups-notifier clean
	@make -C $(REPO_HOME_PUB)/savapage-nss clean
	@make -C $(REPO_HOME_PUB)/savapage-pam clean

# end-of-file

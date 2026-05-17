# Fallback Theos installation path when environment variables are not set
THEOS ?= $(HOME)/theos
THEOS_MAKE_PATH ?= $(THEOS)/makefiles

# Basic environment configuration

export SYSROOT = $(THEOS)/sdks/iPhoneOS16.5.sdk/
export TARGET = iphone:clang:latest:15.0
export ROOTLESS = 1

# Theos optimisations

export FINALPACKAGE = 1
export DEBUG = 0
export THEOS_LEAN_AND_MEAN = 1
export USING_JINX = 1

# Define subprojects

SUBPROJECTS += Tweak

# Theos makefiles to include

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

# Rootless support? with a question mark

ifeq ($(ROOTLESS),1)
internal-stage::
	@$(PRINT_FORMAT_MAKING) "Moving files to rootless paths"
	@mkdir -p "$(THEOS_STAGING_DIR)/var/jb/Library"
	@if [ -d "$(THEOS_STAGING_DIR)/Library" ]; then \
		mv "$(THEOS_STAGING_DIR)/Library" "$(THEOS_STAGING_DIR)/var/jb"; \
	fi

before-package::
	@$(PRINT_FORMAT_MAKING) "Fixing Debian control directory permissions"
	$(ECHO_NOTHING)chmod 755 "$(THEOS_STAGING_DIR)/DEBIAN"$(ECHO_END)
	@$(PRINT_FORMAT_MAKING) "Fixing Debian maintainer script permissions"
	$(ECHO_NOTHING)chmod 755 "$(THEOS_STAGING_DIR)/DEBIAN/postinst"$(ECHO_END)
	@$(PRINT_FORMAT_MAKING) "Patching control file architecture"
	$(ECHO_NOTHING)sed -i 's/^Architecture: iphoneos-arm$$/Architecture: iphoneos-arm64e/' "$(THEOS_STAGING_DIR)/DEBIAN/control"$(ECHO_END)
endif

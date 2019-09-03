ARCHS = arm64 arm64e

DEBUG = 0
FINALPACKAGE = 1

INSTALL_TARGET_PROCESSES = com.apple.mobilephone

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LongerCallButton

LongerCallButton_FILES = Tweak.xm
LongerCallButton_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

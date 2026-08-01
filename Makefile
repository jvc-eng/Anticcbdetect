TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = ccbDemo

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AntiCCBDetect

AntiCCBDetect_FILES = Tweak.xm fishhook.c
AntiCCBDetect_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

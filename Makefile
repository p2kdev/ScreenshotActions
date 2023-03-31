export THEOS_PACKAGE_SCHEME=rootless
export TARGET = iphone:clang:12.4:12.0

include $(THEOS)/makefiles/common.mk
export ARCHS = arm64 arm64e

TWEAK_NAME = ScreenshotActions
$(TWEAK_NAME)_FILES = Tweak.xm MLIMGURUploader.m
$(TWEAK_NAME)_FRAMEWORKS = UIKit
$(TWEAK_NAME)_CFLAGS = -Wno-deprecated-declarations -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 ScreenshotServicesService || true"
	install.exec "killall -9 SpringBoard || true"

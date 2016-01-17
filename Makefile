TWEAK_NAME = CalculatorCopy

CalculatorCopy_FILES = $(wildcard ./*.*m)

export TARGET = iphone:clang
export ARCHS = armv7 arm64
export SDKVERSION = 9.0
export ADDITIONAL_OBJCFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"

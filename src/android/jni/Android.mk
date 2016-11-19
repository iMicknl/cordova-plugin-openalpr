LOCAL_PATH := $(call my-dir)
LIB_PATH := $(LOCAL_PATH)/lib/armeabi-v7a

include $(CLEAR_VARS)

LOCAL_MODULE := leptonica
LOCAL_SRC_FILES := $(LIB_PATH)/liblept.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := tesseract
LOCAL_SRC_FILES := $(LIB_PATH)/libtess.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := libpngt
LOCAL_SRC_FILES := $(LIB_PATH)/libpngt.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := libjpgt
LOCAL_SRC_FILES := $(LIB_PATH)/libjpgt.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := simpleini
LOCAL_SRC_FILES := $(LIB_PATH)/libsimpleini.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := support
LOCAL_SRC_FILES := $(LIB_PATH)/libsupport.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := openalpr
LOCAL_SRC_FILES := $(LIB_PATH)/libopenalpr-static.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)

OPENCV_INSTALL_MODULES:=on
OPENCV_CAMERA_MODULES:=off

include /path/to/OpenCV.mk

LOCAL_MODULE := openalprjni
LOCAL_SRC_FILES := $(LOCAL_PATH)/lib/openalprjni.cpp
LOCAL_SHARED_LIBRARIES += tesseract leptonica libjpgt libpngt
LOCAL_STATIC_LIBRARIES += openalpr support simpleini
LOCAL_LDLIBS := -llog

include $(BUILD_SHARED_LIBRARY)

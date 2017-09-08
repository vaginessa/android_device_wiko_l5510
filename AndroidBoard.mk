LOCAL_PATH := $(call my-dir)

#----------------------------------------------------------------------
# extra images
#----------------------------------------------------------------------
include build/core/generate_extra_images.mk

#----------------------------------------------------------------------
# Radio image
#----------------------------------------------------------------------
ifeq ($(ADD_RADIO_FILES), true)
radio_dir := $(LOCAL_PATH)/radio
RADIO_FILES := $(shell cd $(radio_dir) ; ls)
$(foreach f, $(RADIO_FILES), \
    $(call add-radio-file,radio/$(f)))

INSTALLED_RADIOIMAGE_TARGET += $(TARGET_BOOTLOADER_EMMC_INTERNAL)
$(call add-radio-file,images/emmc_appsboot.mbn)
$(call add-radio-file,images/hyp.mbn)
$(call add-radio-file,images/rpm.mbn)
$(call add-radio-file,images/sbl1.mbn)
$(call add-radio-file,images/tz.mbn)
endif

#Create symbolic links
$(shell mkdir -p $(TARGET_OUT)/vendor/lib; \
        rm $(TARGET_OUT)/vendor/lib/libEGL_adreno.so; \
        ln -sf /system/vendor/lib/egl/libEGL_adreno.so \
        $(TARGET_OUT)/vendor/lib/libEGL_adreno.so)

# Hack for build
$(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libminui_intermediates)
$(shell touch $(OUT)/obj/SHARED_LIBRARIES/libminui_intermediates/export_includes)

# Create a link for the WCNSS config file, which ends up as a writable
# version in /data/misc/wifi

$(shell mkdir -p $(TARGET_OUT_ETC)/firmware/wlan/prima; \
    ln -sf /system/etc/wifi/WCNSS_qcom_wlan_nv.bin \
    $(TARGET_OUT_ETC)/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin; \
    ln -sf /data/misc/wifi/WCNSS_qcom_cfg.ini \
    $(TARGET_OUT_ETC)/firmware/wlan/prima/WCNSS_qcom_cfg.ini)

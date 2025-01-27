# Enable build support for NFC open source vendor modules
ifeq ($(call is-board-platform-in-list, sdm845 sdm710 msmnile $(MSMSTEPPE) $(TRINKET) kona lito bengal atoll lahaina holi monaco),true)
TARGET_USES_NQ_NFC := true
# Disable NFC on targets matching the TARGET_PRODUCT value in the list
ifeq ($(filter $(TARGET_PRODUCT), bengal_32 bengal_32go),$(TARGET_PRODUCT))
TARGET_USES_NQ_NFC := false
endif
endif

NQ_VENDOR_NFC += vendor.nxp.hardware.nfc@2.0-service
NQ_VENDOR_NFC += nfc_nci.nqx.default.hw

ifeq ($(strip $(TARGET_USES_NQ_NFC)),true)
ifneq ($(TARGET_NFC_SKU),)
NFC_PERMISSIONS_DIR := $(TARGET_COPY_OUT_ODM)/etc/permissions/sku_$(TARGET_NFC_SKU)
else
NFC_PERMISSIONS_DIR := $(TARGET_COPY_OUT_VENDOR)/etc/permissions
endif
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(NFC_PERMISSIONS_DIR)/com.nxp.mifare.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(NFC_PERMISSIONS_DIR)/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(NFC_PERMISSIONS_DIR)/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(NFC_PERMISSIONS_DIR)/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(NFC_PERMISSIONS_DIR)/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(NFC_PERMISSIONS_DIR)/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(NFC_PERMISSIONS_DIR)/android.hardware.nfc.uicc.xml \
    vendor/nxp/opensource/sn100x/halimpl/SN100x/halimpl/libnfc-nci.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci.conf

PRODUCT_PACKAGES += $(NQ_VENDOR_NFC)
endif


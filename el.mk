# Copyright (C) 2020-2021 Pavel Dubrova <pashadubrova@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Offline charger
PRODUCT_COPY_FILES += \
    vendor/el/charger/res/animation.txt:$(TARGET_COPY_OUT_PRODUCT)/etc/res/values/charger/animation.txt \
    vendor/el/charger/res/battery_fail.png:$(TARGET_COPY_OUT_PRODUCT)/etc/res/images/charger/battery_fail.png \
    vendor/el/charger/res/battery_scale.png:$(TARGET_COPY_OUT_PRODUCT)/etc/res/images/charger/battery_scale.png \
    vendor/el/charger/res/main_font.png:$(TARGET_COPY_OUT_PRODUCT)/etc/res/images/charger/main_font.png \

# Extra packages
PRODUCT_PACKAGES += \
    ExactCalculator \
    SnapdragonCamera \
    SnapdragonGallery \
    SnapdragonMusic

# Include additional build utilities
include vendor/el/build/utils.mk

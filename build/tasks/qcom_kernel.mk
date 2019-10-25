# Copyright (C) 2019 Pavel Dubrova <pashadubrova@gmail.com>
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

ifeq ($(TARGET_COMPILE_WITH_MSM_KERNEL),true)
#----------------------------------------------------------------------
# Host compiler configs
#----------------------------------------------------------------------
SOURCE_ROOT := $(shell pwd)
TARGET_HOST_COMPILER_PREFIX_OVERRIDE := prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.17-4.8/bin/x86_64-linux-
TARGET_HOST_CC_OVERRIDE := $(TARGET_HOST_COMPILER_PREFIX_OVERRIDE)gcc
TARGET_HOST_CXX_OVERRIDE := $(TARGET_HOST_COMPILER_PREFIX_OVERRIDE)g++
TARGET_HOST_AR_OVERRIDE := $(TARGET_HOST_COMPILER_PREFIX_OVERRIDE)ar
TARGET_HOST_LD_OVERRIDE := $(TARGET_HOST_COMPILER_PREFIX_OVERRIDE)ld

TARGET_KERNEL_MAKE_ENV += HOSTCC=$(SOURCE_ROOT)/$(TARGET_HOST_CC_OVERRIDE)
TARGET_KERNEL_MAKE_ENV += HOSTAR=$(SOURCE_ROOT)/$(TARGET_HOST_AR_OVERRIDE)
TARGET_KERNEL_MAKE_ENV += HOSTLD=$(SOURCE_ROOT)/$(TARGET_HOST_LD_OVERRIDE)
TARGET_KERNEL_MAKE_ENV += HOSTCFLAGS="-I/usr/include -I/usr/include/x86_64-linux-gnu -L/usr/lib -L/usr/lib/x86_64-linux-gnu"
TARGET_KERNEL_MAKE_ENV += HOSTLDFLAGS="-L/usr/lib -L/usr/lib/x86_64-linux-gnu"
TARGET_KERNEL_MAKE_ENV += PERL=/usr/bin/perl

#----------------------------------------------------------------------
# Define defconfig
#----------------------------------------------------------------------
ifeq ($(KERNEL_DEFCONFIG),)
   ifeq ($(TARGET_BUILD_VARIANT),user)
     KERNEL_DEFCONFIG := $(PRODUCT_PLATFORM)_$(PRODUCT_DEVICE)-perf_defconfig
   else
     KERNEL_DEFCONFIG := $(PRODUCT_PLATFORM)_$(PRODUCT_DEVICE)_defconfig
   endif
endif

#----------------------------------------------------------------------
# Check if all necessary flags have been defined
#----------------------------------------------------------------------
ifeq ($(TARGET_KERNEL_SOURCE),)
    $(error Kernel sorce path not defined, cannot build kernel)
else
    $(warning Kernel source tree path is: $(TARGET_KERNEL_SOURCE))
endif

ifeq ($(TARGET_KERNEL_VERSION),)
    $(error Kernel version not defined, cannot build kernel)
else
    $(warning Kernel version is: $(TARGET_KERNEL_VERSION))
endif

ifeq ($(KERNEL_DEFCONFIG),)
    $(error Kernel defconfig not defined, cannot build kernel)
else
    $(warning Kernel defconfig is: $(KERNEL_DEFCONFIG))
endif

#----------------------------------------------------------------------
# Compile Linux Kernel
#----------------------------------------------------------------------
include $(TARGET_KERNEL_SOURCE)/AndroidKernel.mk

$(INSTALLED_KERNEL_TARGET): $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)

#----------------------------------------------------------------------
# Override default make with prebuilt make path (if any)
#----------------------------------------------------------------------
ifneq (, $(wildcard $(shell pwd)/prebuilts/build-tools/linux-x86/bin/make))
    MAKE := $(shell pwd)/prebuilts/build-tools/linux-x86/bin/$(MAKE)
endif

endif # TARGET_COMPILE_WITH_MSM_KERNEL

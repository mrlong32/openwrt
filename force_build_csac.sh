#!/bin/bash
echo "=== 强制编译 CSAC 固件 ==="
# 确保使用正确的配置
cp .config.csac.sample .config
# 强制设置 CSAC 设备
echo "CONFIG_TARGET_DEVICE_ath79_generic_csac_router=y" >> .config
echo "CONFIG_TARGET_PROFILE=DEVICE_csac-router" >> .config
# 编译
make defconfig
make download -j$(nproc)
make -j$(nproc) || make -j1 V=s
# 显示结果
echo "=== 编译完成 ==="
ls -la bin/targets/ath79/generic/ | grep -i csac
